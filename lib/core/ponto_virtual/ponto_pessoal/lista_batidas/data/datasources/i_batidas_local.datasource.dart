import 'package:flutter/material.dart';

import '../../../ponto_pessoal.imports.dart';

abstract class IBatidasLocalDatasource {
  //

  Future setCachePreferences({@required Function jsonToDartMethod});

  Future saveInCache({@required List<Batida> batidas});

  Future<List<Batida>> restoreCache();

  Future clearCache();
}
