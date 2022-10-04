import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core.imports.dart';
import '../../locais.imports.dart';
import '../data.imports.dart';

class EnderecosRepository with Cache implements IEnderecosRepository {
  IEnderecosNetworkDataSource networkDataSource;
  // IEnderecosLocalDataSource localDataSource;

  ILocalStorageDriver localStorageDriver;

  List<Local> listaDeLocais = [];

  @override
  List get baseList => listaDeLocais;

  EnderecosRepository({
    @required this.networkDataSource,
    @required this.localStorageDriver,
  }) {
    setCachePreferences(
      jsonToDartMethod: Local.convertListFromJson,
      blendFunction: ({@required List cachedList, @required List baseList}) async {}, //// Não utilizado nessa implementacao
      storageKey: "lista_locais",
      autoConfig: false,
      resetFunction: ({cachedList}) async {
        return cachedList;
      },
    );
    cacheStorageDriver = localStorageDriver;
  }

  //================================================ GET ENDERECOS ===================================================

  @override
  Future<Either<Exception, List<Local>>> getEnderecos() async {
    if (await _isOnline()) {
      //
      //---------------------- ONLINE --------------------
      try {
        Map reponseData = await networkDataSource.getEnderecos();
        // List<Local> finalList = []; //// Lista que será retornada pelo metodo

        ///Percorre a lista de Maps retornado pela requisição, e monta a lista de retorno
        for (Map localMap in reponseData["getLocaisChecking"]) {
          listaDeLocais.add(Local.fromAPI(localMap));
        }

        await saveInCache();

        return Right(listaDeLocais);
      } catch (e) {
        await carregarEnderecosEmCache();

        return Right(listaDeLocais);
        // return Left(Exception(e));
      }
    } else {
      //---------------------- OFFLINE --------------------

      await carregarEnderecosEmCache();

      return Right(listaDeLocais);
    }
  }

  Future carregarEnderecosEmCache() async {
    //consulta valores em cache
    List cachedList = await restoreCache();

    for (Local local in cachedList) listaDeLocais.add(local);
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
}
