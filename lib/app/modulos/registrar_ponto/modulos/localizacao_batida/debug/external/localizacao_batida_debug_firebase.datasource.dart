import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../../../lib.imports.dart';
import '../debug.imports.dart';

class LocalizacaoBatidaDebugFirebaseDatasource implements ILocalizacaoBatidaDebugDatasource {
  //
  ///DATABASE REFERENCE
  DatabaseReference db = FirebaseDatabase.instance.reference().child("DEBUG/" + "DEBUG_LOCALIZACAO_BATIDA/");

  String debugDBRef = "";

  Future<bool> getDebugStatus() async {
    if (await _isOnline() == false) return false;

    DataSnapshot response;
    try {
      response = await db.child("active/").get();
    } catch (e) {
      return false;
    }

    return response.value;
  }

  @override
  Future setInicioProcesso({@required int timestamp, @required String emailUsuario}) async {
    debugDBRef = "-" + timestamp.toString() + "/";
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");
    Map<String, dynamic> dataJson = {
      "timeStamp": timestamp,
    };
    db.child("data/" + refEmail + "/").child(debugDBRef).update(dataJson);
  }

  ///Log que armazena os enderecos recuperados
  /// - Salva os enderecos apos a comparacao de distancia, para poder salvar o valor da distancia
  /// - Se algum endereco for aprovado, irá parar o loop, então so serao salvos os enderecos contabilizados ate o item em questao
  @override
  Future setEnderecoLog({@required Local local, @required String distancia, @required String emailUsuario}) async {
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "logName": "endereco",
      "local": local.endereco,
      "loccheckpontoId": local.loccheckpontoId,
      "distancia": distancia,
    };

    db.child("data/" + refEmail + "/").child(debugDBRef).child("logs/").push().update(dataJson);
  }

  //Log de erros ocorridos (Permissao recusada, GPS Desligado)
  Future setErrorLog({@required String descrErro, @required String emailUsuario}) async {
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "logName": "erros",
      "descErro": descrErro,
    };

    db.child("data/" + refEmail + "/").child(debugDBRef).child("logs/").push().update(dataJson);
  }

  //============================================== VERIFICAR CONEXAO =================================================

  //VERIFICAR SE ESTA ONLINE (Futuramente abstrair via camada external/driver)
  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  //
}
