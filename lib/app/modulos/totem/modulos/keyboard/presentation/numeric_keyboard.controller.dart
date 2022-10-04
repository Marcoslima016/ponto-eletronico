import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum KeyboardViewStateV2 {
  waiting,
  error,
  success,
}

enum NumericKeyboardType {
  definedValue,
  undefinedValue,
}

class NumericKeyboardPreferences {
  NumericKeyboardType type;
  String title;
  String subtitle;
  String verificationCode;
  int qtdDigits;
  Future Function() onCodeAllowed;
  Future Function() onCodeRefused;
  // Future Function() onClickLeft;
  ButtonPreferences leftButtonPreferences;
  ButtonPreferences rightButtonPreferences;
  bool encryptedCode;
  NumericKeyboardPreferences({
    this.type,
    this.title,
    this.verificationCode,
    this.qtdDigits,
    this.subtitle = "",
    this.onCodeAllowed,
    this.onCodeRefused,
    this.leftButtonPreferences,
    this.rightButtonPreferences,
    this.encryptedCode = true,
    // this.onClickLeft,
  });
}

class ButtonPreferences {
  IconData icon;
  Function(String value) onClick;
  ButtonPreferences({
    this.icon,
    this.onClick,
  });
}

abstract class NumericKeyBoardControllerV2 {
  //
  String verificationCode = "";

  int numberFieldIndex = 0;

  int qtdDigits = 1;

  RxList<String> numberFieldsValues = [""].obs;

  Rx<KeyboardViewStateV2> keyboardViewState = Rx<KeyboardViewStateV2>(KeyboardViewStateV2.waiting);

  ///Variavel que define se os campos devem ser zerados após erro. Default é true
  bool _cleanAfterFail = true;

  NumericKeyboardType type;

  String finalCode;

  bool encryptedCode;

  ///[=================== CONSTRUTOR ===================]

  NumericKeyBoardControllerV2();

  ///[====================================================== METODOS ======================================================]
  ///[=====================================================================================================================]

  //------------------------------------------ INITIALIZE ------------------------------------------

  Future initializeKeyboard({
    String verificationCode,
    int qtdDigits = 4,
    bool cleanAfterFail = true,
    NumericKeyboardType type = NumericKeyboardType.definedValue,
    bool encryptedCode,
  }) async {
    this.type = type;
    this.encryptedCode = encryptedCode;
    if (type == NumericKeyboardType.definedValue) {
      this._cleanAfterFail = cleanAfterFail;
      this.verificationCode = verificationCode;
      this.qtdDigits = qtdDigits;
      numberFieldsValues.clear();
      for (int i = 0; i < qtdDigits; i++) {
        numberFieldsValues.add("");
      }
    } else {
      // qtdDigits =
    }

    return true;
  }

  //----------------------------------- RECEBER NUMERO DIGITADO -----------------------------------

  bool processandoCodigo = false;

  Future typeNumber(String value) async {
    if (processandoCodigo == true) return;

    //-------- VALOR DEFINIDO --------
    //
    if (type == NumericKeyboardType.definedValue) {
      numberFieldsValues[numberFieldIndex] = value;
      List tempList = [];
      for (String item in numberFieldsValues) tempList.add(item);
      numberFieldsValues.clear();
      for (String item in tempList) numberFieldsValues.value.add(item);
      numberFieldIndex++;
      if (numberFieldIndex == qtdDigits) {
        processandoCodigo = true;
        await checkCode(numberFieldsValues);
      }
    }

    //-------- VALOR INDEFINIDO -------
    //
    if (type == NumericKeyboardType.undefinedValue) {
      numberFieldsValues.add(value);
    }

    finalCode = "";
    for (String itemCaracter in numberFieldsValues) finalCode = finalCode + itemCaracter;

    processandoCodigo = false;
  }

  //--------------------------------------- DELETAR NUMERO ---------------------------------------

  //Metodo disparado ao clicar no botao de excluir (backspace)
  Future deleteNumber() async {
    if (type == NumericKeyboardType.definedValue) {
      if (numberFieldIndex == 0) return;
      List tempList = [];
      int i = 0;

      for (String item in numberFieldsValues) {
        if (i == numberFieldIndex - 1) {
          tempList.add("");
        } else {
          tempList.add(item);
        }
        i++;
      }
      numberFieldsValues.clear();
      for (String item in tempList) numberFieldsValues.add(item);
      numberFieldIndex--;
    }

    if (type == NumericKeyboardType.undefinedValue) {
      numberFieldsValues.removeLast();
    }

    finalCode = "";
    for (String itemCaracter in numberFieldsValues) finalCode = finalCode + itemCaracter;
  }

  //------------------------------------ CHECAR CODIGO DIGITADO ------------------------------------

  Future checkCode(List<String> caractersList) async {
    String finalCode = "";
    for (String itemCaracter in caractersList) finalCode = finalCode + itemCaracter;

    if (encryptedCode) {
      finalCode = md5.convert(utf8.encode(finalCode)).toString();
    }

    // await Future.delayed(const Duration(milliseconds: 1500), () {});

    if (finalCode != verificationCode) {
      await codeRefused(finalCode);
      return;
    }

    if (finalCode == verificationCode) await codeAllowed(finalCode);
  }

  //---------------------------------------- CÓDIGO APROVADO ----------------------------------------

  Future codeAllowed(String value) async {
    // APROVADO, realizar acao
    await allowedViewEffect();
    await performAllowed(value);
  }

  /// Funcao responsavel por disparar os efeitos na view em caso de sucesso
  /// *Basicamente, altera a cor do campo de texto
  Future allowedViewEffect() async {
    keyboardViewState.value = KeyboardViewStateV2.success;
    await Future.delayed(const Duration(milliseconds: 1100), () async {}); //// Delay
  }

  ///Metodo responsavel por realizar a rotina pos aprovação. ( Deve ser implementado na aplicacao, pois em cada uso existirá uma rotina diferente)
  Future performAllowed(String value);

  //---------------------------------------- CÓDIGO REPROVADO ----------------------------------------

  Future codeRefused(String value) async {
    await refusedViewEffect();

    //Limpar campos (se essa opção estiver ativada)
    if (_cleanAfterFail == true) {
      numberFieldIndex = 0;
      List listEmpty = List<String>.generate(qtdDigits, (int index) {
        return "";
      }, growable: true);
      numberFieldsValues.clear();
      for (String item in listEmpty) numberFieldsValues.add(item);
    }

    await performRefused(value);
  }

  Future refusedViewEffect() async {
    keyboardViewState.value = KeyboardViewStateV2.error;
    await Future.delayed(const Duration(milliseconds: 2100), () async {}); //// Delay
    keyboardViewState.value = KeyboardViewStateV2.waiting;
  }

  ///Metodo responsavel por realizar a rotina pos reprovação. ( Deve ser implementado na aplicacao, pois em cada uso existirá uma rotina diferente)
  Future performRefused(String value);
}
