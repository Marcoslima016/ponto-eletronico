import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core.imports.dart';
import '../../totem.imports.dart';
import '../colab_list.imports.dart';

class ColabListRepository with Cache implements IColabListRepository {
  IColabListDataSource externalDatasource;

  ILocalStorageDriver localStorageDriver;

  @override
  RxList<Colab> colabList = RxList<Colab>();

  @override
  List get baseList => colabList;

  ColabListRepository({
    @required this.externalDatasource,
    @required this.localStorageDriver,
  }) {
    setCachePreferences(
      jsonToDartMethod: Colab.convertListFromJson,
      blendFunction: Colab.blendListItems,
      storageKey: "lista_colab_totem",
      autoConfig: false,
      resetFunction: ({@required List cachedList}) async {
        return cachedList;
      },
    );
    cacheStorageDriver = localStorageDriver;
  }

  //========================================== CARREGAR COLAB LIST ==============================================

  @override
  Future<Either<Exception, List<Colab>>> loadColabList() async {
    if (await _isOnline()) {
      //
      //---------------------- ONLINE --------------------

      List requestResult;
      try {
        requestResult = await externalDatasource.loadColabList();
      } catch (e) {
        return Left(Exception(e));
      }

      List<Colab> colabList = [];

      for (Map resultMap in requestResult) {
        if (resultMap["dtdemis"] == null) {
          colabList.add(Colab.fromAPI(resultMap));
        }
      }

      this.colabList.assignAll(colabList);

      //REALIZAR BLEND - MESCLAR COM VALORES EM CACHE; SALVAR EM CACHE OS VALORES ATUALIZADOS
      await blendCache();

      return Right(colabList);
    } else {
      //
      //---------------------- OFFLINE --------------------

      await carregarBatidasEmCache();
    }
  }

  Future carregarBatidasEmCache() async {
    //consulta valores em cache
    List<Colab> cachedList = await restoreCache();
    //Popular lista observavel
    for (Colab colab in cachedList) {
      colabList.add(colab);
    }
  }

  //================================================ UPDATE COLAB ====================================================

  @override
  Future updateColabList() async {
    //PERSISTIR NOVA LISTA EM CACHE
    var teste = colabList;
    await saveInCache();
  }

  //============================================== VERIFICAR CONEXAO =================================================

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

  //
}
