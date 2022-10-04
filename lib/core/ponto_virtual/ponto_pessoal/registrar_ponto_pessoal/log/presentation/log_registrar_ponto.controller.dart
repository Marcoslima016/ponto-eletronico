import 'package:graphql/client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../../../../../lib.imports.dart';
import '../log.imports.dart';
import 'dart:io';

class LogRegistrarPontoController {
  //

  LogRegistrarPontoPessoalRepository repository = LogRegistrarPontoPessoalRepository();

  List<LogCycle> get cycles => repository.cycles;

  PontoVirtual pontoVirtual = PontoVirtual.instance;

  static final LogRegistrarPontoController instance = LogRegistrarPontoController._(); //// Armazena a instancia utilizada no singleton
  LogRegistrarPontoController._() {}

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

    String atualTime = pontoVirtual.clockTimerController.time;

    Map<String, dynamic> dataJson = {
      "idProcesso": timestamp,
      "data": await _getDateTime(),
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

  //--------------------------------- ROTINA EXECUTADA --------------------------------

  Future writeLogRotinaExecutada(String rotina) async {
    Map<String, dynamic> dataJson = {
      "logTitle": "TipoDeRotinaExecutada",
      "rotinaExecutada": rotina,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //-------------------------------- BATIDA FORA DE LOCAL --------------------------------

  Future writeLogBatidaForaDeLocal(String continueStatus) async {
    Map<String, dynamic> dataJson = {
      "logTitle": "batidaForaDelocal",
      "continuarProcessoDeBatida": continueStatus,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //----------------------------------- CHECK POINT 1 -----------------------------------

  Future writeLogCheckPoint1() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "checkPoint1",
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //---------------------------------- TIMEOUT USECASE ----------------------------------

  Future writeLogTimeoutUsecaseFired() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "timeoutUsecaseFired",
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //--------------------------------- START CONTABILIZAR ----------------------------------

  Future writeLogStartContabilizar() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "startProcessoContabilizar",
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //----------------------------------- CHECK POINT 2 -----------------------------------

  Future writeLogCheckPoint2() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "checkPoint2",
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //--------------------------- BATIDA JA EXISTENTE NO HORARIO ----------------------------

  Future writeLogBatidaJaExistente(String status) async {
    Map<String, dynamic> dataJson = {
      "logTitle": "batidaJaExistenteNoHorario",
      "status": status,
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //------------------------------ BATIDA REALIZADA OFFLINE -------------------------------

  Future writeLogBatidaOffline() async {
    Map<String, dynamic> dataJson = {
      "logTitle": "batidaOffline",
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //------------------------------- BATIDAS INICIO PROCESSO -------------------------------

  Future writeLogListaDeBatidasDoInicioDoProcesso(BatidasDoDiaRepository batidasRepository) async {
    Map<String, dynamic> finalMap = {};
    int i = 0;
    for (Batida batida in batidasRepository.baseList) {
      finalMap[i.toString()] = batida.toMap();
      i++;
    }

    Map<String, dynamic> dataJson = {
      "logTitle": "listaDeBatidasNoInicioDoProcesso",
      "batidas": finalMap,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //------------------------------- BATIDAS FIM PROCESSO -------------------------------

  Future writeLogListaDeBatidasDoFimDoProcesso(BatidasDoDiaRepository batidasRepository) async {
    Map<String, dynamic> finalMap = {};
    int i = 0;
    for (Batida batida in batidasRepository.baseList) {
      finalMap[i.toString()] = batida.toMap();
      i++;
    }

    Map<String, dynamic> dataJson = {
      "logTitle": "listaDeBatidasNoFimDoProcesso",
      "batidas": finalMap,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //---------------------------------- FIM DO PROCESSO ----------------------------------

  Future writeLogFimDoProcesso(String status) async {
    Map<String, dynamic> dataJson = {
      "logTitle": "fimDoProcesso",
      "statusProcesso": status,
      "hr": pontoVirtual.clockTimerController.time,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //---------------------------------- APP MINIMIZADO ----------------------------------

  // Future writeLogAppMinimizado(String status) async {
  //   Map<String, dynamic> dataJson = {
  //     "logTitle": "appMinimizado",
  //     "hr": pontoVirtual.clockTimerController.time,
  //   };
  //   cycles.last.logs.add(dataJson);
  //   await repository.saveCyclesList();
  // }

  //------------------------- ERRO REQUISICAO CONTABILIZAR -------------------------

  Future writeLogErroReqContabilizar(List<GraphQLError> graphqlErrors, String connectionError) async {
    String finalErrorsString = "";

    for (GraphQLError error in graphqlErrors) {
      finalErrorsString = finalErrorsString + " / " + error.message;
    }

    Map<String, dynamic> dataJson = {
      "logTitle": "ErroReqContabilizar",
      "hr": pontoVirtual.clockTimerController.time,
      "graphql_errors": finalErrorsString,
      "connection_error": connectionError,
    };
    cycles.last.logs.add(dataJson);
    await repository.saveCyclesList();
  }

  //===================================================== GET DATE TIME ======================================================

  Future<String> _getDateTime() async {
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
