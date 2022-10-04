import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class TipoDeBatida extends StatelessWidget {
  int itemIndex;
  TipoDeBatida({
    @required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Batida itemBatida = PontoVirtual.instance.pontoPessoal.batidasDoDia[itemIndex];
        return Text("Tipo da batida: " + itemBatida.tipo.toString());
      },
    );
  }
}
