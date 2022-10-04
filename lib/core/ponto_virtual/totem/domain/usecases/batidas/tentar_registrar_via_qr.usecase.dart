import 'package:flutter/material.dart';
import 'package:ptem2/core/core.imports.dart';

import '../../domain.imports.dart';

abstract class ITentarRegistrarBatidaViaQr {
  Future call({@required String scanResult});
}

class TentarRegistrarBatidaViaQr implements ITentarRegistrarBatidaViaQr {
  IProcessQrColab usecaseProcessQrColab;
  ITotemCore totemCore;
  IRegistrarBatida usecaseRegistrarBatida;

  TentarRegistrarBatidaViaQr({
    @required this.usecaseProcessQrColab,
    @required this.totemCore,
    @required this.usecaseRegistrarBatida,
  });

  @override
  Future call({String scanResult}) async {
    QrColabData qrColabData = await usecaseProcessQrColab(scanResult);
    Colab colab = await _findColabBasedOnQrResult(qrColabData);
    if (colab != null) await registrarBatida(colab: colab);
  }

  ///Metodo que encontra um colab com base nos dados retornados via QR Code
  Future<Colab> _findColabBasedOnQrResult(QrColabData qrColabData) async {
    for (Colab colab in TotemController.instance.colabListManager.colabList) {
      if (colab.corrId == qrColabData.corrId) {
        return colab;
      }
    }
    return null;
  }

  Future registrarBatida({@required Colab colab}) async {
    await usecaseRegistrarBatida(colab: colab);
  }
  //
}
