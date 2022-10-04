import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../lib.imports.dart';
import '../../../../../ponto_virtual.imports.dart';

///Usecase responsável por verificar se a batida esta sendo feita fora de local permitido, e
/// se estiver fora de local, é exibida uma confirmação para o usuário, onde o usuário pode decidir prosseguir com a
/// batida ou cancelar o processo.
abstract class IConfirmarBatidaForaDeLocal {
  Future call({Future Function() continuarProcesso, Future Function() interromperProcesso});
}

class ConfirmarBatidaForaDeLocal implements IConfirmarBatidaForaDeLocal {
  ConfirmarBatidaForaDeLocal();

  @override
  Future call({Future Function() continuarProcesso, Future Function() interromperProcesso}) async {
    PontoVirtual pontoVirtual = PontoVirtual.instance;
    if (pontoVirtual.localizacaoBatida.batidaFeitaEmLocalPermitido.value == false) {
      //
      //----- Se a batida esta sendo feita fora de local permitido, exibe confirmação ao usuario -----
      //

      //Exibir popup verificando se o trabalhador deseja continuar a batida mesmo estando fora do local
      bool continueResult = await Popup(
        onClickOk: () async {
          ///Se o usuario optou por continuar a batida, o processo não é interrompido
          Navigator.pop(Get.context, true);
        },
        onClickCancel: () async {
          //Se o usuário optou por não continuar a batida, o processo é interrompido
          Navigator.pop(Get.context, false);
        },
        hasIcon: false,
        type: PopupType.ReplyButtons,
        closeDialogOnPressButton: false,
        blocked: true,
        context: Get.context,
        txtBtnOk: "Continuar",
        txtTitle: "Batida fora de local permitido",
        txtText: "Você esta registrando ponto em uma localização que não corresponde ao endereço cadastrado pela empresa. Deseja continuar?",
        // closeDialogOnPressButton: false,
      ).show();

      if (continueResult == true) {
        //***** LOG *****/
        await LogRegistrarPontoController.instance.writeLogBatidaForaDeLocal("true");
        //***************/
        return await continuarProcesso();
      } else {
        //***** LOG *****/
        await LogRegistrarPontoController.instance.writeLogBatidaForaDeLocal("false");
        //***************/
        return await interromperProcesso();
      }
    } else {
      //
      //--------- Se a batida esta sendo feita dentro de local permitido, continua o processo. --------
      //
      return await continuarProcesso();
    }
  }
  //
}
