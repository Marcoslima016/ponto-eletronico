import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_recognize/src/src.imports.dart';
import 'package:ptem2/app/app.imports.dart';
import '../../../../../../../custom_load/custom_load.imports.dart';
import '../../../../../ponto_pessoal.imports.dart';
import '../../contabilizar_batida.usecase.dart';
import '../rotina_ponto_pessoal.interface.usecase.dart';

class RegistrarBatidaAutenticada implements IRotinaPontoPessoal {
  //
  @override
  String idRotina = "autenticada";

  ICadastrarFace usecaseCadastrarFace = CadastrarFace();

  bool recognizeAuthSuccess = false;

  Function onTrabalhadorValidado;

  //---------------------------------------- INICIAR ROTINA ----------------------------------------

  bool registrarViaRotinaPadrao = false;

  @override
  Future<bool> dispararRotina({@required Function onTrabalhadorValidado}) async {
    //

    this.onTrabalhadorValidado = onTrabalhadorValidado;

    bool biometriaCadastrada = await verificarCadastroBiometrico();

    if (biometriaCadastrada == false) {
      if (realizarBatidaPadrao) {
        return RegistrarBatidaPadrao().dispararRotina(onTrabalhadorValidado: onTrabalhadorValidado);
      }
      return false;
    }

    RecognizeAuthController recognizeAuthController = RecognizeAuthController(onAuthenticate: this.onFaceAuth);

    await FlutterRecognize.instance.auth(
      controller: recognizeAuthController,
      users: [
        FacialRecognitionPontoPessoalController.instance.userRecognize,
      ],
      defaultAppbarText: "Reconhecimento Facial",
      useCameraDefaultAppbar: true,
      onClickEmergencyButton: () async {
        registrarViaRotinaPadrao = true;
        // recognizeAuthSuccess = true;
        Navigator.pushReplacement(
          Get.context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Container(color: Colors.white),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
      // cameraFrame:,
    );

    if (recognizeAuthSuccess) {
      // await onTrabalhadorValidado(); //// Notificar trabalhadaor validado
      if (registrarViaRotinaPadrao == false) {
        await contabilizarBatida(); //// Contabilizar batida
      }
      return true;
    } else {
      if (registrarViaRotinaPadrao) {
        // bool result = await RegistrarBatidaPadrao().dispararRotina(onTrabalhadorValidado: onTrabalhadorValidado);
        // var p = "";
        // return result;
        return RegistrarBatidaPadrao().dispararRotina(onTrabalhadorValidado: onTrabalhadorValidado);
      }
      return false;
    }
  }

  //==================================================== ON FACE AUTH ====================================================

  Future onFaceAuth({UserRecognize user}) async {
    if (registrarViaRotinaPadrao) return;
    recognizeAuthSuccess = true;
    await this.onTrabalhadorValidado();
    // Navigator.pop(Get.context);
  }

  //--------------------------------- VERIFICAR CADASTRADO BIOMETRICO ---------------------------------

  bool realizarBatidaPadrao = false;

  Future verificarCadastroBiometrico() async {
    UserRecognize userRecognize = FacialRecognitionPontoPessoalController.instance.userRecognize;
    if (userRecognize == null) {
      String resultPopupAvisoCadastrarFace = await Popup(
        closeDialogOnPressButton: false,
        type: PopupType.ReplyButtons,
        blocked: true,
        txtTitle: "Reconhecimento Facial",
        txtText: "A sua empresa exige autenticação via reconhecimento facial.",
        txtBtnOk: "Cadastrar Face",
        txtBtnCancel: "Realizar batida sem validação de biometria",
        onClickOk: () {
          Navigator.pop(Get.context, "cadastrar face");
        },
        onClickCancel: () {
          Navigator.pop(Get.context, "realizar batida");
        },
      ).show();

      if (resultPopupAvisoCadastrarFace == "cadastrar face") {
        await usecaseCadastrarFace();
        return false;
      } else if (resultPopupAvisoCadastrarFace == "realizar batida") {
        realizarBatidaPadrao = true;
        return false;
        // return await RegistrarBatidaPadrao().dispararRotina(onTrabalhadorValidado: onTrabalhadorValidado);
      }
    }
    return true;
  }

  //--------------------------------------- AUTENTICAR TRABALHADOR ---------------------------------------

  Future<bool> autenticarTrabalhador() async {
    return true;
  }
  //--------------------------------------- CONTABILIZAR BATIDA ---------------------------------------

  //@override (ou, ficara dentro da classe abstract nao precisando ser sobrescrito na implementacao, para poder ser utilizado em outras rotinas)
  Future contabilizarBatida() async {
    await Get.find<IContabilizarBatida>()(printLog: true);
  }

  //
}
