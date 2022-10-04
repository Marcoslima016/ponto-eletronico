import 'dart:convert';

import 'package:flutter/material.dart';

class Local {
  //
  int loccheckpontoId;
  String descr;
  String endereco;
  String lat;
  String lng;
  int distancia;

  Local({
    this.loccheckpontoId,
    this.descr,
    this.endereco,
    this.lat,
    this.lng,
    this.distancia,
  });

  static convertListFromJson(List data) async {
    if (data == null) return [];
    var listPersist = data.map((x) {
      return Local.fromJson(json.decode(x));
    }).toList();
    return listPersist;
  }

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      loccheckpontoId: json['loccheckpontoId'],
      descr: json['descr'],
      endereco: json['endereco'],
      lat: json['lat'],
      lng: json['lng'],
      distancia: json['distancia'],
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'loccheckpontoId': loccheckpontoId,
      'descr': descr,
      'endereco': endereco,
      'lat': lat,
      'lng': lng,
      'distancia': distancia,
    };
  }

  //FROM API
  factory Local.fromAPI(Map<String, dynamic> json) {
    return Local(
      loccheckpontoId: json['loccheckponto_id'],
      descr: json['descr'],
      endereco: json['endereco'],
      lat: json['lat'],
      lng: json['lng'],
      distancia: json['distancia'],
    );
  }

  //----------------------------------- CACHE BLEND -----------------------------------

  //Mesclar com items salvos em cache
  static Future<List> blendListItems({@required List cachedList, @required List baseList}) async {
    return cachedList;
  }
}
