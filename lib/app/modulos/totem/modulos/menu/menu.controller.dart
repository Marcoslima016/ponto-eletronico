import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ptem2/core/core.imports.dart';

import '../../../../app.imports.dart';
import '../modulos.imports.dart';

class MenuController {
  //

  String appVersion = "";

  Future init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    var p = "";
    return true;
  }

  Future onTapReconhecimentoFacial() async {
    String codigoRelogio = TotemController.instance.usecaseTotemCore.codigo.value;

    if (TotemController.instance.facialRecognition.activate == false) {
      Popup(
        type: PopupType.OkButton,
        hasIcon: false,
        txtTitle: "Indisponível",
        txtText: "O serviço de Reconhecimento Facial não foi contratado por essa empresa.",
        txtBtnOk: "OK",
      ).show();
      return;
    }

    //REDIRECIONAR PARA A TELA DO TECLADO
    Widget keyboardPage = KeyboardView(
      keyboardPreferences: NumericKeyboardPreferences(
        type: NumericKeyboardType.definedValue,
        title: "Informe o código do relógio para continuar",
        subtitle: "",
        qtdDigits: codigoRelogio.length,
        verificationCode: codigoRelogio,
        onCodeAllowed: () async {
          Get.back(result: true);
        },
        encryptedCode: false,
      ),
    );
    bool validationResult = await Navigator.push(
      Get.context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => keyboardPage,
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 900),
        reverseTransitionDuration: Duration(milliseconds: 900),
      ),
    );

    if (validationResult == true) {
      Get.to(RecognitionMenuView());
    }
  }
}
