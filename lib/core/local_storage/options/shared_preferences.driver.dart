import 'dart:convert';

import 'package:flutter/material.dart';

import '../local_storage.imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDriver implements ILocalStorageDriver {
  //
  ///[================================ VALOR ================================]
  ///

  @override
  Future delete({String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

  @override
  Future getData({String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  @override
  Future put({String key, dynamic value}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    }
  }

  ///[================================ LISTA ================================]

  //----------- LER LISTA -----------

  @override
  Future getList({@required String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var data = shared.get(key);

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      var result = decoded;
      return result;
    } else {
      return null;
    }
  }

  //--------- SALVAR LISTA ---------

  @override
  Future putList({@required String key, List list}) async {
    var shared = await SharedPreferences.getInstance();
    await shared.setString(key, jsonEncode(list));
  }
}
