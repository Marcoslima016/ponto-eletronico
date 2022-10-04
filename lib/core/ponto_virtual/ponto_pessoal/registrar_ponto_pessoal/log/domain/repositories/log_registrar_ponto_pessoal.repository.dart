import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../../external/external.imports.dart';
import '../../../../../../local_storage/local_storage.imports.dart';
import '../../log.imports.dart';

class LogRegistrarPontoPessoalRepository with Cache {
  //

  List<LogCycle> cycles = [];

  DatabaseReference db = FirebaseDatabase.instance.reference().child("LOG/" + "LOG_REGISTRAR_PONTO_PESSOAL/" + "DATA/");

  ILocalStorageDriver localStorageDriver = SharedPreferencesDriver();

  @override
  get baseList => cycles;

  LogRegistrarPontoPessoalRepository() {
    setCachePreferences(
      jsonToDartMethod: LogCycle.convertListFromJson,
      blendFunction: ({@required List cachedList, @required List baseList}) async {
        return cachedList;
      },
      storageKey: "cycles_log_registrar_ponto",
      autoConfig: false,
      resetFunction: null,
    );
    cacheStorageDriver = localStorageDriver;
  }

  //=================================================== LOAD CYCLES =====================================================

  ///Metodo que recupera a lista de cycles salvas localmente
  Future loadCycles() async {
    List cachedList = await restoreCache();
    for (LogCycle cycle in cachedList) {
      cycles.add(cycle);
    }
  }

  //==================================================== ADD CYCLE ======================================================

  Future addCycle(LogCycle newCycle) async {
    cycles.add(newCycle);
    await saveInCache();
  }

  //================================================= SAVE CYCLES LIST ===================================================

  Future saveCyclesList() async {
    await saveInCache();
  }

  //======================================================= SYNC =========================================================

  Future syncCycles() async {
    if (await _isOnline()) {
      for (LogCycle cycle in cycles) {
        //
        //--------- CRIAR REGISTRO MASTER ----------

        await db.child(cycle.userPath).child("-" + cycle.cyclePath.toString() + "/").update(cycle.dataJson);

        //------------- REGISTRAR LOGS --------------

        int i = 0;
        for (Map<String, dynamic> log in cycle.logs) {
          //salvar log
          await db.child(cycle.userPath).child("-" + cycle.cyclePath.toString() + "/logs/" + i.toString() + "-" + log["logTitle"]).update(log);
          i++;
        }
      }

      cycles.clear();
      await saveInCache();
    }
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
