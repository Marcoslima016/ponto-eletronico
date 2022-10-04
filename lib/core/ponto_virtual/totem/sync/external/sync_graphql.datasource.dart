import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ptem2/core/ponto_virtual/ponto_pessoal/domain/entitites/batida.entity.dart';

import '../../../../../lib.imports.dart';
import '../../../../core.imports.dart';
import '../sync.imports.dart';

class SyncGraphQLDatasource implements ISyncDatasource {
  // GraphQLCustomCLient client;

  GraphQLCustomCLient client = GraphQLCustomCLient(tokenStorageKey: 'token_totem2.0');

  // String _apiUrl = 'https://api.vertech-it.com.br/ptem/gqltotem';
  String _apiUrl = AppController.instance.config.graphqlUrlTotem;

  ///
  // SyncGraphQLDatasource({@required this.client});

  @override
  Future<Map> carregarBatidas({String data, String pessoasId}) async {
    final QueryOptions options = QueryOptions(
      document: gql(queryGetBatidasByColab),
      variables: <String, dynamic>{
        'nDias': data,
        'nPessoasId': pessoasId,
      },
    );
    QueryResult response = await client.query(1, options, url: _apiUrl).timeout(
      // Duration(milliseconds: 12000),
      Duration(milliseconds: 25000),
      onTimeout: () {
        var p = "";
        return throw ("Erro na requisição - Timeout");
      },
    );

    var p = "";

    if (response.hasException == true) {
      print("##########################################################################################");
      throw ("Erro na requisição");
    }

    Map responseData = response.data;

    return responseData;
  }

  @override
  Future contabilizarBatida({BatidaTotem batida}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;

    var mapTeste = {
      'usuario': batida.usuario,
      'pessoasId': batida.pessoasId,
      'dthrBatida': batida.dthrBatida,
      'tipo': batida.tipo,
      'lat': null,
      'lon': null,
      'loccheckponto_id': null,
      'distancia': 0,
      'loc_falsa': 0,
      // 'motivo': "v:" + version + " - " + code,
      'motivo': null,
      'cd_motivo': null,
      'fuso': "-03",
      'url_foto': "",
    };

    var p = "";

    final QueryOptions options = QueryOptions(
      document: gql(mutationCreateBatidaByTotem),
      variables: <String, dynamic>{
        'usuario': batida.usuario,
        'pessoasId': batida.pessoasId,
        'dthrBatida': batida.dthrBatida,
        'tipo': batida.tipo,
        'lat': null,
        'lon': null,
        'loccheckponto_id': null,
        'distancia': 0,
        'loc_falsa': 0,
        // 'motivo': "v:" + version + " - " + code,
        'motivo': null,
        'cd_motivo': null,
        'fuso': "-03",
        'url_foto': "",
      },
    );
    QueryResult response = await client.query(1, options, url: _apiUrl).timeout(
      Duration(milliseconds: 15000),
      onTimeout: () {
        var p = "";

        return throw ("Erro na requisição");
      },
    );

    if (response.hasException) {
      print(">>>>>>>>>>>> SYNC - ERRO NA REQUISICAO !!!!!");
      throw ("ERRO DE REQUISICAO!!");
    }

    Map responseData = response.data;

    return response;
  }
  //
}

const String queryGetBatidasByColab = r'''
  query getBatidasByColab($nDias: String!, $nPessoasId: String! ) {
    getBatidasByColab(dia: $nDias, pessoasId: $nPessoasId ) {
      apontrelog_id,
      usuario,
      maquina
      dt_hr_import,
      dt_hr_batida,
      pessoas_id,
      relogio_id,
      ofic,
      nsr,
      loteponto_id,
      regvis_id,
      gremp_id
      tipo
      lat
      lon
      loccheckponto_id
      distancia
      loc_falsa
      cd_motivo
      motivo
      locname,
      fuso,
      url_foto
    }
  }
  ''';

const String mutationCreateBatidaByTotem = r'''
  mutation InserePontoByTotem ($usuario: String!,
                               $pessoasId: String!,
                               $dthrBatida: String!, 
                               $tipo: String, 
                               $lat: String, 
                               $lon: String, 
                               $loccheckponto_id: Int, 
                               $distancia: Int,
                               $loc_falsa: Int,
                               $cd_motivo: Int,
                               $motivo: String,
                               $fuso: String,
                               $url_foto: String) {
    createBatidaByTotem (usuario: $usuario,
                         pessoasId: $pessoasId
                         dthrBatida: $dthrBatida, 
                         tipo: $tipo, 
                         lat: $lat, 
                         lon: $lon, 
                         loccheckponto_id: $loccheckponto_id, 
                         distancia: $distancia,
                         loc_falsa: $loc_falsa,
                         cd_motivo: $cd_motivo,
                         motivo: $motivo,
                         fuso: $fuso,
                         url_foto: $url_foto) {
      apontrelog_id
      usuario
      maquina
      dt_hr_import
      dt_hr_batida
      pessoas_id
      relogio_id
      ofic
      nsr
      sit
      loteponto_id
      regvis_id
      gremp_id
      tipo
      lat
      lon
      loccheckponto_id
      distancia
      loc_falsa
      cd_motivo
      motivo,
      fuso,
      url_foto
    }
  }
''';
