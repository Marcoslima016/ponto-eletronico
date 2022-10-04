import 'package:flutter/material.dart';

import '../../../ponto_virtual.imports.dart';

abstract class ISyncDatasource {
  Future<Map> carregarBatidas({String data, String pessoasId});
  Future contabilizarBatida({@required BatidaTotem batida});
}
