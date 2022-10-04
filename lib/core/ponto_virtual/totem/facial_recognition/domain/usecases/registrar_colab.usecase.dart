import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lib.imports.dart';
import '../../../totem.imports.dart';
import 'package:flutter_recognize/src/src.imports.dart';

abstract class IRegistrarColab {
  Future call();
}

class RegistrarColab implements IRegistrarColab {
  IEncontrarColabViaMatricula usecaseEncontrarColabViaMatricula;

  RegistrarColab({
    @required this.usecaseEncontrarColabViaMatricula,
  });

  //--------------------------------- CALL ----------------------------------

  @override
  Future call() async {
    //Resgatar dados colab
    Colab colab = await usecaseEncontrarColabViaMatricula();
    if (colab == null) return;

    //Validar colab
    bool resultValidacaoColab = await validarColabViaPin(colab: colab);
    if (resultValidacaoColab == false) return;

    //Verificar recadastro
    bool result = await verificarRecadastro(colab: colab);
    if (result == false) return;

    //Registrar face
    List prediction = await FlutterRecognize.instance.register();

    if (prediction.isEmpty) return; ///// Retorna se não recebeu resultado de prediction

    await concluirRegistro(prediction: prediction, colab: colab);

    //POPUP DE CONFIRMACAO
    await Future.delayed(const Duration(milliseconds: 600), () {
      Popup(
        type: PopupType.OkButton,
        hasIcon: false,
        txtTitle: "Cadastro Realizado",
        txtText: "Biometria Facial cadastrada! O trabalhador ja pode começar a bater ponto via Reconhecimento facial.",
        txtBtnOk: "Continuar",
      ).show();
    });
  }

  //--------------------------- CONCLUIR REGISTRO ----------------------------

  Future concluirRegistro({@required List prediction, @required Colab colab}) async {
    await TotemController.instance.colabListManager.setColabPrediction(
      id: colab.id,
      prediction: prediction,
    );
  }

  //----------------------------- RECUPERAR COLAB ----------------------------

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

  //--------------------------- VERIFICAR RECADASTRO ---------------------------
  /// Metodo que verifica se o colab ja esta cadastrado, e caso estiver, faz a confirmação se deseja recadastrar

  Future<bool> verificarRecadastro({@required Colab colab, Future Function() proceed, Future Function() cancel}) async {
    if (colab.prediction.length > 1) {
      return await Popup(
        type: PopupType.ReplyButtons,
        closeDialogOnPressButton: false,
        blocked: true,
        hasIcon: false,
        txtTitle: "Ja cadastrado",
        txtText: "A biometria facial desse trabalhador ja foi cadastrada. Deseja substituir o cadastro?",
        txtBtnOk: "Sim, desejo cadastrar novamente",
        onClickCancel: () async {
          Navigator.pop(Get.context, false);
        },
        onClickOk: () async {
          Navigator.pop(Get.context, true);
        },
      ).show();
    } else {
      return true;
    }
  }
}
