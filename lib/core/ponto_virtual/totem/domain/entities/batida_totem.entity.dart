import 'dart:convert';

import 'package:enum_from_json/enum_from_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ponto_virtual.imports.dart';

enum BatidaStatus {
  inQueue,
  synchronized,
}

class BatidaTotem {
  int internalId;
  final bool error;
  final String usuario;
  final String pessoasId;
  final String dthrBatida;
  final String tipo;
  final String lat;
  final String lon;
  final int loccheckpontoId;
  final int distancia;
  final int locFalsa;
  final int cdMotivo;
  final String motivo;
  final String fuso;
  final String urlFoto;
  final String nome;
  BatidaStatus status;
  RxBool hasError = false.obs;

  BatidaTotem({
    this.internalId,
    @required this.error,
    @required this.usuario,
    @required this.pessoasId,
    @required this.dthrBatida,
    @required this.cdMotivo,
    @required this.distancia,
    @required this.lat,
    @required this.lon,
    @required this.locFalsa,
    @required this.loccheckpontoId,
    @required this.motivo,
    @required this.tipo,
    @required this.fuso,
    @required this.urlFoto,
    @required this.nome,
    this.status = BatidaStatus.inQueue,
  }) {
    if (internalId == null) internalId = DateTime.now().millisecondsSinceEpoch;
    hasError.value = false;
  }

  static convertListFromJson(List data) async {
    if (data == null) return [];
    var listPersist = data.map((x) {
      return BatidaTotem.fromJson(json.decode(x));
    }).toList();
    return listPersist;
  }

  //FROM JSON
  factory BatidaTotem.fromJson(Map<String, dynamic> json) {
    return BatidaTotem(
      internalId: json['internalId'],
      error: json['error'],
      usuario: json['usuario'],
      pessoasId: json['pessoasId'],
      dthrBatida: json['dthrBatida'],
      cdMotivo: json['cdMotivo'],
      distancia: json['distancia'],
      lat: json['lat'],
      lon: json['lon'],
      locFalsa: json['locFalsa'],
      loccheckpontoId: json['loccheckpontoId'],
      motivo: json['motivo'],
      tipo: json['tipo'],
      fuso: json['fuso'],
      urlFoto: json['urlFoto'],
      nome: json['nome'],
      status: EnumFromJson.convert(itemType: BatidaStatus.values, value: json['status']),

      // dadosRegistro: RegistroBatida.fromJson(json['dadosRegistro']),
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    var point = "";
    return {
      'internalId': internalId,
      'error': error,
      'usuario': usuario,
      'pessoasId': pessoasId,
      'dthrBatida': dthrBatida,
      'cdMotivo': cdMotivo,
      'distancia': distancia,
      'lat': lat,
      'lon': lon,
      'locFalsa': locFalsa,
      'loccheckpontoId': loccheckpontoId,
      'motivo': motivo,
      'tipo': tipo,
      'fuso': fuso,
      'urlFoto': urlFoto,
      'nome': nome,
      'status': status.toString(),
    };
  }

  //FROM API
  factory BatidaTotem.fromAPI(Map<String, dynamic> json) {
    return BatidaTotem(
      // dthrBatida: Batida.determinarHorario(json["dt_hr_batida"]),
      dthrBatida: json["dt_hr_batida"],
      cdMotivo: null,
      distancia: null,
      error: null,
      fuso: null,
      lat: null,
      locFalsa: null,
      loccheckpontoId: null,
      lon: null,
      motivo: null,
      nome: null,
      pessoasId: null,
      tipo: null,
      urlFoto: null,
      usuario: null,
      internalId: null,
      status: null,
    );
  }
}
