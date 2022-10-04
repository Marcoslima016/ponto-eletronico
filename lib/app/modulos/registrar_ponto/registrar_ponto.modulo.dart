import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modulos.imports.dart';

class RegistrarPonto {
  //

  /// Metodo disparado para redicionar ao modulo.
  /// É disparado através de outros modulos, quando há necessidade de redirecionar para esse modulo.
  Future redirectToModule() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Wrap(
          children: <Widget>[
            RegistrarPontoView(),
          ],
        );
      },
    );
  }
}
