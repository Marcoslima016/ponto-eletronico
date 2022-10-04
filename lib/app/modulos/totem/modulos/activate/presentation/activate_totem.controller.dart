import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../../lib.imports.dart';
import '../activate.imports.dart';

class ActivateTotemPageController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Future Function(String code) onReadCode;

  QRViewController qrController;

  bool analysingScanResult = false;

  RxBool qrDetected = false.obs;

  // IActivateTotem usecaseActivateTotem = ActivateTotem();

  ActivateTotemPageController({
    @required this.onReadCode,
  });

  //-------------------------------- onQRViewCreated --------------------------------

  void onQRViewCreated(QRViewController controller) {
    this.qrController = controller;
    // if (!isLogin) {
    //   this.controller.flipCamera();
    // }
    this.qrController.scannedDataStream.listen((scanData) async {
      if (analysingScanResult) return;
      analysingScanResult = true;

      qrDetected.value = true;
      await Future.delayed(const Duration(milliseconds: 900), () async {});

      await qrController.pauseCamera();

      await receiveScanResult(scanData.code);

      analysingScanResult = false;

      await qrController.resumeCamera();

      qrDetected.value = false;
    });
  }

  //------------------------- PROCESSAR RESULTADO DO SCAN QR -------------------------

  Future receiveScanResult(String scanResult) async {
    try {
      // await usecaseActivateTotem.attemptActivate(scanResult);

      await Future.delayed(const Duration(milliseconds: 300), () {});
      CustomLoad().show();

      await Future.delayed(const Duration(milliseconds: 200), () {});

      await onReadCode(scanResult);
    } catch (e) {
      CustomLoad().hide();
      await Future.delayed(const Duration(milliseconds: 100), () {});
      Get.snackbar("Erro", "Falha ao ativar o Totem.");
    }
  }
}
