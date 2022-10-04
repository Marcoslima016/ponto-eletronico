import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../lib.imports.dart';

abstract class IValidarTrabalhador {
  Future<bool> call();
}

///Usecase responsavel por autenticar o trabalhador (Via pin/digital)
class ValidarTrabalhador implements IValidarTrabalhador {
  @override
  Future<bool> call() async {
    ResultadoLockScreen resultadoValidacao = await Navigator.push(
      Get.context,
      MaterialPageRoute(builder: (context) => LockScreenView()),
    );
    if (resultadoValidacao == ResultadoLockScreen.falhaNaValidacao) return false;
    if (resultadoValidacao == ResultadoLockScreen.trabalhadorValidado) return true;
    return false;
  }
}
