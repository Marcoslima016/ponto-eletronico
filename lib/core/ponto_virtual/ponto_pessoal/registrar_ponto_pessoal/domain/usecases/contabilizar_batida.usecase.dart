import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../../lib.imports.dart';
import '../../../../ponto_virtual.imports.dart';

abstract class IContabilizarBatida {
  Future call({@required bool printLog});
}

class ContabilizarBatida extends DebugManager implements IContabilizarBatida {
  BatidasDoDiaRepository repository;

  bool contabilizandoBatida = false;

  ContabilizarBatida({
    @required this.repository,
  });

  //------------------------------------------------- CALL -------------------------------------------------

  @override
  Future call({@required bool printLog}) async {
    contabilizandoBatida = true;
    // CustomLoad().show();

    //***** LOG *****/
    await LogRegistrarPontoController.instance.writeLogStartContabilizar();
    //***************/

    PontoVirtual pontoVirtual = PontoVirtual.instance;

    Get.find<IRegistrarPontoPessoal>().runTimeout();

    //MONTAR DADOS DA NOVA BATIDA
    RegistroBatida dadosNovaBatida = RegistroBatida(
      loccheckpontoId: await determinarLockCheckPontoId(),
      lat: pontoVirtual.localizacaoBatida.localDaBatida.geoPosition.latitude.toString(),
      lon: pontoVirtual.localizacaoBatida.localDaBatida.geoPosition.longitude.toString(),
      distancia: await determinarDistancia(),
      tipo: Batida.determinarIndexComBaseNoTipoDaBatida(TipoBatida.normal),
      dthr: await determinarDtHr(),
      fuso: "-03",
      localBatida: await determinarTxtLocal(),
      txtMotivo: pontoVirtual.clockTimerController.txtMotivoEdit,
      idMotivo: pontoVirtual.clockTimerController.idMotivoEdit,
    );

    //***** LOG *****/
    await LogRegistrarPontoController.instance.writeLogCheckPoint2();
    //***************/

    //Se nao houver batida nesse horario, contabiliza a nova batida
    if (await _verificarSeJaExisteBatidaNoHorario(dadosNovaBatida) == false) {
      //***** LOG *****/
      await LogRegistrarPontoController.instance.writeLogBatidaJaExistente("false");
      //***************/

      bool statusRequisicaoContabilizar = await repository.contabilizarNovaBatida(dadosNovaBatida, Duration(milliseconds: 10000));

      //-------- CONTABILIZA OFFLINE --------
      //Se requisicao nao foi bem sucedida, contabiliza offline
      if (statusRequisicaoContabilizar == false) {
        //***** LOG *****/
        await LogRegistrarPontoController.instance.writeLogBatidaOffline();
        //***************/

        await repository.contabilizarBatidaOffline(dadosNovaBatida);
      }
    } else {
      //Se existir batida nesse horario, nada é feito.

      //***** LOG *****/
      await LogRegistrarPontoController.instance.writeLogBatidaJaExistente("true");
      //***************/

    }

    //--------- RECARREGAR BATIDAS ---------

    //Apos contabilizar, recarrega a lista de batidas
    await repository.carregarBatidas(data: await _getDateTime());

    var p = "";

    //FECHAR LOAD
    await Future.delayed(const Duration(milliseconds: 600), () async {
      CustomLoad().hide();
    });

    //CONCLUIR PROCESSO
    await Future.delayed(const Duration(milliseconds: 200), () async {
      contabilizandoBatida = false;
      Get.find<IRegistrarPontoPessoal>().cancelTimeout();
    });
  }

  //-------------------------------------- VERIFICAR SE EXISTE BATIDA NO HORARIO --------------------------------------

  Future<bool> _verificarSeJaExisteBatidaNoHorario(RegistroBatida dadosNovaBatida) async {
    Either<Exception, List<Batida>> batidasServidorResult = await repository.consultarBatidas(data: Batida.determinarData(dadosNovaBatida.dthr.split(" ")[0]));

    bool finalResult = false;

    //--- VERIFICAR BATIDAS DO SERVIDOR ---
    if (batidasServidorResult.isRight()) {
      finalResult = batidasServidorResult.fold(
        (l) {},
        (List<Batida> listaDeBatidasServidor) {
          for (Batida batidaServidor in listaDeBatidasServidor) {
            var teste = dadosNovaBatida.dthr.split(" ")[1];
            if (dadosNovaBatida.dthr.split(" ")[1] == batidaServidor.hr) {
              return true;
            }
          }
          return false;
        },
      );
    }

    if (finalResult == true) return finalResult;

    //--- VERIFICAR BATIDAS LOCAIS ---
    for (Batida batidaRepo in repository.listaDeBatidas) {
      var teste = dadosNovaBatida.dthr.split(" ")[1];
      var point = "";
      if (batidaRepo.hr == dadosNovaBatida.dthr.split(" ")[1] && batidaRepo.dateExpired == false) return true;
    }

    finalResult = false;
    return finalResult;
  }

  //------------------------------------------------- DETERMINAR DTHR -------------------------------------------------

  Future determinarDtHr() async {
    PontoVirtual pontoVirtual = PontoVirtual.instance;
    String finalTime = (pontoVirtual.clockTimerController.time.split(":"))[0] + ":" + (pontoVirtual.clockTimerController.time.split(":"))[1];
    String finalDate = pontoVirtual.clockTimerController.currentDate;
    var point = "";
    // return (await _getDateTime() + " " + finalTime);
    return (finalDate + " " + finalTime);
  }

  //-------------------------------------------- determinarLockCheckPontoId --------------------------------------------

  Future<int> determinarLockCheckPontoId() async {
    LocalizacaoBatidaController localizacaoBatida = Get.find<LocalizacaoBatidaController>();
    if (localizacaoBatida.batidaFeitaEmLocalPermitido.value == true) {
      LocalDefinido local = localizacaoBatida.localDaBatida;
      return local.idLocal;
    } else {
      return null;
    }
  }

  //------------------------------------------------ determinarTxtLocal ------------------------------------------------

  Future<String> determinarTxtLocal() async {
    LocalizacaoBatidaController localizacaoBatida = Get.find<LocalizacaoBatidaController>();
    if (localizacaoBatida.batidaFeitaEmLocalPermitido.value == true) {
      LocalDefinido local = localizacaoBatida.localDaBatida;
      return local.nomeLocal;
    } else {
      return null;
    }
  }

  //------------------------------------------------ determinarDistancia ------------------------------------------------

  Future determinarDistancia() async {
    LocalizacaoBatidaController localizacaoBatida = Get.find<LocalizacaoBatidaController>();
    if (localizacaoBatida.batidaFeitaEmLocalPermitido.value == true) {
      LocalDefinido local = localizacaoBatida.localDaBatida;
      return local.distancia;
    } else {
      return null;
    }
  }

  //------------------------------------------------------ isOnline ------------------------------------------------------

  //VERIFICAR SE ESTA ONLINE (Futuramente abstrair via camada external/driver)
  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  //--------------------
  Future _getDateTime() async {
    dynamic day = DateTime.now().day;
    dynamic month = DateTime.now().month;
    var year = DateTime.now().year;

    if (day < 10) {
      day = '0$day';
    }
    if (month < 10) {
      month = '0$month';
    }
    return '$day/$month/$year';
  }

  Future getDateTimeMock() async {
    print("####################################### UTILIZANDO DATA MOCKADA #######################################");
    return "19/04/2022";
  }

  //
}
