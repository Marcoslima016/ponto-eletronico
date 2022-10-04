import 'package:flutter/material.dart';

class QrColabData {
  final int grempId;
  final int trabalhadorId;
  final String nome;
  final String login;
  final int corrId;
  final String matricula;
  final int pessoasId;
  final int datetime;

  QrColabData({
    @required this.grempId,
    @required this.trabalhadorId,
    @required this.nome,
    @required this.login,
    @required this.corrId,
    @required this.matricula,
    @required this.pessoasId,
    @required this.datetime,
  });

  static QrColabData fromJson(Map<String, dynamic> json) {
    return QrColabData(
      grempId: json['grempId'] as int,
      trabalhadorId: json['trabalhadorId'] as int,
      nome: json['nome'] as String,
      login: json['login'] as String,
      corrId: json['corrId'] as int,
      matricula: json['matricula'] as String,
      pessoasId: json['pessoasId'] as int,
      datetime: json['datetime'] as int,
    );
  }
}
