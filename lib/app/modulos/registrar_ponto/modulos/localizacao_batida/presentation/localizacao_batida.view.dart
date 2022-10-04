import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localizacao_batida.imports.dart';
import 'presentation.imports.dart';

import '../../../registrar_ponto.imports.dart';

class LocalizacaoBatidaView extends StatelessWidget {
  // RegistrarPontoController registrarPontoController;
  // // LocalizacaoBatidaView({
  // //   @required this.registrarPontoController,
  // // });

  LocalizacaoBatidaController controller;

  LocalizacaoBatidaView() {
    LocalizacaoBatidaBinding().dependencies();
    controller = Get.find<LocalizacaoBatidaController>();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    return LocalizacaoBatidaViewBody(
      controller: this.controller,
    );
  }
}

class LocalizacaoBatidaViewBody extends GetView<LocalizacaoBatidaController> {
  LocalizacaoBatidaController controller;

  LocalizacaoBatidaViewBody({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;
    return FutureBuilder(
      future: controller.loadView(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // LocalNaoDefinido localNaoDefinido = controller.localDaBatida;
          // var teste = localNaoDefinido.parametroTeste;
          // var point = "";

          return Container(
            child: Stack(
              children: [
                //
                //================================================ MAPA =================================================

                MapaLocalBatida(
                  falhaAoObterLocalizacao: controller.falhaNaLocalizacao.value,
                ),

                //=========================================== LOCAL DA BATIDA ============================================

                Positioned(
                  bottom: h * 2.8,
                  child: LocalDaBatida(
                    controller.localDaBatida,
                    controller.batidaFeitaEmLocalPermitido.value,
                  ),
                ),
              ],
            ),
          );
        } else {
          //Widget utilizado para definir o tamanho geral de widgets da localizacao, nesse caso ele é utilizado para -
          // dar o espaçamento inicial até o mapa ser carregado.
          return AreaMapa(
            child: Container(),
            bgColor: Colors.grey[100],
          );
        }
      },
    );
  }
}
