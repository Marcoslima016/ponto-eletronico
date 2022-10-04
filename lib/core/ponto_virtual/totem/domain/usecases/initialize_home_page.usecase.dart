import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

/// Classe responsavel por fazer a inicialização da página home.
/// A home pode ser de dois tipos: QR Code ou  Reconhecimento Facial, dependendo da configuração da empresa.

abstract class IInitializeHomePage {
  Future call();
}

class InitializeHomePage implements IInitializeHomePage {
  Future call() async {
    //
    if (TotemController.instance.facialRecognition.activate == false) {
      //
      //================================= QR =================================

      Get.find<ITotemCore>().homePage = QrPageView();

      Navigator.pushReplacement(
        Get.context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => QrPageView(),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1300),
          reverseTransitionDuration: Duration(milliseconds: 1100),
        ),
      );
      //
    } else {
      //
      //============================= RECOGNITION =============================

      Get.find<ITotemCore>().homePage = RecognitionAuthView();

      Navigator.pushReplacement(
        Get.context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => RecognitionAuthView(),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1300),
          reverseTransitionDuration: Duration(milliseconds: 1100),
        ),
      );
    }
  }
}
