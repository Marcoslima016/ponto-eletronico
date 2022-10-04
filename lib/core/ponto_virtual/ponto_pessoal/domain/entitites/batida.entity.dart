import 'dart:convert';
import 'package:enum_from_json/enum_from_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ponto_virtual.imports.dart';

enum TipoBatida {
  normal,
  offline,
}

enum SyncStatus {
  inQueue,
  runningSync,
  syncFail,
  syncComplete,
}

class Batida {
  //
  ///[=================== VARIAVEIS ===================]

  int id;

  ///Tipo da batida (normal ou offline)
  TipoBatida tipo;

  ///Status da sincronizacao (na fila, realizando sincronizacao, falha na sincronizacao e sincronizacao concluida)
  // SyncStatus syncStatus;
  Rx<SyncStatus> syncStatus;

  ///Nome do local onde foi realizada a batida
  String localBatida;

  String hr;
  String data;

  int loccheckpontoId;

  // String txtLocal;

  RegistroBatida dadosRegistro;

  /// Variavel que armanza se essa batida ja expirou, ou seja, se ja passou a data que a batida foi realizada.
  /// Essa variavel é utilizada para manter batidas offline na lista mesmo depois de ter mudado o dia.
  /// Mais especificamente, essa variavel é utilizada pra verificar se o item deve ser listado nas batidas do dia.
  /// Se for false, o item continua na lista mas apenas em caráter de sincronização e não como item a ser exibido.
  bool dateExpired;

  String txtMotivo;
  int idMotivo;

  ///[=================== CONSTRUTOR ===================]

  Batida({
    @required this.id,
    @required this.syncStatus,
    @required this.tipo,
    @required this.hr,
    @required this.data,
    @required this.loccheckpontoId,
    // @required this.txtLocal,
    @required this.localBatida,
    @required this.dadosRegistro,
    @required this.dateExpired,
    @required this.txtMotivo,
    @required this.idMotivo,
  });

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //------------------------------ DETERMINAR TXT LOCAL ------------------------------

  static String determinarLocalPorID({@required int idLocal, List<Local> locais}) {
    if (idLocal == null) return "Local não cadastrado";
    if (locais.length == null) return "Local não cadastrado";
    for (Local local in locais) {
      if (local.loccheckpontoId == idLocal) return local.descr;
    }
    throw ("Não foi possivel identificar o local");
  }

  //------------------------ DETERMINAR TIPO DE BATIDA / INDEX ------------------------

  static TipoBatida determinarTipoDaBatida(String index) {
    if (index == "0") return TipoBatida.normal;
    if (index == "1") return TipoBatida.offline;
    throw ("ERRO AO RECUPERAR O TIPO DE BATIDA: Valor passado no index corresponde a nenhum tipo.");
  }

  static String determinarIndexComBaseNoTipoDaBatida(TipoBatida tipoBatida) {
    if (tipoBatida == TipoBatida.offline) return "1";
    if (tipoBatida == TipoBatida.normal) return "0";
    throw ("ERRO AO RECUPERAR INDEX DO TIPO DE BATIDA");
  }

  //----------------------- RESGATAR INFORMACOES DE DATA E HORA -----------------------

  //Recebe string contendo data e horario, faz split e retorna data
  static String determinarData(String dthr) {
    return dthr.split(" ")[0];
  }

  //Recebe string contendo data e horario, faz split e retorna o horario
  static String determinarHorario(String dthr) {
    return dthr.split(" ")[1];
  }

  //----------------------------------- CONVERSORES -----------------------------------

  static convertListFromJson(List data) async {
    if (data == null) return [];
    var listPersist = data.map((x) {
      return Batida.fromJson(json.decode(x));
    }).toList();
    return listPersist;
  }

  //FROM JSON
  factory Batida.fromJson(Map<String, dynamic> json) {
    return Batida(
      id: json['id'],
      syncStatus: Rx<SyncStatus>(EnumFromJson.convert(itemType: SyncStatus.values, value: json['syncStatus'])),
      tipo: EnumFromJson.convert(itemType: TipoBatida.values, value: json['tipo']),
      hr: json['hr'],
      data: json['data'],
      loccheckpontoId: json['loccheckpontoId'],
      // txtLocal: json['txtLocal'],
      localBatida: json['localBatida'],
      dadosRegistro: RegistroBatida.fromJson(json['dadosRegistro']),
      dateExpired: json['dateExpired'],
      idMotivo: json['idMotivo'],
      txtMotivo: json['txtMotivo'],
    );
  }

  //TO JSON
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    var point = "";
    return {
      'id': id,
      'syncStatus': syncStatus.toString(),
      'tipo': tipo.toString(),
      'hr': hr,
      'data': data,
      'loccheckpontoId': loccheckpontoId,
      // 'txtLocal': txtLocal,
      'localBatida': localBatida,
      'dadosRegistro': dadosRegistro?.toMap(),
      'dateExpired': dateExpired,
      'idMotivo': idMotivo,
      'txtMotivo': txtMotivo,
    };
  }

  //FROM API
  factory Batida.fromAPI(Map<String, dynamic> json, List<Local> locais) {
    return Batida(
      id: json["apontrelog_id"],
      syncStatus: SyncStatus.syncComplete.obs,
      tipo: determinarTipoDaBatida(json["tipo"]),
      hr: Batida.determinarHorario(json["dt_hr_batida"]),
      data: Batida.determinarData(json["dt_hr_batida"]),
      loccheckpontoId: json["loccheckponto_id"],
      localBatida: determinarLocalPorID(idLocal: json["loccheckponto_id"], locais: locais),
      dateExpired: false,
      dadosRegistro: null,
      txtMotivo: null,
      idMotivo: null,
    );
  }

  //----------------------------------- CACHE RESET -----------------------------------

  static Future<List> resetCache({@required List cachedList}) async {
    for (Batida batidaCache in cachedList) {
      if (batidaCache.tipo == TipoBatida.offline && batidaCache.syncStatus.value != SyncStatus.syncComplete) {
        batidaCache.dateExpired = true;
      }
    }
    cachedList.removeWhere((item) => item.syncStatus.value == SyncStatus.syncComplete);
    // cachedList.removeWhere((item) => item.syncStatus.value == SyncStatus.syncComplete && item.tipo == TipoBatida.offline);

    return cachedList;
  }

  //----------------------------------- CACHE BLEND -----------------------------------

  //Mesclar com items salvos em cache
  static Future<List> blendListItems({@required List cachedList, @required List baseList}) async {
    print("Batida Entity - blendListItems() - cachedList length: " + cachedList.length.toString());
    print("Batida Entity - blendListItems() - baseList length: " + baseList.length.toString());
    //
    ///Sincronizar atributos de cada item (decidir se é necessario nesse app)
    for (Batida batidaBase in baseList) {
      for (Batida batidaCache in cachedList) {
        if (batidaCache.id == batidaBase.id) {
          batidaBase.dateExpired = batidaCache.dateExpired; //// Manter dateExpired que foi persistida em cache (Nào substitui pelo valor do servidor)
          // batidaBase.syncStatus = batidaCache.syncStatus;
          batidaBase.dadosRegistro = batidaCache.dadosRegistro;
          batidaBase.tipo = batidaCache.tipo;
        }
      }
    }

    //Sincronizar items existentes apenas em cache
    List<int> cachedItemsMustBeAddToReturnList = [];
    int i = 0;
    for (Batida batidaCache in cachedList) {
      bool itemMatch = false;
      for (Batida batidaBase in baseList) {
        if (batidaBase.id == batidaCache.id) itemMatch = true;
      }
      print("Batida Entity - blendListItems() - ITEM MATCH: " + itemMatch.toString());
      if (itemMatch == false) {
        // cachedItemsMustBeAddToReturnList.add(i);
        baseList.add(batidaCache);
      }
      i++;
    }

    /************* REMOVER DUPLICADAS *************/
    // baseList.forEach((batidaItem) {
    //   Batida batida = batidaItem;
    //   baseList.removeWhere((item) => item.hr == batida.hr && item.data == batida.data && item.id != batida.id);
    // });
    //*********************************************/

    List returnList = [];
    for (Batida batida in baseList) returnList.add(batida);

    var point = "";

    //ordenar pr horario
    returnList.sort((a, b) {
      var adate = DateTime.parse("2022-01-01 " + a.hr + ":00");
      var bdate = DateTime.parse("2022-01-01 " + b.hr + ":00");
      return adate.compareTo(bdate);
    });

    print("Batida Entity - blendListItems() - returnList length: " + returnList.length.toString());

    return returnList;
  }
}
