import 'package:get/get.dart';

import '../clock_timer.imports.dart';

class ClockTimerController extends GetxController {
  //
  DateTime get currentTime => Get.find<IClockCore>().currentTime;

  String get time => Get.find<IClockCore>().currentTimeString.value;

  String get timeWithFuso => Get.find<IClockCore>().curretTimeWithFusoString.value;

  String get currentDate => Get.find<IClockCore>().currentDateString.value;

  String get txtMotivoEdit => Get.find<IClockCore>().txtMotivoEdit;

  int get idMotivoEdit => Get.find<IClockCore>().idMotivoEdit;

  RxBool clockStarted = false.obs;

  Future runClock() async {
    clockStarted.value = false;
    Get.find<IClockCore>().reset();
    IRunClock runClockUsecase = Get.find<IRunClock>();
    await runClockUsecase();
    clockStarted.value = true;
  }

  Future editTime() async {
    await Get.find<IClockCore>().setEditedTime();
  }

  Future editDate() async {
    await Get.find<IClockCore>().setEditedDate();
  }

  // @override
  // void onClose() {
  //   print('dispose');
  //   Get.find<IClockCore>().close();
  //   super.onClose();
  // }
}
