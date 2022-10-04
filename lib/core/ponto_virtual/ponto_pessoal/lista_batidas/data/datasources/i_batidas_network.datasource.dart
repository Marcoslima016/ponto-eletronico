import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../ponto_pessoal.imports.dart';

abstract class IBatidasNetworkDatasource {
  Future<Map> carregarBatidas({@required String data});
  Future<QueryResult> registrarNovaBatida({@required RegistroBatida dadosBatida, Duration timeout});
}
