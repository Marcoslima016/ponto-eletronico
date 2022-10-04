import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../locais.imports.dart';
import '../../../../core.imports.dart';

// import 'package:graphql/client.dart';

class GraphQLDatasource implements IEnderecosNetworkDataSource {
  GraphQLCustomCLient client;

  ///
  GraphQLDatasource({@required this.client});

  static const String queryLocais = r'''
  query {
    getLocaisChecking{
      loccheckponto_id
      descr
      endereco
      lat
      lng
      distancia
    }
  }
  ''';

  @override
  Future<Map> getEnderecos() async {
    final QueryOptions options = QueryOptions(
      document: gql(queryLocais),
    );
    QueryResult response = await client.query(1, options).timeout(
      Duration(milliseconds: 15000),
      onTimeout: () {
        var p = "";

        return throw ("Erro na requisição");
      },
    );

    if (response.hasException == true) throw ("Erro na requisição");

    Map data = response.data;

    return data;
  }
  //
}
