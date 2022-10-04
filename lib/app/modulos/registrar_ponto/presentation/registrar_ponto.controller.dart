import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../lib.imports.dart';

class PageRegistrarPontoController {
  //

  LocalizacaoBatidaView localizacaoBatidaView = LocalizacaoBatidaView();
  ClockTimerView clockTimerView = ClockTimerView();

  RxBool liberadoRegistrarPonto = false.obs;

  RxString txtEstagioCarregamento = "".obs;

  BuildContext viewContext;

  //Iniciar modulo
  Future initModule() async {
    //
    PontoVirtual pontoVirtualController = PontoVirtual.instance;

    txtEstagioCarregamento.value = "Carregando lista de batidas do dia...";

    while (pontoVirtualController.pontoPessoal.listState.value != ListState.loaded) {
      await Future.delayed(const Duration(milliseconds: 700), () {});
    }

    txtEstagioCarregamento.value = "Carregando locais permitidos a bater ponto...";

    while (pontoVirtualController.enderecosPonto.carregandoListaDeEnderecos.value == true) {
      await Future.delayed(const Duration(milliseconds: 700), () {});
    }

    txtEstagioCarregamento.value = "Recuperando horário verificado...";

    await clockTimerView.controller.runClock();

    txtEstagioCarregamento.value = "Identificando local da batida...";

    await localizacaoBatidaView.controller.initialize();

    txtEstagioCarregamento.value = "Carregamento concluído";

    await Future.delayed(const Duration(milliseconds: 700), () {});

    return true;
  }

  Future onPressedRegistrarPonto() async {
    PontoVirtual pontoVirtualController = PontoVirtual.instance;
    if (pontoVirtualController.localizacaoBatida.falhaNaLocalizacao.value == true) {
      String textFalha = "";

      LocalizacaoBatidaController localizacaocontroller = Get.find<LocalizacaoBatidaController>();
      LocalNaoDefinido datalhesLocalBatida = localizacaocontroller.localDaBatida;

      if (datalhesLocalBatida.falhaNaLocalizacao?.falhasOcorridas[0] == TipoFalhaLocalizacao.permissao) {
        textFalha = "A permissão para acessar localização foi recusada. Instale novamente app, lembrando de aceitar a permissão solicitada";
      }

      for (TipoFalhaLocalizacao tipoFalha in datalhesLocalBatida.falhaNaLocalizacao.falhasOcorridas) {
        if (tipoFalha == TipoFalhaLocalizacao.indisponivel) textFalha = "Serviço de localização indisponível";
      }

      Popup(
        onClickOk: () async {},
        onClickCancel: () async {},
        hasIcon: false,
        type: PopupType.OkButton,
        blocked: true,
        context: Get.context,
        txtBtnOk: "Ok",
        txtTitle: "Erro ao registrar ponto",
        txtText: textFalha,
      ).show();
    } else {
      pontoVirtualController.pontoPessoal.registrarPontoPessoal(
        contextRegistrarPontoPage: this.viewContext,
      );
    }
  }

  // Timer loopObsMapa;
  // Future observarCarregamentoDoMapa() async {
  //   loopObsMapa = Timer.periodic(Duration(milliseconds: 500), (timer) {
  //     print(DateTime.now());
  //   });
  // }
}
