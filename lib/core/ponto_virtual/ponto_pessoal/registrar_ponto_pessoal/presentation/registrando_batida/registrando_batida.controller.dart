import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/core/core.imports.dart';

class RegistrandoBatidaController {
  //

  RxBool timeoutHit = false.obs;

  bool pageDisplayed = false;

  BuildContext viewContext;

  Future loadView() async {
    fireTimoutCount();
    return true;
  }

  Timer timeoutObserverTimer;
  Future fireTimoutCount() async {
    timeoutObserverTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (PontoVirtual.instance.pontoPessoal.timeoutHit.value) {
        timeoutHit.value = true;
      }
    });
  }

  Future processoConcluido() async {
    Navigator.pop(Get.context); //// Fechar tela "Registrando Ponto"

    timeoutObserverTimer.cancel();

    await Future.delayed(const Duration(milliseconds: 100), () {});

    //Exibir tela registro concluido
    Navigator.push(
      // viewContext,
      Get.context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => RegistroConcluido(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 900),
        reverseTransitionDuration: Duration(milliseconds: 1200),
      ),
    );
  }

  Future processoCancelado() async {
    if (pageDisplayed) {
      timeoutObserverTimer.cancel();
      Get.back();
    }
  }
}
