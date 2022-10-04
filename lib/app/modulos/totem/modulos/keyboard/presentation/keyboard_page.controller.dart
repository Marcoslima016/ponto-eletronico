import 'package:flutter/material.dart';

import '../keyboard.imports.dart';
import 'numeric_keyboard.controller.dart';

class KeyboardPageController extends NumericKeyBoardControllerV2 {
  NumericKeyboardPreferences preferences;

  KeyboardPageController({
    @required this.preferences,
  });

  Future initialize() async {
    await initializeKeyboard(
      verificationCode: preferences.verificationCode,
      qtdDigits: preferences.qtdDigits,
      type: preferences.type,
      encryptedCode: preferences.encryptedCode,
    );

    return true;
  }

  @override
  Future performAllowed(String value) async {
    var p = "";
    await preferences?.onCodeAllowed();
  }

  @override
  Future performRefused(String value) async {
    if (preferences.onCodeRefused != null) {
      await preferences.onCodeRefused();
    }
  }
  //
}
