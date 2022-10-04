import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../core.imports.dart';

class LogAppRepository with Cache {
  //

  List<LogCycle> cycles = [];

  DatabaseReference db = FirebaseDatabase.instance.reference().child("LOG/" + "LOG_APP/" + "DATA/");

  ILocalStorageDriver localStorageDriver = SharedPreferencesDriver();

  @override
  get baseList => cycles;

  LogAppRepository() {
    setCachePreferences(
      jsonToDartMethod: LogCycle.convertListFromJson,
      blendFunction: ({@required List cachedList, @required List baseList}) async {
        return cachedList;
      },
      storageKey: "cycles_log_app",
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
