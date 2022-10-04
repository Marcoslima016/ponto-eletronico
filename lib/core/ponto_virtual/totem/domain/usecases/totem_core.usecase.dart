import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../core.imports.dart';

abstract class ITotemCore {
  String token = '';
  // RxList<Colab> colabList = [].obs;
  RxInt grempId = 0.obs;
  RxString codigo = "".obs;
  Widget homePage;
  // Widget loginPage;

  Future<String> recoverSession();
  Future saveSession(String token);
  Future disconnectSession();
}

class TotemCore implements ITotemCore {
  ILocalStorageDriver localStorage = SharedPreferencesDriver();

  ///[=================== VARIAVEIS ===================]

  @override
  String token = '';

  // @override
  // RxList<Colab> colabList = RxList<Colab>();

  @override
  RxInt grempId = 0.obs;

  @override
  RxString codigo = "".obs;

  @override
  Widget homePage;

  // @override
  // Widget loginPage;

  //------------------------------------------- SESSION -------------------------------------------

  String sessionDataStorageKey = "totem_session_data";

  @override
  Future<String> recoverSession() async {
    String token = await localStorage.getData(key: sessionDataStorageKey);
    this.token = token;
    if (token != null && token != "") {
      await readToken(token);
    }

    return token;
    // var dados = json.decode(localData);
  }

  @override
  Future saveSession(String token) async {
    this.token = token;
    await readToken(token);

    await FlutterSecureStorage().write(key: "token_totem2.0", value: token); //// Salvar token global utilizado nas requisições
    await localStorage.put(key: sessionDataStorageKey, value: token); //// Salvar token interno do Totem
  }

  Future readToken(String token) async {
    var tokenParsed = JWTUtil.parseJwt(token);
    this.grempId.value = tokenParsed['grempId'];
    this.codigo.value = tokenParsed['codigo'];
  }

  @override
  Future disconnectSession() async {
    await FlutterSecureStorage().write(key: "token_totem2.0", value: "");
    await localStorage.put(key: sessionDataStorageKey, value: "");
  }
}
