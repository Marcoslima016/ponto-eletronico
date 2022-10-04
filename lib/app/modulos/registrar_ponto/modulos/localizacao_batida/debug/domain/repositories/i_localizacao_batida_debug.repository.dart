import 'package:flutter/material.dart';

import '../../../../../../../../lib.imports.dart';

abstract class ILocalizacaoBatidaDebugRepository {
  //
  Future<bool> getDebugStatus();
  Future setInicioProcesso({@required int timestamp, @required String emailUsuario});
  Future setEnderecoLog({@required Local local, @required String distancia});
  Future setErrorLog({@required String descrErro});
}
