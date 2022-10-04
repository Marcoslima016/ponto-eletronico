import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ponto_pessoal.imports.dart';
import '../../registrar_ponto_pessoal.imports.dart';
import 'rotinas/rotinas.imports.dart';

abstract class IRegistrarPontoPessoal {
  String txtEstagioProcesso = "";
  RxBool timeoutHit;
  Future iniciarProcessoDeBatida();
  Future runTimeout();
  Future cancelTimeout();
}

class RegistrarPontoPessoal implements IRegistrarPontoPessoal {
  //

  String txtEstagioProcesso = "";

  RxBool timeoutHit = false.obs;

  bool _timeoutActive = false;

  ///Metodo que inicializa o processo de batida de ponto
  ///(obs: não refere diretamente a batida de ponto pois ainda não é certo que a mesma de fato será realizada, sendo
  /// necessario passar por algumas etapas antes de oficializar a batida, como por exemplo validar via pin)
  Future iniciarProcessoDeBatida() async {
    //***** LOG *****/
    await LogRegistrarPontoController.instance.startCycle();
    //***************/

    //***** LOG *****/
    await LogRegistrarPontoController.instance.writeLogListaDeBatidasDoInicioDoProcesso(Get.find<IBatidasRepository>());
    //***************/

    IRotinaPontoPessoal rotina = RegistrarBatidaPadrao();

    if (FacialRecognitionPontoPessoalController.instance.activate) {
      rotina = RegistrarBatidaAutenticada();
    }

    //***** LOG *****/
    await LogRegistrarPontoController.instance.writeLogRotinaExecutada(rotina.idRotina);
    //***************/

    bool interromperBatidaForaDeLocal = await Get.find<IConfirmarBatidaForaDeLocal>().call(
      //
      //---- Se o usuário optou por continuar a batida ----
      //
      continuarProcesso: () async {
        //
        return false;
        //
      },
      //---- Se o usuário optou por interromper a batida ----
      //
      interromperProcesso: () async {
        return true;
      },
    );

    if (interromperBatidaForaDeLocal) return;

    //***** LOG *****/
    await LogRegistrarPontoController.instance.writeLogCheckPoint1();
    //***************/

    //DISPARAR ROTINA DE REGISTRO DA BATIDA
    RegistrandoBatidaView paginaRegistrando = RegistrandoBatidaView();
    bool rotinaExecutadaComSucesso = await rotina.dispararRotina(
      onTrabalhadorValidado: () async {
        //
        //--- Exibir tela "Registrando batida" ---
        Navigator.pushReplacement(
          Get.context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => paginaRegistrando,
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 900),
            reverseTransitionDuration: Duration(milliseconds: 1100),
          ),
        );
      },
    );

    //*** LOG ***/
    await LogRegistrarPontoController.instance.writeLogListaDeBatidasDoFimDoProcesso(Get.find<IBatidasRepository>());
    //***********/

    //SE A ROTINA FOI EXECUTADA COM SUCESSO
    if (rotinaExecutadaComSucesso) {
      //*** LOG ***/
      await LogRegistrarPontoController.instance.writeLogFimDoProcesso("Batida Realizada!");
      //***********/

      //Notificar tela "Registrando batida" a respeito da conclusao do processo
      paginaRegistrando.controller.processoConcluido();
    } else {
      //*** LOG ***/
      await LogRegistrarPontoController.instance.writeLogFimDoProcesso("Batida Cancelada!");
      //***********/

      //Notificar tela "Registrando batida" a respeito do cancelamento do processo
      paginaRegistrando.controller.processoCancelado();
    }

    //*** LOG ***/
    await LogRegistrarPontoController.instance.concludeCycle();
    //***********/
  }

  //------------------------------------------- TIMEOUT -------------------------------------------

  //Timeout do processo de registrar ponto
  Future runTimeout() async {
    _timeoutActive = true;
    timeoutHit.value = false;
    Future.delayed(const Duration(seconds: 10), () async {
      if (_timeoutActive) {
        timeoutHit.value = true;
        //***** LOG *****/
        await LogRegistrarPontoController.instance.writeLogTimeoutUsecaseFired();
        //***************/
      }
    });
  }

  Future cancelTimeout() async {
    _timeoutActive = false;
  }
}
