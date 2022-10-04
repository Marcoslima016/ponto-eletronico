import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

import '../../../ponto_virtual.imports.dart';
import '../sync.imports.dart';

class SyncRepository implements ISyncRepository {
  ISyncDatasource datasource;

  SyncRepository({
    @required this.datasource,
  });

  //================================================ CARREGAR BATIDAS ===================================================

  Future<Either<Exception, List<BatidaTotem>>> carregarBatidas({String data, String pessoasId}) async {
    List<BatidaTotem> returnList = [];
    if (await _isOnline()) {
      //
      //---------------------- ONLINE --------------------
      try {
        Map reponseData = await datasource.carregarBatidas(data: data, pessoasId: pessoasId);
        for (Map localMap in reponseData["getBatidasByColab"]) {
          returnList.add(
            BatidaTotem.fromAPI(localMap),
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

  //============================================= CONTABILIZAR BATIDA ================================================

  @override
  Future<bool> contabilizarBatida({@required BatidaTotem batida}) async {
    try {
      var response = await datasource.contabilizarBatida(batida: batida);
      return true;
    } catch (e) {
      return false;
    }
  }
  //

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
