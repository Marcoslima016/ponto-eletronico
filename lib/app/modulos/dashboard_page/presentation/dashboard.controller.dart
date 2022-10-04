import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController {
  Future Function() importExternalValues;

  RxString hr = "".obs;

  DashboardController({
    @required this.importExternalValues,
  });

  Future initModule() async {
    // await importExternalValues();
    await initWatch();
    return true;
  }

  //INICIAR RELOGIO
  Timer timerWatch;
  Future initWatch() async {
    getTime();
    timerWatch = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      getTime();
    });
  }

  Future getTime() async {
    DateTime date = DateTime.now();
    String minute = date.minute.toString();
    if (minute.length == 1) minute = "0" + minute;
    String hour = date.hour.toString();
    if (hour.length == 1) hour = "0" + hour;
    String finalTime = hour + ":" + minute;
    hr.value = finalTime;
  }
}
