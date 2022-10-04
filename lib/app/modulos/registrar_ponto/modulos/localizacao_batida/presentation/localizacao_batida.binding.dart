import 'package:get/get.dart';

import '../../../../../../lib.imports.dart';
import '../localizacao_batida.imports.dart';

class LocalizacaoBatidaBinding extends Bindings {
  @override
  void dependencies() {
    //
    //========== DRIVERS =========

    Get.put<IGeolocationDriver>(GeolocatorDriver());

    //========= USECASES =========

    //IDeterminarLocalComBaseNaPosicao
    Get.put<IDeterminarLocalComBaseNaPosicao>(
      DeterminarLocalComBaseNaPosicao(driver: Get.find<IGeolocationDriver>()),
    );
    //IRecuperarLocalDaBatida
    Get.put<IRecuperarLocalDaBatida>(
      RecuperarLocalDaBatida(determinarLocalComBaseNaPosicao: Get.find<IDeterminarLocalComBaseNaPosicao>()),
    );
    //IGeolocalizacaoTrabalhador
    Get.put<IGeolocalizacaoTrabalhador>(
      GeolocalizacaoTrabalhador(driver: Get.find<IGeolocationDriver>()),
    );

    //======== CONTROLLER ========
    Get.lazyPut(() {
      return LocalizacaoBatidaController(
        recuperarLocalDaBatida: Get.find<IRecuperarLocalDaBatida>(),
        driver: Get.find<IGeolocationDriver>(),
      );
    });
  }
  //
}
