import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../lib.imports.dart';
import '../../../core.imports.dart';
import '../core.imports.dart';

class PontoVirtual {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  bool isOn = false;

  IEnderecosPonto enderecosPonto;

  LocalizacaoBatidaController get localizacaoBatida => Get.find<LocalizacaoBatidaController>();

  IPontoPessoal get pontoPessoal => Get.find<IPontoPessoal>();

  ClockTimerController get clockTimerController => Get.find<ClockTimerController>();

  TotemController totemController = TotemController.instance;

  ///[=================== CONSTRUTOR ===================]

  static final PontoVirtual instance = PontoVirtual._(); //// Armazena a instancia utilizada no singleton
  PontoVirtual._() {
    /// Iniciar dependencias
    PontoVirtualBinding().dependencies();

    enderecosPonto = Get.find<IEnderecosPonto>();
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //------------------------------------------ TURN ON ------------------------------------------

  ///Metodo que inicializa o ponto virtual. Por enquanto é disparado pela homePage da aplicação.
  // Future turnOn() async {
  //   if (isOn == true) return;
  //   isOn = true;

  //   // 1. Recuperar lista de endereços
  //   await enderecosPonto.carregarEnderecos();
  // }

  //--------------------------------------- PONTO PESSOAL ---------------------------------------

  Future atualizarBatidasDoDia() async {
    await pontoPessoal.carregarBatidasDoDia();
  }

  //-------------------------------------------- TOTEM --------------------------------------------

  /// Totem é o sistema que contabiliza a batida de vários trabalhadores, e não um em especifico. É um sistema que fica
  /// disponibilizado fisicamente na empresa para todos os trabalhadores; a identificação é feita no momento da batida.

  //Redirecionar para o totem
  Future inititializeTotem({Function redirectToLogin}) async {
    await totemController.initializeTotem(redirectToLogin: redirectToLogin);
  }

  // Future registrarPontoViaTotem() async {
  //   //
  // }

  Future disconnectTotem() async {
    //
  }

  //---------------------------------------------------------------------------------------------

  Future setInjections() async {
    //
  }
}
