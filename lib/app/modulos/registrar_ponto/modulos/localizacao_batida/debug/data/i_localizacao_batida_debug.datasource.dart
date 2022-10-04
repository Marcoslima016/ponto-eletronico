import 'package:flutter/material.dart';

import '../../../../../../../lib.imports.dart';

abstract class ILocalizacaoBatidaDebugDatasource {
  Future setInicioProcesso({@required int timestamp, @required String emailUsuario});
  Future setEnderecoLog({@required Local local, @required String distancia, @required String emailUsuario});
  Future setErrorLog({@required String descrErro, @required String emailUsuario});
  Future<bool> getDebugStatus();
}
