import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../ponto_pessoal.imports.dart';

//---------------------- DADOS PROCESSO ----------------------
class DadosProcesso {
  int timestamp;
  int idProcesso;
  String emailUsuario;
  String data;
  String hr;
  String appVersion;
  String deviceId;

  DadosProcesso({
    @required this.timestamp,
    @required this.emailUsuario,
    @required this.data,
    @required this.appVersion,
    @required this.deviceId,
    @required this.hr,
  }) {
    idProcesso = timestamp;
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'idProcesso': idProcesso,
      'emailUsuario': emailUsuario,
      'timestamp': timestamp,
      'data': data,
      'appVersion': appVersion,
      'deviceId': deviceId,
      'hr': hr,
    };
  }
}

class DadosFimProcesso {}

//--------------------- DADOS CONTABILIZAR ---------------------

//Armazena os dados de inicio do processo contabilizar
class DadosContabilizar {
  bool batidaJaExistenteNoHorario = false;
  RegistroBatida dadosNovaBatida;
  int timestampStart;
  int timestampFinish = 0;

  DadosContabilizar({
    @required this.dadosNovaBatida,
    @required this.timestampStart,
  });

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'batidaJaExistenteNoHorario': batidaJaExistenteNoHorario,
      'dadosNovaBatida': dadosNovaBatida?.toMap(),
      'timestampStart': timestampStart,
      'timestampFinish': timestampFinish,
    };
  }
}

///Armazena os dados de conclusao do processo contabilizar
class ContabilizarConcluido {
  int timestampFinish;
  ContabilizarConcluido({
    @required this.timestampFinish,
  });
}
