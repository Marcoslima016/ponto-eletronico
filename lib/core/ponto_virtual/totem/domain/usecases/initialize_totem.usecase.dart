import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

abstract class IInitializeTotem {
  Future call({@required Future Function() onFail});
}

class InitializeTotem implements IInitializeTotem {
  ITotemCore totemCore;
  IActivateTotem usecaseActivateTotem;
  IBatidasHandler usecaseBatidasHandler;
  ITotemRepository repository;
  IRotinaSync usecaseRotinaSync;
  IInitializeHomePage usecaseInitializeHomePage;

  Future Function() onFail;

  InitializeTotem({
    @required this.totemCore,
    @required this.usecaseActivateTotem,
    @required this.usecaseBatidasHandler,
    @required this.repository,
    @required this.usecaseRotinaSync,
    @required this.usecaseInitializeHomePage,
  });

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  @override
  Future call({@required Future Function() onFail}) async {
    // Redireciona para a tela de ativacao do totem, se ainda nao estiver ativo
    // Gerencia as permissões

    this.onFail = onFail;

    String token = await totemCore.recoverSession();

    if (token != null && token != "") {
      //
      //-------- JA ESTA ATIVADO --------

      // await totemCore.disconnectSession();
      await initialize();
    } else {
      //
      //----- AINDA NÃO FOI ATIVADO -----
      var p = "";
      await activate();
    }
  }

  //------------------------------------------- ACTIVATE -------------------------------------------

  //ATIVAR O TOTEM (FAZER LOGIN )
  Future activate() async {
    await usecaseActivateTotem(
      onActivate: () async {
        await initialize();
      },
      //OnFail: () async {},
    );
  }

  //------------------------------------------- INITIALIZE -------------------------------------------

  //INICIALIZAR O TOTEM
  Future initialize() async {
    // Get.to(InitializingView());

    //--- EXIBIR TELA DE INICIALIZACAO ---
    Navigator.pushReplacement(
      Get.context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => InitializingView(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 1200),
        reverseTransitionDuration: Duration(milliseconds: 1100),
      ),
    );

    //await batidasHandler.loadBatidas();
    await loadColabList();
    await carregarBatidas();
    await usecaseRotinaSync.iniciarRotina();
    await TotemController.instance.facialRecognition.initFacialRecognitionTotem();
    await redirectToHome();
  }

  //----------------------------------------- LOAD COLAB LIST -----------------------------------------
  //CARREGAR OS DADOS ( lista de colabs )

  Future loadColabList() async {
    await TotemController.instance.colabListManager.loadList();
  }

  //----------------------------------------- CARREGAR BATIDAS -----------------------------------------

  Future carregarBatidas() async {
    await usecaseBatidasHandler.carregarBatidas();
  }

  //------------------------------------- REDIRECIONAR PARA A HOME -------------------------------------

  Future redirectToHome() async {
    await usecaseInitializeHomePage();
  }
}
