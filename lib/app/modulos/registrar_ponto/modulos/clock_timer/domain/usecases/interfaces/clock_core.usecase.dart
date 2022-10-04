import 'package:get/get.dart';

abstract class IClockCore {
  //
  RxString currentDateString;

  DateTime currentDate;

  DateTime currentTime;

  RxString currentTimeString = "".obs;

  RxString curretTimeWithFusoString = "".obs;

  RxBool timeEdited = false.obs;
  String txtMotivoEdit;
  int idMotivoEdit;

  Future reset();

  setCurrentDateString();

  Future updateCurrentTime(DateTime newCurrentTime);

  // Future setChangedDTHR();

  Future setEditedTime();

  Future setEditedDate();
}
