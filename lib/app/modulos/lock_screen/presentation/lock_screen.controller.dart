import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../lib.imports.dart';
import '../../../components/popup/popup.component.dart';

class LockScreenController extends NumericKeyBoardController {
  //
  //------------------------------------ INITIALIZE ------------------------------------

  Future initialize() async {
    await binding();

    String pin = "";
    for (int pinDigit in VariaveisGlobais.instance.pin) {
      pin = pin + pinDigit.toString();
    }

    await initializeKeyboard(
      verificationCode: pin,
      qtdDigits: VariaveisGlobais.instance.pinLenght,
    );

    return true;
  }

  //-------------------------------------- BINDING --------------------------------------

  Future binding() async {
    Get.put<IValidarViaDigital>(ValidarViaDigital());
    Get.put<IBiometricDriver>(LocalAuthBiometric());
  }

  //-------------------------------- VALIDAR VIA DIGITAL --------------------------------

  Future validarViaDigital() async {
    Either<BiometricFail, BiometricAuthenticated> biometricAuthenticationResult = await Get.find<IValidarViaDigital>()();
    biometricAuthenticationResult.fold(
      (BiometricFail biometricFailType) async {
        if (biometricFailType == BiometricFail.serviceUnavailable) {
          await Popup(
            onClickOk: () async {},
            onClickCancel: () async {},
            hasIcon: false,
            type: PopupType.OkButton,
            blocked: true,
            context: Get.context,
            txtBtnOk: "Continuar",
            txtTitle: "Falha na autenticação",
            txtText: "O serviço de biometria não esta disponível no seu aparelho.",
          ).show();
        }
        await refusedViewEffect();
        await performRefused();
      },
      (BiometricAuthenticated r) async {
        await allowedViewEffect();
        await performAllowed();
      },
    );
  }

  //--------------------------------- TRATAR RESULTADOS ---------------------------------

  //----------------------- PERFORM ALLOWED -----------------------

  //Metodo disparado quando o pin informado estiver correto
  @override
  Future performAllowed() async {
    Navigator.pop(Get.context, ResultadoLockScreen.trabalhadorValidado);
  }

  //----------------------- PERFORM REFUSED ------------------------

  //Metodo disparado quando o pin inserido for incorreto
  @override
  Future performRefused() async {
    // Navigator.pop(Get.context, ResultadoLockScreen.falhaNaValidacao);
  }
}
