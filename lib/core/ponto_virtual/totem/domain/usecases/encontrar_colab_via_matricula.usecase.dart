import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

abstract class IEncontrarColabViaMatricula {
  ITotemCore usecaseTotemCore;
  Future<Colab> call();
}

class EncontrarColabViaMatricula implements IEncontrarColabViaMatricula {
  ITotemCore usecaseTotemCore;

  EncontrarColabViaMatricula({
    @required this.usecaseTotemCore,
  });

  @override
  Future<Colab> call() async {
    //REDIRECIONAR PARA A TELA DO TECLADO
    Widget keyboardPage = KeyboardView(
      keyboardPreferences: NumericKeyboardPreferences(
        type: NumericKeyboardType.undefinedValue,
        title: "Informe a sua matricula",
        subtitle: "",
        leftButtonPreferences: ButtonPreferences(
          icon: Icons.done,
          onClick: (String value) {
            validarMatricula(matricula: value);
          },
        ),
      ),
    );

    Colab colabResult = await Navigator.push(
      Get.context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => keyboardPage,
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 900),
        reverseTransitionDuration: Duration(milliseconds: 900),
      ),
    );

    return colabResult;

    // throw ("Não foi encontrado colaborador correspondente a matricula informada");
    //
  }

  Future validarMatricula({@required String matricula}) async {
    for (Colab colab in TotemController.instance.colabListManager.colabList) {
      print(">>>>>>>>>>>>>>>>>>>>>>> COLAB: " + colab.nome + "    /   MATRICULA: " + colab.matricula.toString());

      if (colab.matricula.toString() == matricula) {
        if (colab.batePonto == false) {
          Get.snackbar("Ops...", "Não encontramos esta matricula.");
          return;
        } else {
          Get.back(result: colab);
          return;
        }
      }
    }
    Get.snackbar("Ops...", "Não encontramos esta matricula.");
  }
  //
}
