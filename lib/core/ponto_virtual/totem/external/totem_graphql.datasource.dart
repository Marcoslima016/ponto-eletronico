import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';
import 'package:ptem2/core/core.imports.dart';
import 'package:ptem2/core/external/clients/rest_client.dart';

import '../../../../lib.imports.dart';
import '../totem.imports.dart';

//=============================================================== DATASOURCE ==================================================================
//=============================================================================================================================================

class TotemGraphQLDatasource extends ITotemDatasource {
  // RestClient client = RestClient();

  GraphQLCustomCLient client = GraphQLCustomCLient(tokenStorageKey: 'token_totem2.0');

  // String _apiUrl = 'https://api.vertech-it.com.br/ptem/gqltotem';
  String _apiUrl = AppController.instance.config.graphqlUrlTotem;

  @override
  Future<List> getAllColab() async {
    List responseData;
    try {
      final QueryOptions options = QueryOptions(
        document: gql(queryAllUsers),
      );

      QueryResult response = await client.query(1, options, url: _apiUrl).timeout(
        Duration(milliseconds: 30000),
        onTimeout: () {
          return throw ("Erro na requisição");
        },
      );

      responseData = response.data["getAllUsers"];

      var p = "";
    } catch (e) {
      throw (e);
    }

    var p = "";

    return responseData;
  }

  //
}

//================================================================= QUERY`s ===================================================================
//=============================================================================================================================================
// const String queryAllUsers = r'''
//   query {
//     getAllUsers {
//       grempId,
//       trabalhadorId,
//       nome,
//       corrId,
//       matricula,
//       pessoaId,
//       login,
//       pin,
//       pinLength,
//       dtdemis,
//       emprusuId
//     }
//   }
// ''';
