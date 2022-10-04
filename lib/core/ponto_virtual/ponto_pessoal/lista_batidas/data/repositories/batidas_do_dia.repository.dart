import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../../lib.imports.dart';
import '../../../../../local_storage/local_storage.imports.dart';
import '../../../../ponto_virtual.imports.dart';
import '../data.imports.dart';

///*****>> Essa implementacao do repository futuramente deve ser alocada no nivel do ponto pessoal. Pois -
/// é uma implementacao de uso especifico do ponto pessoal, e não uma implementacao necessaria a todas as utilizacoes da lista de batidas.
class BatidasDoDiaRepository with Cache implements IBatidasRepository {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  IBatidasNetworkDatasource networkDataSource;
  // IBatidasLocalDatasource localDatasource;

  ILocalStorageDriver localStorageDriver;

  RxList<Batida> listaDeBatidas = List<Batida>().obs;

  @override
  get baseList => listaDeBatidas;

  @override
  bool carregandoBatidas = false;

  ///[=================== CONSTRUTOR ===================]

  BatidasDoDiaRepository({
    @required this.networkDataSource,
    // @required this.localDatasource,
    @required this.localStorageDriver,
  }) {
    setCachePreferences(
      jsonToDartMethod: Batida.convertListFromJson,
      blendFunction: Batida.blendListItems,
      storageKey: "lista_batidas",
      autoConfig: true,
      resetFunction: Batida.resetCache,
    );
    cacheStorageDriver = localStorageDriver;
  }

  //============================================= CARREGAR BATIDAS =============================================

  //METODO PRINCIPAL
  @override
  Future<Either<Exception, ExecutionSuccess>> carregarBatidas({@required String data}) async {
    carregandoBatidas = true;

    listaDeBatidas.clear();

    if (await _isOnline()) {
      //
      //---------------------- ONLINE --------------------
      try {
        Map reponseData = await networkDataSource.carregarBatidas(data: data);

        // print("BatidasDoDiaRepository / carregarBatidas() - length lista retornada via servidor: " + reponseData["getBatidasByDate"].length.toString());

        //Popular lista observavel
        for (Map localMap in reponseData["getBatidasByDate"]) {
          listaDeBatidas.add(
            Batida.fromAPI(
              localMap,
              PontoVirtual.instance.enderecosPonto.locaisPonto,
            ),
          );
        }

        //REALIZAR BLEND - MESCLAR COM VALORES EM CACHE; SALVAR EM CACHE OS VALORES ATUALIZADOS
        await blendCache();

        // print("BatidasDoDiaRepository / carregarBatidas() - listaDeBatidas length pos blend " + listaDeBatidas.length.toString());

        var point = "";

        carregandoBatidas = false;

        return Right(ExecutionSuccess()); //// Retorna indicador de sucesso
      } catch (e) {
        await carregarBatidasEmCache(); //// Se der erro na requisicao, consulta as batidas offline

        carregandoBatidas = false;

        return Right(ExecutionSuccess());
        // return Left(Exception(e));
      }
    } else {
      //
      //---------------------- OFFLINE --------------------

      await carregarBatidasEmCache();

      carregandoBatidas = false;

      return Right(ExecutionSuccess()); //// Retorna indicador de sucesso
    }
  }

  Future carregarBatidasEmCache() async {
    //consulta valores em cache
    List<Batida> cachedList = await restoreCache();

    // print("BatidasDoDiaRepository / carregarBatidas() - offline cachedList length: " + cachedList.length.toString());

    //Popular lista observavel
    for (Batida batida in cachedList) {
      // print("BatidasDoDiaRepository / carregarBatidas() - Adicionar batida a listaDeBatidas!!!!");

      listaDeBatidas.add(batida);
    }
  }

  //============================================= CONSULTAR BATIDAS =============================================

  @override
  Future<Either<Exception, List<Batida>>> consultarBatidas({@required String data}) async {
    List<Batida> returnList = [];
    if (await _isOnline()) {
      //
      //---------------------- ONLINE --------------------
      try {
        Map reponseData = await networkDataSource.carregarBatidas(data: data);
        for (Map localMap in reponseData["getBatidasByDate"]) {
          returnList.add(
            Batida.fromAPI(
              localMap,
              PontoVirtual.instance.enderecosPonto.locaisPonto,
            ),
          );
        }
        return Right(returnList);
      } catch (e) {
        return Left(Exception(e));
      }
    } else {
      //
      //---------------------- OFFLINE --------------------

      return Left(Exception("offline"));
    }
  }

  //=============================================== EFETUAR BATIDA ================================================

  @override
  Future<bool> contabilizarNovaBatida(RegistroBatida dadosNovaBatida, Duration timeout) async {
    if (await _isOnline()) {
      try {
        QueryResult response = await networkDataSource.registrarNovaBatida(dadosBatida: dadosNovaBatida, timeout: timeout);
        if (response.hasException) {
          return false; //// Se houver falha na requisicao, retorna false
        } else {
          return true; //// Se a requisicao for bem sucedida, retorna true
        }
      } catch (e) {
        // //Se houver falha na requisicao, realiza batida offline
        // await contabilizarBatidaOffline(dadosNovaBatida);
        return false;
      }
    } else {
      //Se nao estiver online, realiza batida offline
      // await contabilizarBatidaOffline(dadosNovaBatida);
      return false;
    }
  }

  //---------------------- OFFLINE ----------------------

  //Se nao conseguir contabilizar online, faz a batida offline
  Future contabilizarBatidaOffline(RegistroBatida dadosNovaBatida) async {
    dadosNovaBatida.tipo = Batida.determinarIndexComBaseNoTipoDaBatida(TipoBatida.offline);
    listaDeBatidas.add(
      Batida(
        id: DateTime.now().millisecondsSinceEpoch, //// gera timestamp id provisório pq ainda nao foi gerado um id para a batida
        syncStatus: SyncStatus.inQueue.obs,
        tipo: TipoBatida.offline,
        hr: Batida.determinarHorario(dadosNovaBatida.dthr),
        data: Batida.determinarData(dadosNovaBatida.dthr),
        loccheckpontoId: dadosNovaBatida.loccheckpontoId,
        localBatida: dadosNovaBatida.localBatida,
        dadosRegistro: dadosNovaBatida, //// Armazena os dados de registro, para utilizar na tentativa de requisicao
        dateExpired: false,
        idMotivo: dadosNovaBatida.idMotivo,
        txtMotivo: dadosNovaBatida.txtMotivo,
      ),
    );

    //PERSISTIR NOVA LISTA EM CACHE
    await saveInCache();
  }

  //============================================== SINCRONIZAR BATIDA ================================================

  Future<int> sincronizarBatida(RegistroBatida dadosBatida) async {
    if (await _isOnline()) {
      try {
        // print("SINCRONIZAR BATIDA!!!  TIPO DA BATIDA: " + dadosBatida.tipo);
        QueryResult responseBatidaRegistrada = await networkDataSource.registrarNovaBatida(dadosBatida: dadosBatida);
        if (responseBatidaRegistrada.data != null) {
          return responseBatidaRegistrada.data["createBatida"]["apontrelog_id"];
        }
      } catch (e) {
        return 0;
      }
    } else {
      return 0;
    }
    return 0;
  }

  //============================================== VERIFICAR CONEXAO =================================================

  //VERIFICAR SE ESTA ONLINE (Futuramente abstrair via camada external/driver)
  Future<bool> _isOnline() async {
    // return true;
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

  //===================================================== UTILS ======================================================

  //--------------------
  Future _getDateTime() async {
    // return "19/04/2022";

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
}

// 0:"__typename" -> "apontaRelog"
// 1:"apontrelog_id" -> 2026644
// 2:"usuario" -> "trabalhador1@compliancesolucoes.com.br"
// 3:"maquina" -> "APP"
// 4:"dt_hr_import" -> "10/04/2022 18:37"
// 5:"dt_hr_batida" -> "10/04/2022 18:37"
// 6:"pessoas_id" -> 15547
// 7:"relogio_id" -> null
// 8:"ofic" -> 0
// 9:"nsr" -> null
// 10:"loteponto_id" -> null
// 11:"regvis_id" -> null
// 12:"gremp_id" -> 1362
// 13:"tipo" -> "0"
// 14:"lat" -> "-21.2309431"
// 15:"lon" -> "-47.7786166"
// 16:"loccheckponto_id" -> null
// 17:"distancia" -> -1
// 18:"loc_falsa" -> 0
// 19:"cd_motivo" -> null
