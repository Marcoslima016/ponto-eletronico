import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:enum_from_json/enum_from_json.dart';
import 'package:flutter_recognize/src/src.imports.dart';

class Colab implements UserRecognize {
  //

  final int grempId;

  final int trabalhadorId;

  final String nome;

  final int corrId;

  final int matricula;

  final int pessoaId;

  final String login;

  final String pin;

  final int pinLength;

  @override
  int id;

  @override
  List prediction;

  @override
  int timestampLastDetection;

  bool batePonto;

  Colab({
    @required this.grempId,
    @required this.trabalhadorId,
    @required this.nome,
    @required this.corrId,
    @required this.matricula,
    @required this.pessoaId,
    @required this.login,
    @required this.pin,
    @required this.pinLength,
    this.prediction = const [],
    this.timestampLastDetection = 0,
    @required this.batePonto,
  }) {
    this.id = trabalhadorId;
  }

  //----------------------------------- CACHE BLEND -----------------------------------

  //Mesclar com items salvos em cache
  static Future<List> blendListItems({@required List cachedList, @required List baseList}) async {
    print("Batida Entity - blendListItems() - cachedList length: " + cachedList.length.toString());
    print("Batida Entity - blendListItems() - baseList length: " + baseList.length.toString());
    //
    ///Sincronizar atributos de cada item (decidir se é necessario nesse app)
    for (Colab colabBase in baseList) {
      for (Colab colabCache in cachedList) {
        if (colabCache.id == colabBase.id) {
          colabBase.prediction = colabCache.prediction; //// Manter dateExpired que foi persistida em cache (Nào substitui pelo valor do servidor)
          colabBase.timestampLastDetection = colabCache.timestampLastDetection;
        }
      }
    }

    List returnList = [];
    for (Colab colab in baseList) returnList.add(colab);

    return returnList;
  }

  //----------------------------------- CONVERSORES -----------------------------------

  static convertListFromJson(List data) async {
    if (data == null) return [];
    var listPersist = data.map((x) {
      return Colab.fromJson(json.decode(x));
    }).toList();
    return listPersist;
  }

  //FROM JSON
  factory Colab.fromJson(Map<String, dynamic> json) {
    return Colab(
      grempId: json['grempId'],
      trabalhadorId: json['trabalhadorId'],
      nome: json['nome'],
      corrId: json['corrId'],
      matricula: json['matricula'],
      pessoaId: json['pessoaId'],
      login: json['login'],
      pin: json['pin'],
      pinLength: json['pinLength'],
      prediction: json['prediction'].cast(),
      timestampLastDetection: json['timestampLastDetection'],
      batePonto: json['batePonto'],
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'grempId': grempId,
      'trabalhadorId': trabalhadorId,
      'nome': nome,
      'corrId': corrId,
      'matricula': matricula,
      'pessoaId': pessoaId,
      'login': login,
      'pin': pin,
      'pinLength': pinLength,
      'prediction': prediction,
      'timestampLastDetection': timestampLastDetection,
      'batePonto': batePonto,
    };
  }

  factory Colab.fromAPI(Map<String, dynamic> json) {
    bool batePonto = true;

    if (json['batePonto'] == 1 && json['batePontoTotem'] == 1) {
      batePonto = true;
    } else {
      batePonto = false;
    }

    return Colab(
      grempId: json["grempId"],
      trabalhadorId: json["trabalhadorId"],
      nome: json["nome"],
      corrId: json["corrId"],
      matricula: json["matricula"],
      pessoaId: json["pessoaId"],
      login: json["login"],
      pin: json["pin"],
      pinLength: json["pinLength"],
      batePonto: batePonto,
    );
  }
}
