import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../lib.imports.dart';
import '../domain.imports.dart';

abstract class IActivateTotem {
  Future call({@required Future Function() onActivate});
  Future Function() onActivate;
  Future receiveQrScanResult(String scanResult);
}

class ActivateTotem implements IActivateTotem {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  IProcessQrResult usecaseProcessQrResult;

  ///Futuramente deverá receber via metodo construtor/gerenciador de dependencia
  ILoginTotem usecaseLogin;

  ///Futuramente deverá receber via metodo construtor/gerenciador de dependencia
  ITotemCore totemCore;

  Future Function() onActivate;

  ///[=================== CONSTRUTOR ===================]
  ///

  ActivateTotem({
    @required this.usecaseLogin,
    @required this.totemCore,
    @required this.usecaseProcessQrResult,
  });
  //---------------------------------------- CALL ----------------------------------------

  @override
  Future call({@required Future Function() onActivate}) async {
    this.onActivate = onActivate;
    // Get.to(
    //   ActivateTotemView(
    //     onReadCode: receiveQrScanResult,
    //   ),
    // );

    Navigator.push(
      Get.context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => ActivateTotemView(
          onReadCode: receiveQrScanResult,
        ),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 1200),
        reverseTransitionDuration: Duration(milliseconds: 1100),
      ),
    );

    var p = "";
  }

  //--------------------------- DISPARAR TENTATIVA DE ATIVACAO ---------------------------

  @override
  Future receiveQrScanResult(String scanResult) async {
    try {
      LoginCredentials loginCredentials = await processQrCode(scanResult);
      await Future.delayed(const Duration(milliseconds: 1200), () {});
      await loginAttempt(loginCredentials);
      var p = "";
    } catch (e) {
      var p = "";
      throw (e);
    }
  }

  //---------------------------------- PROCESSAR QR CODE ----------------------------------

  Future<LoginCredentials> processQrCode(String scanResult) async {
    LoginCredentials loginCredentials;
    try {
      loginCredentials = await usecaseProcessQrResult(scanResult);
      return loginCredentials;
    } catch (e) {
      return null;
      // throw ("qr_invalido");
    }
  }

  //------------------------------------ TENTAR LOGAR ------------------------------------

  Future loginAttempt(LoginCredentials credentials) async {
    Either<Exception, String> loginAttemptResult = await usecaseLogin(credentials);

    return loginAttemptResult.fold(
      (Exception error) async {
        //ERRO
        var p = "";
        throw (error);
      },
      (String token) async {
        //SUCESSO
        await totemCore.saveSession(token);
        onActivate();
      },
    );
  }

  //
}
