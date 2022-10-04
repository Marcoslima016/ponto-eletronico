import 'package:flutter/material.dart';

import '../totem.imports.dart';

abstract class IBatidasTotemDatasource {
  Future<List<BatidaTotem>> recuperarListaSalvaEmCache();
  Future salvarEmCache({@required List<BatidaTotem> listaBatidas});
}
