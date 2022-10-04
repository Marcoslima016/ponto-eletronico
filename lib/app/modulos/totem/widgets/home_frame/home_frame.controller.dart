import 'dart:async';

import 'package:get/get.dart';

class HomeFrameController {
  RxString time = '00:00'.obs;

  Timer timer;

  bool clockStarted = false;

  //------------------------------------- INIT -------------------------------------

  Future init() async {
    if (clockStarted == false) {
      await fireClock();
      clockStarted = true;
    }

    return true;
  }

  //------------------------------------- CLOCK -------------------------------------

  Future fireClock() async {
    DateTime dateTime = DateTime.now();

    String hr = dateTime.hour.toString();
    if (hr.length == 1) hr = "0" + hr;

    String min = dateTime.minute.toString();
    if (min.length == 1) min = "0" + min;

    String finalTime = hr + ":" + min;

    time.value = finalTime;

    Future.delayed(const Duration(seconds: 2), () {
      fireClock();
    });
  }
}
