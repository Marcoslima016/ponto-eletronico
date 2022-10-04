import 'package:custom_app/lib.imports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../clock_timer.imports.dart';

abstract class ISetEditedTime extends ISetEditedDateTime {
  // Future confirmEditDateTime();
  Future<Either<EditCanceled, EditDetails>> call();
}

class SetEditedTime extends ISetEditedTime {
  //

  //========================================= SETAR HORARIO EDITADO =========================================

  Future<Either<EditCanceled, EditDetails>> call() async {
    Either<EditCanceled, EditConfirmed> confirmEditResult = await confirmEditDateTime();

    return confirmEditResult.fold(
      //
      //----------------- ALTERACAO CONFIRMADA -----------------

      (EditCanceled leftResult) {
        //Retorna status de alteracao cancelada
        return Left(leftResult);
      },
      //
      //------------------ ALTERACAO CANCELADA ------------------

      (EditConfirmed editConfirmedResult) async {
        EditDetails editDetails = editConfirmedResult.editDetails;
        //
        String timeSelected = await runPicker();

        editDetails.editedValue = timeSelected;

        //retorna detalhes da alteracao
        return Right(editDetails);
      },
    );
  }

  //======================================= RODAR SELECIONADOR DE HORARIO =======================================

  Future<String> runPicker() async {
    IClockCore clockCore = Get.find<IClockCore>();

    //Resgata hora atual para ser exibida no picker
    String time = clockCore.currentTimeString.value;
    String hr = time.split(":")[0];
    String min = time.split(":")[1];

    //Exibir widget de selecionar horário
    final TimeOfDay timeSelected = await showTimePicker(
      context: Get.context,
      initialTime: TimeOfDay(hour: int.parse(hr), minute: int.parse(min)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomAppConfig.instance.appController.style.colors.primary, // header background color
              onPrimary: Colors.grey[400], // header text color
              onSurface: CustomAppConfig.instance.appController.style.colors.primary, // body text color
              onBackground: Colors.grey[300],
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: CustomAppConfig.instance.appController.style.colors.primary, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );

    //Organizar horário definido, para enviar no return
    String finalHr = timeSelected.hour.toString();
    String finalMin = timeSelected.minute.toString();

    if (finalHr.length == 1) finalHr = "0" + finalHr;
    if (finalMin.length == 1) finalMin = "0" + finalMin;

    String finalTime = finalHr + ":" + finalMin;

    return finalTime;
  }

  //============================ CONFIRMAR EDICAO DE DATA OU HORA (informar motivo ) ============================

  // Future<Either<EditCanceled, EditConfirmed>> confirmEditDateTime() async {
  //   if (Get.find<IClockCore>().idMotivoEdit == null) {
  //     //Se ainda não foi definido um motivo, será feito o processo de definição de motivo

  //     EditConfirmed editConfirmResult = await Navigator.push(
  //       Get.context,
  //       MaterialPageRoute(
  //         builder: (context) => ConfirmEditDateTimeView(),
  //       ),
  //     );

  //     if (editConfirmResult != null) {
  //       return Right(editConfirmResult); ////Em caso de alteracao confirmada, retorna dados da edicao (motivo selecionado)
  //     } else {
  //       return Left(EditCanceled()); ////Se a edicao for cancelada, retorna status de edicao cancelada
  //     }
  //   } else {
  //     //Se ja foi definido um motivo, retorna esse motivo definido
  //     return Right(
  //       EditConfirmed(
  //         editDetails: EditDetails(
  //           idMotivo: Get.find<IClockCore>().idMotivoEdit,
  //           txtMotivo: Get.find<IClockCore>().txtMotivoEdit,
  //         ),
  //       ),
  //     );
  //   }
  // }
}
