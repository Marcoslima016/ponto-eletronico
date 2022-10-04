import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_recognize/src/src.imports.dart' as flutter_recognize;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../lib.imports.dart';

class FacialRecognitionPontoPessoalController {
  //

  bool activate = false;

  UserRecognizePonto userRecognize;

  String storageKeyRecognizeUser = "recognize_user";

  ILocalStorageDriver cacheStorageDriver = SharedPreferencesDriver();

  static final FacialRecognitionPontoPessoalController instance = FacialRecognitionPontoPessoalController._(); //// Armazena a instancia utilizada no singleton
  FacialRecognitionPontoPessoalController._() {
    // FacialRecognitionTotemBind().dependencies();
  }

  //======================================== INICIALIZAR =========================================

  Future initFacialRecognition() async {
    //

    //INICIALIZAR PACKAGE FLUTTER RECOGNIZE
    await flutter_recognize.FlutterRecognize.instance.init();

    await recoverUser();
    //--- RECUPERAR STATUS DE ATIVACAO PARA A EMPRESA ---
    if (await _isOnline()) {
      DatabaseReference db = FirebaseDatabase.instance.reference().child("/APP_CONFIG/facial_recognition_clients");
      DataSnapshot response = await db.once();
      Map results = response.value;
      results.forEach((key, value) {
        var grempId = value["gremp_id"];
        if (grempId.toString() == VariaveisGlobais.instance.grempId.toString()) {
          if (value["active"] == true) {
            activate = true;
          }
        }
      });
      await cacheStorageDriver.put(key: "activate_recognize_ponto_pessoal", value: activate.toString());
    } else {
      String cachedValue = await cacheStorageDriver.getData(key: "activate_recognize_ponto_pessoal");
      if (cachedValue != null) {
        if (cachedValue == "true") activate = true;
        if (cachedValue == "false") activate = false;
      } else {
        activate = false;
      }
    }
  }

  //======================================== RECUPERAR USUARIO =========================================

  Future recoverUser() async {
    String userLocalStorageData = await cacheStorageDriver.getData(key: "recognize_user");

    if (userLocalStorageData != null) {
      UserRecognizePonto userData = UserRecognizePonto.fromMap(jsonDecode(userLocalStorageData));
      this.userRecognize = userData;
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
