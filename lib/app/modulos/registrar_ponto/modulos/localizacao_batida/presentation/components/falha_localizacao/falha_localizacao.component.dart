import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/modulos/registrar_ponto/modulos/localizacao_batida/presentation/localizacao_batida.controller.dart';

import '../../../localizacao_batida.imports.dart';

class FalhaLocalizacao extends StatelessWidget {
  LocalizacaoBatidaController controller = Get.find<LocalizacaoBatidaController>();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    String textFalha = "";

    LocalNaoDefinido datalhesLocalBatida = controller.localDaBatida;

    if (datalhesLocalBatida.falhaNaLocalizacao?.falhasOcorridas[0] == TipoFalhaLocalizacao.permissao) {
      textFalha = "Você deve aceitar as permissões de localização.";
    }

    // if (datalhesLocalBatida.falhaNaLocalizacao?.falhasOcorridas[0] == TipoFalhaLocalizacao.indisponivel ||
    //     datalhesLocalBatida.falhaNaLocalizacao?.falhasOcorridas[1] == TipoFalhaLocalizacao.indisponivel) {
    //   textFalha = "Serviço de localização indisponível";
    // }

    for (TipoFalhaLocalizacao tipoFalha in datalhesLocalBatida.falhaNaLocalizacao.falhasOcorridas) {
      if (tipoFalha == TipoFalhaLocalizacao.indisponivel) textFalha = "Serviço de localização indisponível";
    }

    return AreaMapa(
      bgColor: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: w * 13,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 1.2),
              child: Text(
                "Falha ao obter localização",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: h * 2.7,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Open Sans",
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 1.5),
              child: Text(
                textFalha,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: h * 2.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Open Sans",
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: h * 11),
          ],
        ),
      ),
    );
  }
}
