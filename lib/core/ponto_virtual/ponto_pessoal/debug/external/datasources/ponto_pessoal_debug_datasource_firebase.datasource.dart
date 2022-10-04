import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../debug.imports.dart';

class PontoPessoalDebugDatasourceFirebase implements IPontoPessoalDebugDatasource {
  //

  DatabaseReference db = FirebaseDatabase.instance.reference().child("DEBUG/" + "DEBUG_PONTO_PESSOAL/");

  // DadosProcesso dadosProcesso;

  @override
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

  //------------------------------- INICIO BATIDA -------------------------------

  @override
  Future setInicioProcessoDeBatida({@required DadosProcesso dadosProcesso}) async {
    dadosProcesso = dadosProcesso;
    Map dataJson = dadosProcesso.toMap();
    dataJson["trabValidado"] = "0";

    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").update(dataJson);
  }

  //---------------------------------- FIM BATIDA ----------------------------------

  @override
  Future setFimProcessoDeBatida({@required DadosProcesso dadosProcesso}) async {
    throw ("IMPLEMENTAR!!!");
    // dadosProcesso = dadosProcesso;
    // Map dataJson = dadosProcesso.toMap();
    // dataJson["trabValidado"] = "0";

    // String emailUsuario = dadosProcesso.emailUsuario;
    // String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    // db.child(refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").update(dataJson);
  }

  //---------------------------- TRABALHADOR VALIDADO ----------------------------

  Future setTrabalhadorValidado({@required DadosProcesso dadosProcesso}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "trabValidado": "1",
    };

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").update(dataJson);
  }

  //-------------------------- SETAR COMO BATIDA OFFLINE --------------------------

  Future setOffline({@required DadosProcesso dadosProcesso}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "offline": "true",
    };

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").update(dataJson);
  }

  //------------------------------ LISTA DE BATIDAS  ------------------------------

  //LISTA DO INICIO DO PROCESSO
  Future setListaDeBatidasNoInicioDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    db
        .child(
          "data/" + refEmail + "/",
        )
        .child(
          "-" + dadosProcesso.idProcesso.toString() + "/",
        )
        .child(
          "lista_batidas_interna/",
        )
        .child("inicio_processo_batida/")
        .update(listaDeBatidas);
  }

  //LISTA DO FIM DO PROCESSO
  Future setListaDeBatidasNoFimDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    db
        .child(
          "data/" + refEmail + "/",
        )
        .child(
          "-" + dadosProcesso.idProcesso.toString() + "/",
        )
        .child(
          "lista_batidas_interna/",
        )
        .child("fim_processo_batida/")
        .update(listaDeBatidas);
  }

  //-------------------------------- CONTABILIZAR --------------------------------

  //----------- INICIADO PROCESSO -----------

  Future setIniciadoContabilizar({@required DadosProcesso dadosProcesso, @required DadosContabilizar dadosContabilizar}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = dadosContabilizar.toMap();

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").child("processo_contabilizar/").update(dataJson);
  }

  //----------- CONCLUIDO PROCESSO -----------

  Future setConcluidoContabilizar({@required DadosProcesso dadosProcesso, @required ContabilizarConcluido dadosConclusaoContabilizar}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "timestampFinish": dadosConclusaoContabilizar.timestampFinish,
    };

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").child("processo_contabilizar/").update(dataJson);
  }

  //---- STATUS BATIDA JA EXISTENTE NO HR ----

  @override
  Future setStatusBatidaJaExistente({@required DadosProcesso dadosProcesso, @required bool status}) async {
    String emailUsuario = dadosProcesso.emailUsuario;
    String refEmail = emailUsuario.replaceAll("@", "").replaceAll(".", "");

    Map<String, dynamic> dataJson = {
      "batidaJaExistenteNoHorario": status.toString(),
    };

    db.child("data/" + refEmail + "/").child("-" + dadosProcesso.idProcesso.toString() + "/").child("processo_contabilizar/").update(dataJson);
  }

  //------------------------------------------------------------------------------------

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
}

class FirebaseSourceRef {}

class FirebaseConfig {}
