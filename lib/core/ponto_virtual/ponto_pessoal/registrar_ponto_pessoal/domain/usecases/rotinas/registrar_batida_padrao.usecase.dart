import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../registrar_ponto_pessoal.imports.dart';
import '../debug_manager.usecase.dart';
import '../usecases.imports.dart';
import 'rotina_ponto_pessoal.interface.usecase.dart';

import '../../../../ponto_pessoal.imports.dart';

/// Rotina de batida de ponto pessoal onde NAO é realizada a confirmação de identidade
/// (não utiliza reconhecimento facial e de digital como confirmação de quem esta realizando a batida)
class RegistrarBatidaPadrao extends DebugManager implements IRotinaPontoPessoal {
  //
  @override
  String idRotina = "padrao";

  //---------------------------------------- INICIAR ROTINA ----------------------------------------

  @override
  Future<bool> dispararRotina({@required Function onTrabalhadorValidado}) async {
    //

    //REALIZAR VALIDACAO DO TRABALHADOR
    bool trabalhadorValidado = await validarTrabalhador();

    if (trabalhadorValidado == true) {
      //
      //---- Trabalhador validado ----

      await onTrabalhadorValidado(); //// Notificar trabalhadaor validado

      // notificarTrabalhadorValidado(); ////*** DEBUG ***/
      //
      await contabilizarBatida(); //// Contabilizar batida

      return true;
    } else {
      //
      //----- Falha na validacao -----
      //
      return false;
    }
  }

  //--------------------------------------- VALIDAR TRABALHADOR ---------------------------------------

  Future<bool> validarTrabalhador() async {
    bool result = await Get.find<IValidarTrabalhador>()();
    var p = "";
    return result;
  }

  //--------------------------------------- CONTABILIZAR BATIDA ---------------------------------------

  //@override (ou, ficara dentro da classe abstract nao precisando ser sobrescrito na implementacao, para poder ser utilizado em outras rotinas)
  Future contabilizarBatida() async {
    await Get.find<IContabilizarBatida>()(printLog: true);
  }

  //
}
