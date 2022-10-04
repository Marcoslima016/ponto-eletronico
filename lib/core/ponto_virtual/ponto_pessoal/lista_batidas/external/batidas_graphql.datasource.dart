import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core.imports.dart';
import '../../ponto_pessoal.imports.dart';

class BatidasGraphQLDatasource implements IBatidasNetworkDatasource {
  GraphQLCustomCLient client;

  ///
  BatidasGraphQLDatasource({@required this.client});

  @override
  Future<Map> carregarBatidas({String data}) async {
    final QueryOptions options = QueryOptions(
      document: gql(queryGetBatidas),
      variables: <String, dynamic>{
        'nDias': data,
      },
    );
    // QueryResult response = await client.query(1, options);
    QueryResult response = await client.query(1, options).timeout(
      Duration(milliseconds: 9000),
      onTimeout: () {
        var p = "";
        return throw ("Erro na requisição - TIMEOUT");
      },
    );

    if (response.hasException == true) throw ("Erro na requisição");

    Map responseData = response.data;

    return responseData;
  }

  @override
  Future<QueryResult> registrarNovaBatida({@required RegistroBatida dadosBatida, Duration timeout}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;

    Duration finalTimeout;

    if (timeout == null) {
      finalTimeout = Duration(milliseconds: 180000);
    } else {
      finalTimeout = timeout;
    }

    final QueryOptions options = QueryOptions(
      document: gql(mutationApontaRelog),
      variables: <String, dynamic>{
        'dthrBatida': dadosBatida.dthr,
        'tipo': dadosBatida.tipo,
        'lat': dadosBatida.lat,
        'lon': dadosBatida.lon,
        'loccheckponto_id': dadosBatida.loccheckpontoId,
        'distancia': dadosBatida.distancia,
        'loc_falsa': 0,
        // 'motivo': "v:" + version + " - " + code,
        'motivo': dadosBatida.txtMotivo,
        'cd_motivo': dadosBatida.idMotivo,
        'fuso': dadosBatida.fuso,
        'url_foto': "",
      },
    );
    QueryResult response = await client.query(1, options).timeout(
      finalTimeout,
      // Duration(milliseconds: 1000),
      onTimeout: () {
        var p = "";

        print("*********************************************  Erro na requisição - TIMEOUT !!!!!!!!!!!!!!!!!!!!!!!!!!!");

        return throw ("Erro na requisição - TIMEOUT !!!!!!!!!!!!!!!!!!!!!!!!!!!");
      },
    );

    if (response.hasException == true) {
      print("********************************************* Erro na requisição !!!!!!!!!!!!!!!!!!!!!");

      print(response.exception.graphqlErrors.toString());
      //*** LOG ***/
      await LogRegistrarPontoController.instance.writeLogErroReqContabilizar(response.exception.graphqlErrors, response.exception.linkException.originalException.message);
      //***********/
      throw ("Erro na requisição");
    }

    Map responseData = response.data;

    return response;
  }
}
//-------------------------------------------------------------------

const String queryGetBatidas = r'''
  query getBatidasByDate($nDias: String!) {
    getBatidasByDate(dia: $nDias) {
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

//-------------------------------------------------------------------

const String mutationApontaRelog = r'''
  mutation InserePonto ($dthrBatida: String!, 
                        $tipo: String, 
                        $lat: String, 
                        $lon: String, 
                        $loccheckponto_id: Int, 
                        $distancia: Int,
                        $loc_falsa: Int,
                        $cd_motivo: Int,
                        $motivo: String,
                        $fuso: String,
                        $url_foto: String){
    createBatida (dthrBatida: $dthrBatida, 
                  tipo: $tipo, 
                  lat: $lat, 
                  lon: $lon, 
                  loccheckponto_id: $loccheckponto_id, 
                  distancia: $distancia,
                  loc_falsa: $loc_falsa,
                  cd_motivo: $cd_motivo,
                  motivo: $motivo,
                  fuso: $fuso,
                  url_foto: $url_foto){
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
