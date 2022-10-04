import 'package:graphql/client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../../../../../lib.imports.dart';
import 'dart:io';

class LogAppController {
  //

  LogAppRepository repository = LogAppRepository();

  List<LogCycle> get cycles => repository.cycles;

  // PontoVirtual pontoVirtual = PontoVirtual.instance;

  static final LogAppController instance = LogAppController._(); //// Armazena a instancia utilizada no singleton
  LogAppController._() {}

  //========================================================= INIT ==========================================================

  Future init() async {
    await repository.loadCycles();
    // tenta sincronizar ciclos parados na fila, de execucoes anteriores
    repository.syncCycles();
  }

  //===================================================== START CYCLE ======================================================

  Future startCycle() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    String atualTime = await getTime();

    Map<String, dynamic> dataJson = {
      "idProcesso": timestamp,
      "data": await _getDate(),
      "hr": atualTime,
      "emailUsuario": VariaveisGlobais.instance.email,
      "appVersion": version,
      "deviceId": await _getDeviceId(),
    };

    String refEmail = VariaveisGlobais.instance.email.replaceAll("@", "").replaceAll(".", "");

    LogCycle newLogCycle = LogCycle(
      ts: timestamp,
      dataJson: dataJson,
      userPath: refEmail,
      cyclePath: DateTime.now().day.toString() + "-" + DateTime.now().month.toString() + "_" + atualTime,
    );
    await repository.addCycle(newLogCycle);
  }

  //==================================================== CONCLUDE CYCLE =====================================================

  Future concludeCycle() async {
    // sincronizar ciclos que estao na fila
    await repository.syncCycles();
  }

  //========================================================== LOGS ==========================================================

  //----------------------------------- APP STATES ----------------------------------

  //----------------- APP MINIMIZADO ----------------

  Future writeLogAppMinimizado() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "appMinimizado",
      "hr": await getTime(),
      "data": await _getDate(),
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //------------------- APP ABERTO ------------------

  Future writeLogAppAberto() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "appAberto",
      "hr": await getTime(),
      "data": await _getDate(),
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //===================================================== GET DATE TIME ======================================================

  Future getTime() async {
    String hour = DateTime.now().hour.toString();
    String min = DateTime.now().minute.toString();
    String second = DateTime.now().second.toString();
    return hour + ":" + min + ":" + second;
  }

  //======================================================== GET DATE =========================================================

  Future<String> _getDate() async {
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

  //===================================================== GET DEVICE ID ======================================================

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
}
