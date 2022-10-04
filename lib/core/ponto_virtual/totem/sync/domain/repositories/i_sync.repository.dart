import 'package:flutter/material.dart';

import '../../../totem.imports.dart';

abstract class ISyncRepository {
  //
  Future carregarBatidas({String data, String pessoasId});

  Future<bool> contabilizarBatida({@required BatidaTotem batida});
}
