import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/app.controller.dart';

import '../../../../lib.imports.dart';

class RadioOption {
  String displayText;
  String value;
  RadioOption({
    @required this.displayText,
    @required this.value,
  });
}

class PopupDevModeController {
  //

  RxString currentRadioValue = "".obs;

  IAppConfig currentConfig;

  List<IAppConfig> configOptions;

  DevModeController devModeController;

  PopupDevModeController({
    @required this.configOptions,
    @required this.devModeController,
  }) {
    currentConfig = AppController.instance.config;
    currentRadioValue.value = currentConfig.enviroment.name;
  }

  Future onSelectAmbienteOption(String value) async {
    currentRadioValue.value = value;
    for (IAppConfig envConfig in configOptions) {
      if (envConfig.enviroment.name == value) {
        devModeController.alterarAmbiente(envConfig);
      }
    }
  }

  Future<List<RadioOption>> mountRadioOptions() async {
    List<RadioOption> radioOptions = [];
    for (IAppConfig config in configOptions) {
      radioOptions.add(RadioOption(displayText: config.displayText, value: config.enviroment.name));
    }
    return radioOptions;
  }
}
