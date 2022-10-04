import 'package:custom_app/lib.imports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../clock_timer.imports.dart';

abstract class ISetEditedDate extends ISetEditedDateTime {
  // Future confirmEditDateTime();
  Future<Either<EditCanceled, EditDetails>> call();
}

class SetEditedDate extends ISetEditedDate {
  //

  //========================================= SETAR HORARIO EDITADO =========================================

  Future<Either<EditCanceled, EditDetails>> call() async {
    Either<EditCanceled, EditConfirmed> confirmEditResult = await confirmEditDateTime();

    return confirmEditResult.fold(
      //
      //----------------- ALTERACAO CANCELADA -----------------

      (EditCanceled leftResult) {
        //Retorna status de alteracao cancelada
        return Left(leftResult);
      },
      //
      //----------------- ALTERACAO CONFIRMADA -----------------

      (EditConfirmed editConfirmedResult) async {
        EditDetails editDetails = editConfirmedResult.editDetails;
        //
        String dateSelected = await runPicker();

        editDetails.editedValue = dateSelected;

        //retorna detalhes da alteracao
        return Right(editDetails);
      },
    );
  }

  //======================================= RODAR SELECIONADOR DE HORARIO =======================================

  Future<String> runPicker() async {
    IClockCore clockCore = Get.find<IClockCore>();

    DateTime dateSelected = await showDatePicker(
      context: Get.context,
      initialDate: clockCore.currentDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    String dateSelectedString = dateSelected.day.toString() + "/" + dateSelected.month.toString() + "/" + dateSelected.year.toString();

    return dateSelectedString;
  }
}
