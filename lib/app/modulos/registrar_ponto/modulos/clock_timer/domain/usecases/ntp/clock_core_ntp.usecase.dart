import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../usecases.imports.dart';
import '../../domain.imports.dart';

import '../../../clock_timer.imports.dart';

class ClockCoreNTP implements IClockCore {
  //

  RxString currentDateString = "00/00".obs;

  DateTime currentDate;

  @override
  DateTime currentTime;

  @override
  RxString currentTimeString = "".obs;

  @override
  RxString curretTimeWithFusoString = "".obs;

  @override
  RxBool timeEdited = false.obs;
  @override
  String txtMotivoEdit;
  @override
  int idMotivoEdit;

  ISetEditedTime setEditedTimeUsecase;

  ISetEditedDate setEditedDateUsecase;

  ClockCoreNTP({
    @required this.setEditedTimeUsecase,
    @required this.setEditedDateUsecase,
  }) {
    // setCurrentDateString();
  }

  Future reset() async {
    currentDateString = "00/00".obs;
    currentDate = null;
    currentTime = null;
    currentTimeString = "".obs;
    curretTimeWithFusoString = "".obs;
    timeEdited = false.obs;
    txtMotivoEdit = null;
    idMotivoEdit = null;
  }

  ///@override
  /// editDetails;

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //-------------------------------------- DEFINIR DATA --------------------------------------

  setCurrentDateString() {
    DateTime date = DateTime.now();
    String day = date.day.toString();
    if (day.length == 1) day = "0" + day;
    String month = date.month.toString();
    if (month.length == 1) month = "0" + month;
    String year = date.year.toString();
    String finalDate = day + "/" + month + "/" + year;
    currentDate = date;
    currentDateString.value = finalDate;
  }

  //------------------------------------ ATUALIZAR HORARIO ------------------------------------

  Future updateCurrentTime(DateTime newCurrentTime) async {
    if (timeEdited.value == false) {
      currentTime = newCurrentTime;
      currentTimeString.value = newCurrentTime.localeDate();
      curretTimeWithFusoString.value = newCurrentTime.localeDateWithFuso();
    }
  }

  //---------------------------------- SETAR HORARIO EDITADO ----------------------------------

  @override
  Future setEditedTime() async {
    Either<EditCanceled, EditDetails> editResult = await setEditedTimeUsecase();
    editResult.fold(
      (l) => null,
      (EditDetails editDetails) {
        timeEdited.value = true;
        currentTimeString.value = editDetails.editedValue;
        curretTimeWithFusoString.value = currentTimeString.value;
        txtMotivoEdit = editDetails.txtMotivo;
        idMotivoEdit = editDetails.idMotivo;
      },
    );
  }

  //-------------------------------------- ALTERAR DATA --------------------------------------

  @override
  Future setEditedDate() async {
    Either<EditCanceled, EditDetails> editResult = await setEditedDateUsecase();
    editResult.fold(
      (l) => null,
      (EditDetails editDetails) {
        timeEdited.value = true;

        String day = editDetails.editedValue.split("/")[0];
        if (day.length == 1) day = "0" + day;
        String month = editDetails.editedValue.split("/")[1];
        if (month.length == 1) month = "0" + month;
        String year = editDetails.editedValue.split("/")[2];

        String finalDateString = day + "/" + month + "/" + year;

        String dateStringFormated = year + "-" + month + "-" + day + " 00:00:00.000";
        DateTime parseDt = DateTime.parse(dateStringFormated);

        txtMotivoEdit = editDetails.txtMotivo;
        idMotivoEdit = editDetails.idMotivo;

        currentDateString.value = finalDateString;
        currentDate = parseDt;
      },
    );
  }

  // String _getDateString(DateTime date) {
  //   return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  // }
}
