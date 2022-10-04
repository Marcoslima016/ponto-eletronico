import 'package:flutter_recognize/src/src.imports.dart';
import 'dart:convert';

class UserRecognizePonto implements UserRecognize {
  @override
  int id;

  @override
  List prediction;

  @override
  int timestampLastDetection;
  //

  UserRecognizePonto({
    this.id,
    this.prediction,
    this.timestampLastDetection,
  });

  static UserRecognizePonto fromMap(Map<String, dynamic> user) {
    return UserRecognizePonto(
      id: user['id'],
      prediction: user['prediction'],
      timestampLastDetection: user['timestampLastDetection'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    var point = "";
    return {
      'id': id,
      'prediction': prediction,
      'timestampLastDetection': timestampLastDetection,
    };
  }
}
