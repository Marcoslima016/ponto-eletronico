import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain.imports.dart';

abstract class IBatidasTotemRepository {
  RxList<BatidaTotem> listaBatidas;
  Future carregarBatidas();
  Future registrarBatida({@required BatidaTotem dadosBatida});
  Future salvarListaDeBatidas();
}
