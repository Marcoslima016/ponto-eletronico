import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../lib.imports.dart';
import '../../../../../core.imports.dart';

class ValidationCodePopupController {
  //
  TextEditingController codeInput = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxList<AutovalidateMode> autoValidate = [AutovalidateMode.disabled].obs;

  //------------------------ AO CLICAR NO BOTAO AVANCAR ------------------------

  Future onTapAvancar() async {
    if (formKey.currentState.validate() == false) {
      autoValidate.add(AutovalidateMode.always);
      return;
    }

    bool codeValidated = await validateCode();
    if (codeValidated) {
      Navigator.pop(Get.context, true);
    } else {
      // Get.snackbar("Código inválido", "");
    }
  }

  //------------------------------- VALIDAR CODIGO -------------------------------

  Future<bool> validateCode() async {
    //await CustomLoad().show();

    DatabaseReference db = FirebaseDatabase.instance.reference();

    String codeInserted = codeInput.text;

    DataSnapshot response = await db.child("/APP_CONFIG/facial_recognition_activate/" + codeInserted).get();

    Map values = response.value;

    //----- VERIFICAR CODIGO INVALIDO -----

    if (values == null) {
      Popup(
        hasIcon: false,
        closeDialogOnPressButton: true,
        type: PopupType.NoButton,
        blocked: false,
        txtTitle: "Código inválido",
        txtText: "Verifique o código informado e tente novamente",
        // txtBtnOk: "Tentar novamente",
      ).show();
      return false;
    }

    //---- VERIFICAR VALIDADE TIMESTAMP ----

    int timestampCode = values["timestamp"];

    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    int difTimestamp = currentTimestamp - timestampCode;

    // if (difTimestamp > 180) {
    //   Get.snackbar(
    //     "Código inválido",
    //     "Você informou um código que ja expirou.",
    //   );
    //   return false;
    // }

    var p = "";

    return true;
  }
}
