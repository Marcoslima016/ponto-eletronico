import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../totem.imports.dart';

class TotemController {
  //

  IInitializeTotem usecaseInitializeTotem;

  IBatidasHandler usecaseBatidasHandler;

  ITotemCore usecaseTotemCore;

  RxList<BatidaTotem> get listaBatidas => usecaseBatidasHandler.listaBatidas;

  // Widget loginPage;

  Function redirectToLogin;

  IColabListManager colabListManager;

  FacialRecognitionTotemController facialRecognition;

  bool totemInitialized = false;

  static final TotemController instance = TotemController._(); //// Armazena a instancia utilizada no singleton
  TotemController._() {}

  //------------------------------- INITIALIZE TOTEM -------------------------------

  Future initializeTotem({Function redirectToLogin}) async {
    if (totemInitialized == true) {
      return;
    }

    totemInitialized = true;

    this.redirectToLogin = redirectToLogin;

    await bind();
    facialRecognition = FacialRecognitionTotemController.instance;
    usecaseInitializeTotem = Get.find<IInitializeTotem>();
    usecaseBatidasHandler = Get.find<IBatidasHandler>();
    usecaseTotemCore = Get.find<ITotemCore>();
    colabListManager = Get.find<IColabListManager>();
    // usecaseTotemCore.loginPage = loginPage;

    await usecaseInitializeTotem(
      onFail: onInitializeFail,
    );
    var p = "";
  }

  //Funcao de callback disparada pelo usecase de inicializacao, em caso de falha no processo
  Future onInitializeFail() async {
    //
  }

  //------------------------------- DISCONNECT TOTEM -------------------------------

  Future disconnectTotem() async {
    await usecaseTotemCore.disconnectSession();
    redirectToLogin();
  }

  //------------------------------- REGISTRAR VIA QR -------------------------------

  Future tentarRegistrarPontoViaQr({@required String scanResult}) async {
    await usecaseBatidasHandler.tentarRegistrarBatidaViaQr(scanResult: scanResult);
  }

  //---------------------------- REGISTRAR VIA MATRICULA ----------------------------

  Future tentarRegistrarPontoViaMatricula() async {
    try {
      await usecaseBatidasHandler.tentarRegistrarBatidaViaMatricula();
    } catch (e) {
      var t = e;
      var p = "";
    }
  }

  Future bind() async {
    TotemBinding().dependencies();
  }
}
