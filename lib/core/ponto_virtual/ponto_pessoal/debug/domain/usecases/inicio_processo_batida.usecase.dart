import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../../../../../lib.imports.dart';
import '../domain.imports.dart';

abstract class IInicioProcessoBatida {
  Future<DadosProcesso> call();
}

class InicioProcessoBatida implements IInicioProcessoBatida {
  IPontoPessoalDebugRepository repository;

  InicioProcessoBatida({
    @required this.repository,
  });

  @override
  Future<DadosProcesso> call() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;

    PontoVirtual pontoVirtual = PontoVirtual.instance;

    DadosProcesso dados = DadosProcesso(
      emailUsuario: VariaveisGlobais.instance.email,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      data: await _getDateTime(),
      hr: pontoVirtual.clockTimerController.time,
      appVersion: version + " - " + code,
      deviceId: await _getDeviceId(),
    );

    await repository.setInicioProcessoDeBatida(
      dadosProcesso: dados,
    );

    return dados;
  }

  Future _getDeviceId() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }

      return identifier;
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  Future _getDateTime() async {
    dynamic day = DateTime.now().day;
    dynamic month = DateTime.now().month;
    var year = DateTime.now().year;

    if (day < 10) {
      day = '0$day';
    }
    if (month < 10) {
      month = '0$month';
    }
    return '$day/$month/$year';
  }
}
