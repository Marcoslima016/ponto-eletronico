import 'package:flutter/material.dart';

import '../../../core.imports.dart';
import '../totem.imports.dart';

class BatidasTotemLocalDatasource implements IBatidasTotemDatasource {
  ILocalStorageDriver driver;

  String storageKey = "lista_batidas_totem";

  BatidasTotemLocalDatasource({
    @required this.driver,
  });

  Future<List<BatidaTotem>> recuperarListaSalvaEmCache() async {
    try {
      List<dynamic> localStorageValue = await driver.getList(key: storageKey); //// Lista salva localmente (Cada item é um json em string)
      List<BatidaTotem> cachedList = await BatidaTotem.convertListFromJson(localStorageValue);
      return cachedList;
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Future salvarEmCache({@required List<BatidaTotem> listaBatidas}) async {
    try {
      await driver.putList(key: storageKey, list: listaBatidas);
    } catch (e) {
      throw (e.toString());
    }
  }

  //
}
