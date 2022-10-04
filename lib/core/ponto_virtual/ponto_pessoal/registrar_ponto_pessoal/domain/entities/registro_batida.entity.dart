import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../ponto_pessoal.imports.dart';

class RegistroBatida {
  //extends Batida ??

  int loccheckpontoId;
  String localBatida;

  String tipo;

  String lat;
  String lon;
  int distancia;

  String dthr;
  String fuso;

  String txtMotivo;
  int idMotivo;

  RegistroBatida({
    @required this.loccheckpontoId,
    // @required TipoBatida tipoBatida,
    @required this.tipo,
    @required this.lat,
    @required this.lon,
    @required this.distancia,
    @required this.dthr,
    @required this.fuso,
    @required this.localBatida,
    @required this.txtMotivo,
    @required this.idMotivo,
  }) {
    // if (tipoBatida == TipoBatida.normal) {
    //   this.tipo = "0";
    // } else if (tipoBatida == TipoBatida.offline) {
    //   this.tipo = "1";
    // } else {
    //   tipo = "0";
    // }
  }

  static TipoBatida definirTipoBatidaPorIndex(String indexTipo) {
    if (indexTipo == "0") return TipoBatida.normal;
    if (indexTipo == "1") return TipoBatida.offline;
    return TipoBatida.normal;
  }

  Future definirComoBatidaOffline() async {
    this.tipo = "1";
  }

  //FROM JSON
  factory RegistroBatida.fromJson(Map<String, dynamic> json) {
    var point = "";
    if (json == null) {
      return RegistroBatida(
        distancia: 0,
        dthr: "",
        fuso: "",
        lat: "",
        loccheckpontoId: 0,
        lon: "",
        tipo: "0",
        localBatida: "",
        txtMotivo: "",
        idMotivo: 0,
      );
    }
    return RegistroBatida(
      loccheckpontoId: json['loccheckpontoId'],
      tipo: json['tipo'],
      distancia: json['distancia'],
      dthr: json['dthr'],
      fuso: json['fuso'],
      lat: json['lat'],
      lon: json['lon'],
      localBatida: json['localBatida'],
      txtMotivo: json['txtMotivo'],
      idMotivo: json['idMotivo'],
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    // String strTipo = TipoBatida.normal.toString();
    // if (tipo == "0") strTipo = TipoBatida.normal.toString();
    // if (tipo == "1") strTipo = TipoBatida.offline.toString();

    // var teste = tipo == "0" ? TipoBatida.normal.toString() : TipoBatida.offline.toString();
    // var point = "";

    return {
      'loccheckpontoId': loccheckpontoId,
      // 'tipoBatida': strTipo,
      // 'tipoBatida': tipo,
      'tipo': tipo,
      'distancia': distancia,
      'dthr': dthr,
      'fuso': fuso,
      'lat': lat,
      'lon': lon,
      'localBatida': localBatida,
      'idMotivo': idMotivo,
      'txtMotivo': txtMotivo,
    };
  }
}
