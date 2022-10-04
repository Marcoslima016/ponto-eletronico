import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../../lib.imports.dart';

class QrPageController {
  //
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Future Function(String code) onReadCode;

  QRViewController qrController;

  bool analysingScanResult = false;

  RxString time = '00:00'.obs;

  Timer timer;

  bool clockStarted = false;

  RxBool qrDetected = false.obs;

  // RxList<CameraFacing> cameraPosition = [CameraFacing.front].obs;

  CameraFacing cameraPosition;

  //------------------------------------- INIT -------------------------------------

  Future init() async {
    if (clockStarted == false) {
      await fireClock();
      clockStarted = true;
    }

    return true;
  }

  //------------------------------------- CLOCK -------------------------------------

  Future fireClock() async {
    DateTime dateTime = DateTime.now();

    String hr = dateTime.hour.toString();
    if (hr.length == 1) hr = "0" + hr;

    String min = dateTime.minute.toString();
    if (min.length == 1) min = "0" + min;

    String finalTime = hr + ":" + min;

    time.value = finalTime;

    Future.delayed(const Duration(seconds: 2), () {
      fireClock();
    });
  }

  //--------------------------- ON TAP ESTOU SEM CODIO QR ---------------------------

  Future onTapEstouSemCodigoQR() async {
    await PontoVirtual.instance.totemController.tentarRegistrarPontoViaMatricula();
  }

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

      // await receiveScanResult(scanData.code);

      Future.delayed(const Duration(milliseconds: 1200), () async {
        await qrController.resumeCamera();
      });

      Future.delayed(const Duration(milliseconds: 1000), () async {
        qrDetected.value = false;
      });

      await PontoVirtual.instance.totemController.tentarRegistrarPontoViaQr(scanResult: scanData.code);

      //Apos contabilizar a batida, é disparado um delay antes de liberar o leitor qr para o proximo colab
      await Future.delayed(const Duration(milliseconds: 2000), () async {});

      analysingScanResult = false;
    });
  }

  //-------------------------------- change camera position --------------------------------

  Future changeCameraPosition() async {
    if (cameraPosition == CameraFacing.back) {
      // cameraPosition.add(CameraFacing.front);
      print("NAVEGAR PARA A PAGINA  !!!!!!!!!!!!!!!  NEW POSITION: FRONT");
      Get.off(Container());
      Get.off(QrPageView(cameraPosition: CameraFacing.front));
    } else if (cameraPosition == CameraFacing.front) {
      // cameraPosition.add(CameraFacing.back);
      print("NAVEGAR PARA A PAGINA  !!!!!!!!!!!!!!!  NEW POSITION: BACK");
      Get.off(Container());
      Get.off(QrPageView(cameraPosition: CameraFacing.back));
    }
  }
}
