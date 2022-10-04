import 'package:flutter/material.dart';

import '../../entities/entities.imports.dart';
import 'batidas.imports.dart';

abstract class ITentarRegistrarBatidaViaColab {
  IRegistrarBatida usecaseRegistrarBatida;
  Future call({@required Colab colab});
}

class TentarRegistrarBatidaViaColab implements ITentarRegistrarBatidaViaColab {
  IRegistrarBatida usecaseRegistrarBatida;

  TentarRegistrarBatidaViaColab({
    @required this.usecaseRegistrarBatida,
  });

  @override
  Future call({Colab colab}) async {
    await usecaseRegistrarBatida(colab: colab);
  }
  //
}
