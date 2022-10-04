import 'dart:convert';

import 'package:flutter/material.dart';

class LoginCredentials {
  final int grempId;
  final int relogioId;
  final int datetime;
  final String tokenAuth;
  final String codigo;

  LoginCredentials({
    @required this.grempId,
    @required this.relogioId,
    @required this.datetime,
    @required this.tokenAuth,
    @required this.codigo,
  });

  factory LoginCredentials.fromJson(Map<String, dynamic> json) {
    return LoginCredentials(
      grempId: json['grempId'],
      relogioId: json['relogioId'],
      datetime: json['datetime'],
      tokenAuth: json['tokenAuth'],
      codigo: json['codigo'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    var point = "";
    return {
      'grempId': grempId,
      'relogioId': relogioId,
      'datetime': datetime,
      'tokenAuth': tokenAuth,
      'codigo': codigo,
    };
  }
}
