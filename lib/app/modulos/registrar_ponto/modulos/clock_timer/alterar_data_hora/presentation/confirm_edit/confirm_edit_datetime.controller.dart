import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../clock_timer.imports.dart';

class ConfirmEditDateTimeController {
  //
  RxList<Motivo> motivos = [
    Motivo(title: "Atraso", index: 0),
    Motivo(title: "Esqueci de bater o ponto", index: 1),
    Motivo(title: "Outros", index: 2),
  ].obs;

  Motivo motivoSelecionado;

  RxBool motivoFoiSelecionado = false.obs;

  Function(EditConfirmed editConfirmedResult) editConfirmed;
  Function() editCanceled;

  ConfirmEditDateTimeController(
      // {
      //  @required this.editConfirmed,
      //  @required this.editCanceled,
      // }
      );

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  Future returnPage() async {
    // Navigator.pop(Get.context, null);
    await editCanceled();
  }

  Future onSelectMotivo({@required int motivoIndex}) async {
    motivoFoiSelecionado.value = true;
    for (Motivo motivo in motivos) {
      if (motivo.index == motivoIndex) {
        motivoSelecionado = motivo;
        motivo.selected.value = true;
      } else {
        if (motivo.selected.value == true) motivo.selected.value = false;
      }
    }
  }

  Future concluir() async {
    Navigator.pop(
      Get.context,
      EditConfirmed(
        editDetails: EditDetails(idMotivo: motivoSelecionado.index, txtMotivo: motivoSelecionado.title),
      ),
    );
  }
}

class Motivo {
  RxBool selected = false.obs;
  String title = "";
  int index;
  Motivo({
    @required this.title,
    @required this.index,
  }) {
    // if (index == 0) selected = true.obs;
  }
}
