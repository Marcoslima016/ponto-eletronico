import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as package;

import '../../../lib.imports.dart';

class GraphQLCustomCLient {
  //

  String _tokenStorageKey = "token";

  GraphQLCustomCLient({
    String tokenStorageKey,
  }) {
    if (tokenStorageKey != null) _tokenStorageKey = tokenStorageKey;
  }

  Future<package.QueryResult> query(int type, QueryOptions options, {String url}) async {
    //
    final storage = new FlutterSecureStorage();

    String finalUrl = "";

    if (url == null) {
      // finalUrl = 'https://api.vertech-it.com.br/ptem/gql';
      finalUrl = AppController.instance.config.graphqlUrl;
    } else {
      finalUrl = url;
    }

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> URL REQUISICAO: " + finalUrl);

    final package.HttpLink _httpLink = package.HttpLink(finalUrl);

    final package.AuthLink _authLink = package.AuthLink(
      getToken: () async {
        var token = await storage.read(key: _tokenStorageKey);
        var p = "";
        return type == 1 ? 'Bearer $token' : 'Bearer CREATE_USER'; //// Se for requisicao autenticada, define o token
      },
    );
    final package.Link _link = _authLink.concat(_httpLink);

    final package.GraphQLClient _client = package.GraphQLClient(
      cache: package.GraphQLCache(),
      link: _link,
    );

    return await _client.query(options);
  }
}
