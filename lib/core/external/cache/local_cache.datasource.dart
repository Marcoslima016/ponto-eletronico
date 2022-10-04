import 'package:flutter/material.dart';

import '../../core.imports.dart';

class CachePreferences {
  Function jsonToDartMethod;
  String storageKey;
  CachePreferences({
    @required this.jsonToDartMethod,
    this.storageKey,
  });
}

abstract class Cache {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  ILocalStorageDriver cacheStorageDriver;

  String storageKey = "lista_batidas";

  Function jsonToDartMethod;

  Future Function({@required List cachedList, @required List baseList}) blendFunction;

  Future Function({@required List cachedList}) resetFunction;

  List get baseList;

  bool autoConfig;

  ///[=============================================================== METODOS ===============================================================]
  ///[=======================================================================================================================================]

  //
  //=========================================== SET PREFERENCES ==========================================

  Future setCachePreferences({
    @required Function jsonToDartMethod,
    @required Future Function({@required List cachedList, @required List baseList}) blendFunction,
    @required String storageKey,
    @required bool autoConfig,
    @required Future Function({@required List cachedList}) resetFunction,
  }) async {
    this.jsonToDartMethod = jsonToDartMethod;
    this.blendFunction = blendFunction;
    this.storageKey = storageKey;
    this.autoConfig = autoConfig;
    this.resetFunction = resetFunction;
  }

  //============================================ SAVE IN CACHE ===========================================

  Future saveInCache() async {
    await _resetCache();
    await cacheStorageDriver.putList(key: storageKey, list: baseList);
  }

  //============================================ RESTORE CACHE ===========================================

  Future<List> restoreCache() async {
    await _resetCache();
    List<dynamic> localStorageValue = await cacheStorageDriver.getList(key: storageKey); //// Lista salva localmente (Cada item é um json em string)
    List cachedList = await jsonToDartMethod(localStorageValue);
    return cachedList;
  }

  //============================================= CLEAR CACHE ============================================

  Future clearCache() async {
    await cacheStorageDriver.delete(key: storageKey);
  }

  //========================================== CONFIGURAR CACHE ==========================================

  ///Metodo que configura o cache ( Se for data nova, zera o cache )
  Future _resetCache() async {
    if (autoConfig == false) return;

    // print("_resetCache() - DISPARADO!!!!!");

    List<dynamic> localStorageValue = await cacheStorageDriver.getList(key: storageKey); //// Lista salva localmente (Cada item é um json em string)
    List cachedList = await jsonToDartMethod(localStorageValue);

    String _storageKeyReset = "last-date_lista_batidas";
    String lastDate = await cacheStorageDriver.getData(key: _storageKeyReset);

    if (lastDate != await _getDateTime()) {
      // print("_resetCache() - RESETAR CACHE!!!!!!!!!!!!!!!!!!!");
      List updatedList = await resetFunction(cachedList: cachedList);
      await cacheStorageDriver.putList(key: storageKey, list: updatedList);
      // **** Anteriormente, esse if limpava a lista salva localmente.
    }

    await cacheStorageDriver.put(key: _storageKeyReset, value: await _getDateTime());

    // print("_resetCache() - FIM DO METODO!!!");
  }

  //================================================ BLEND ===============================================

  Future blendCache() async {
    // print("Datasource LocalCache - Metodo blendCache() DISPARADO !!!!!!!!");
    List cachedList = await restoreCache();
    List blendedList = await blendFunction(cachedList: cachedList, baseList: baseList);
    baseList.clear();
    for (var itemList in blendedList) baseList.add(itemList);
    await saveInCache();
  }

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
