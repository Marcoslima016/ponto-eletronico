import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core.imports.dart';

abstract class IProcessQrColab {
  Future<QrColabData> call(String scanResult);
}

class ProcessQrColab implements IProcessQrColab {
  //
  @override
  Future<QrColabData> call(String scanResult) async {
    String dataDecrypted = EncryptUtil.instance.decrypt(scanResult);
    QrColabData qrData = QrColabData.fromJson(jsonDecode(dataDecrypted));
    return qrData;
  }
}
