import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core.imports.dart';
import '../../ponto_pessoal.imports.dart';
import '../lista_batidas.imports.dart';

class CachePreferencesOLD {
  Function jsonToDartMethod;
  String storageKey;
  CachePreferencesOLD({
    @required this.jsonToDartMethod,
    this.storageKey,
  });
}

class BatidasLocalStorageDatasource implements IBatidasLocalDatasource {
  //

  ///[=================== VARIAVEIS ===================]
  ///
  ILocalStorageDriver driver;

  String storageKey = "lista_batidas";

  Function jsonToDartMethod;

  Future Function() getList;

  BatidasLocalStorageDatasource({
    @required this.driver,
  });

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //=========================================== SET PREFERENCES ==========================================

  Future setCachePreferences({@required Function jsonToDartMethod}) async {
    this.jsonToDartMethod = jsonToDartMethod;
  }

  //============================================ SAVE IN CACHE ===========================================

  @override
  Future saveInCache({@required List<Batida> batidas}) async {
    await _configureCache();
    await driver.putList(key: storageKey, list: batidas);
  }

  //============================================ RESTORE CACHE ===========================================

  @override
  Future<List<Batida>> restoreCache() async {
    await _configureCache();
    List<dynamic> localStorageValue = await driver.getList(key: storageKey); //// Lista salva localmente (Cada item é um json em string)
    List<Batida> cachedList = await jsonToDartMethod(localStorageValue);
    return cachedList;
  }

  //============================================= CLEAR CACHE ============================================

  Future clearCache() async {
    await driver.delete(key: storageKey);
  }

  //========================================== CONFIGURAR CACHE ==========================================

  ///Metodo que configura o cache ( Se for data nova, zera o cache )
  Future _configureCache() async {
    String storageKey = "last-date_lista_batidas";
    String lastDate = await driver.getData(key: storageKey);
    if (lastDate != await _getDateTime()) {
      await clearCache();
    }
    await driver.put(key: storageKey, value: await _getDateTime());
  }

  //================================================ BLEND ===============================================

  Future blendCache(List<Batida> externalList) async {
    List<Batida> cachedList = await restoreCache();
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
}
