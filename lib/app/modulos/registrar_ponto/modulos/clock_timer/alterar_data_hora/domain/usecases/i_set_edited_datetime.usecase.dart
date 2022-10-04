import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../clock_timer.imports.dart';
import '../domain.imports.dart';

abstract class ISetEditedDateTime {
  // Future<Either<EditCanceled, EditConfirmed>> confirmEditDateTime();

  Future<String> runPicker();

  Future<Either<EditCanceled, EditConfirmed>> confirmEditDateTime() async {
    if (Get.find<IClockCore>().idMotivoEdit == null) {
      //Se ainda não foi definido um motivo, será feito o processo de definição de motivo

      EditConfirmed editConfirmResult = await Navigator.push(
        Get.context,
        MaterialPageRoute(
          builder: (context) => ConfirmEditDateTimeView(),
        ),
      );

      if (editConfirmResult != null) {
        return Right(editConfirmResult); ////Em caso de alteracao confirmada, retorna dados da edicao (motivo selecionado)
      } else {
        return Left(EditCanceled()); ////Se a edicao for cancelada, retorna status de edicao cancelada
      }
    } else {
      //Se ja foi definido um motivo, retorna esse motivo definido
      return Right(
        EditConfirmed(
          editDetails: EditDetails(
            idMotivo: Get.find<IClockCore>().idMotivoEdit,
            txtMotivo: Get.find<IClockCore>().txtMotivoEdit,
          ),
        ),
      );
    }
  }
}
