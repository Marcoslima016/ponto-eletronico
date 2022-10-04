import 'package:get/get.dart';

import '../../../../lib.imports.dart';

enum KeyboardViewState {
  waiting,
  error,
  success,
}

abstract class NumericKeyBoardController {
  //
  String verificationCode = "";

  int numberFieldIndex = 0;

  int qtdDigits = 1;

  RxList<String> numberFieldsValues = [""].obs;

  Rx<KeyboardViewState> keyboardViewState = Rx<KeyboardViewState>(KeyboardViewState.waiting);

  ///Variavel que define se os campos devem ser zerados após erro. Default é true
  bool _cleanAfterFail = true;

  ///[=================== CONSTRUTOR ===================]

  NumericKeyBoardController();

  ///[====================================================== METODOS ======================================================]
  ///[=====================================================================================================================]

  //------------------------------------------ INITIALIZE ------------------------------------------

  Future initializeKeyboard({String verificationCode, int qtdDigits = 4, bool cleanAfterFail = true}) async {
    this._cleanAfterFail = cleanAfterFail;
    this.verificationCode = verificationCode;
    this.qtdDigits = qtdDigits;
    numberFieldsValues.clear();
    for (int i = 0; i < qtdDigits; i++) {
      numberFieldsValues.add("");
    }
    return true;
  }
  //----------------------------------- RECEBER NUMERO DIGITADO -----------------------------------

  bool processandoCodigo = false;

  Future typeNumber(String value) async {
    if (processandoCodigo == true) return;

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

    processandoCodigo = false;
  }

  //--------------------------------------- DELETAR NUMERO ---------------------------------------

  //Metodo disparado ao clicar no botao de excluir (backspace)
  Future deleteNumber() async {
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

  //------------------------------------ CHECAR CODIGO DIGITADO ------------------------------------

  Future checkCode(List<String> caractersList) async {
    String finalCode = "";
    for (String itemCaracter in caractersList) finalCode = finalCode + itemCaracter;

    // await Future.delayed(const Duration(milliseconds: 1500), () {});

    if (finalCode != verificationCode) {
      await codeRefused();
      return;
    }

    if (finalCode == verificationCode) await codeAllowed();
  }

  //---------------------------------------- CÓDIGO APROVADO ----------------------------------------

  Future codeAllowed() async {
    // APROVADO, realizar acao
    await allowedViewEffect();
    await performAllowed();
  }

  /// Funcao responsavel por disparar os efeitos na view em caso de sucesso
  /// *Basicamente, altera a cor do campo de texto
  Future allowedViewEffect() async {
    keyboardViewState.value = KeyboardViewState.success;
    await Future.delayed(const Duration(milliseconds: 2100), () async {}); //// Delay
  }

  ///Metodo responsavel por realizar a rotina pos aprovação. ( Deve ser implementado na aplicacao, pois em cada uso existirá uma rotina diferente)
  Future performAllowed();

  //---------------------------------------- CÓDIGO REPROVADO ----------------------------------------

  Future codeRefused() async {
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

    await performRefused();
  }

  Future refusedViewEffect() async {
    keyboardViewState.value = KeyboardViewState.error;
    await Future.delayed(const Duration(milliseconds: 2100), () async {}); //// Delay
    keyboardViewState.value = KeyboardViewState.waiting;
  }

  ///Metodo responsavel por realizar a rotina pos reprovação. ( Deve ser implementado na aplicacao, pois em cada uso existirá uma rotina diferente)
  Future performRefused();
}
