import 'dart:convert';

import 'package:flutter/material.dart';

class LogCycle {
  int ts;
  int id;
  String userPath;
  String cyclePath;
  Map<String, dynamic> dataJson;
  List<Map<String, dynamic>> logs = [];
  LogCycle({
    @required this.ts,
    @required this.userPath,
    @required this.cyclePath,
    @required this.dataJson,
    this.logs,
  }) {
    id = ts;
    if (logs == null) logs = [];
  }

  //----------------------------------- CONVERSORES -----------------------------------

  static convertListFromJson(List data) async {
    if (data == null) return [];
    var listPersist = data.map((x) {
      return LogCycle.fromJson(json.decode(x));
    }).toList();
    return listPersist;
  }

  //FROM JSON
  factory LogCycle.fromJson(Map<String, dynamic> json) {
    var decodedList = jsonDecode(json['logs']);

    List<Map<String, dynamic>> typedList = [];

    decodedList.forEach((e) {
      typedList.add(e);
    });

    var p = "";

    return LogCycle(
      ts: json['ts'],
      userPath: json['userPath'],
      cyclePath: json['cyclePath'],
      dataJson: json['dataJson'],
      logs: typedList,
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    var t1 = jsonEncode(logs);
    var point = "";
    return {
      'ts': ts,
      'userPath': userPath,
      'cyclePath': cyclePath,
      'dataJson': dataJson,
      'logs': jsonEncode(logs),
    };
  }
}
