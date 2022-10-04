import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lib.imports.dart';

abstract class ITentarRegistrarBatidaViaMatricula {
  IEncontrarColabViaMatricula usecaseEncontrarColabViaMatricula;
  Future call();
}

class TentarRegistrarBatidaViaMatricula implements ITentarRegistrarBatidaViaMatricula {
  //

  IEncontrarColabViaMatricula usecaseEncontrarColabViaMatricula;
  IRegistrarBatida usecaseRegistrarBatida;

  TentarRegistrarBatidaViaMatricula({
    @required this.usecaseEncontrarColabViaMatricula,
    @required this.usecaseRegistrarBatida,
  });

  //---------------------------------- CALL ----------------------------------

  Future call() async {
    // Colab colab = await usecaseEncontrarColabViaMatricula();

    Colab colab = await identificarColabViaMatricula();
    if (colab == null) return;
    bool resultValidacaoColab = await validarColabViaPin(colab: colab);
    if (resultValidacaoColab == false) return;
    await usecaseRegistrarBatida(colab: colab);
  }

  //---------------------- RECUPERAR MATRICULA DO COLAB ----------------------

  Future<Colab> identificarColabViaMatricula() async {
    try {
      Colab colab = await usecaseEncontrarColabViaMatricula();
      return colab;
    } catch (e) {
      return null;
    }
  }

  //-------------------------- VALIDAR COLAB VIA PIN --------------------------

  Future validarColabViaPin({@required Colab colab}) async {
    //REDIRECIONAR PARA A TELA DO TECLADO
    Widget keyboardPage = KeyboardView(
      keyboardPreferences: NumericKeyboardPreferences(
        type: NumericKeyboardType.definedValue,
        title: "Informe o seu pin",
        subtitle: "",
        qtdDigits: colab.pinLength,
        verificationCode: colab.pin,
        onCodeAllowed: () async {
          Get.back(result: true);
        },
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

    var p = "";

    if (validationResult == null) return false;

    return validationResult;
  }
}
