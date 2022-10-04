import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../lib.imports.dart';
import '../../domain.imports.dart';

abstract class IRegistrarBatida {
  Future call({@required Colab colab});
}

class RegistrarBatida implements IRegistrarBatida {
  IBatidasTotemRepository batidasRepository;
  ISyncRepository syncRepository;

  RegistrarBatida({
    @required this.batidasRepository,
    @required this.syncRepository,
  });

  //================================================================ CALL ================================================================

  Future call({@required Colab colab}) async {
    await CustomLoad().show();

    BatidaTotem dadosBatida = BatidaTotem(
      dthrBatida: await _getDTHR(),
      cdMotivo: null,
      pessoasId: colab.pessoaId.toString(),
      usuario: colab.login,
      lat: null,
      lon: null,
      distancia: -1,
      locFalsa: 0,
      loccheckpontoId: null,
      tipo: '0',
      motivo: null,
      fuso: "-03",
      urlFoto: "",
      error: null,
      nome: colab.nome,
    );

    if (await _verificarSeJaExisteBatidaNoHorario(dadosBatida) == false) {
      //
      //----- SE NÃO HOUVER BATIDA NO HORÄRIO, A BATIDA Ë REALIZADA -----
      //
      await batidasRepository.registrarBatida(dadosBatida: dadosBatida);

      //-- POPUP CONFIRMA BATIDA --
      await CustomLoad().hide();

      await PopupConfirmaBatida(
        dthr: dadosBatida.dthrBatida,
        nome: dadosBatida.nome,
      ).show();
      //
    } else {
      //----- SE HOUVER BATIDA NO HORÄRIO, A BATIDA NAO Ë REALIZADA ------

      //-- POPUP BATIDA DUPLICADA --
      await CustomLoad().hide();

      await PopupBatidaDuplicada(
        dthr: dadosBatida.dthrBatida,
        nome: dadosBatida.nome,
      ).show();
    }
  }

  //=============================================== VERIFICAR SE EXISTE BATIDA NO HORARIO ===============================================

  Future<bool> _verificarSeJaExisteBatidaNoHorario(BatidaTotem dadosNovaBatida) async {
    bool finalResult = false;

    //----- CONFERIR BATIDAS DO SERVIDOR ------

    Either<Exception, List<BatidaTotem>> batidasServidorResult = await syncRepository.carregarBatidas(
      data: dadosNovaBatida.dthrBatida.split(" ")[0],
      pessoasId: dadosNovaBatida.pessoasId,
    );
    if (batidasServidorResult.isRight()) {
      finalResult = batidasServidorResult.fold(
        (l) {},
        (List<BatidaTotem> listaDeBatidasServidor) {
          for (BatidaTotem batidaServidor in listaDeBatidasServidor) {
            if (dadosNovaBatida.dthrBatida.split(" ")[1] == batidaServidor.dthrBatida.split(" ")[1]) {
              return true;
            }
          }
          return false;
        },
      );
    }

    //----- CONFERIR BATIDAS QUE AINDA NAO FORAM SINCRONIZADAS ------

    for (BatidaTotem batidaRepo in batidasRepository.listaBatidas) {
      if (batidaRepo.pessoasId == dadosNovaBatida.pessoasId) {
        if (batidaRepo.dthrBatida.split(" ")[1] == dadosNovaBatida.dthrBatida.split(" ")[1]) {
          finalResult = true;
        }
      }
    }

    //
    if (finalResult == true) return finalResult;

    finalResult = false;
    return finalResult;
  }

  Future<String> _getDTHR() async {
    DateTime dateTime = DateTime.now();
    String year = dateTime.year.toString();
    if (year.length < 2) year = "0" + year;
    String month = dateTime.month.toString();
    if (month.length < 2) month = "0" + month;
    String day = dateTime.day.toString();
    if (day.length < 2) day = "0" + day;

    String hour = dateTime.hour.toString();
    if (hour.length < 2) hour = "0" + hour;
    String minute = dateTime.minute.toString();
    if (minute.length < 2) minute = "0" + minute;
    String second = dateTime.second.toString();
    if (second.length < 2) second = "0" + second;

    String finalDTHR = day + "/" + month + "/" + year + " " + hour + ":" + minute;

    return finalDTHR;
  }
}
