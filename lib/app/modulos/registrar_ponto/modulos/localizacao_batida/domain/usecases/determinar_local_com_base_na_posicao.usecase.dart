import 'package:flutter/material.dart';
import 'package:ptem2/core/ponto_virtual/ponto_virtual.imports.dart';
import '../../localizacao_batida.imports.dart';
import '../domain.imports.dart';

abstract class IDeterminarLocalComBaseNaPosicao {
  Future<LocalDefinido> call({@required GeoPosition geoLocalizacao});
}

class DeterminarLocalComBaseNaPosicao implements IDeterminarLocalComBaseNaPosicao {
  PontoVirtual pontoVirtual;
  final IGeolocationDriver driver;

  DeterminarLocalComBaseNaPosicao({@required this.driver}) {
    pontoVirtual = PontoVirtual.instance;
  }

  @override
  Future<LocalDefinido> call({@required GeoPosition geoLocalizacao}) async {
    List<Local> locais = pontoVirtual.enderecosPonto.locaisPonto;
    for (final Local local in locais) {
      final double distanciaDoLocal = await driver.distanciaEntreDoisPontos(
        pontoA: GeoPosition(latitude: double.parse(local.lat), longitude: double.parse(local.lng)),
        pontoB: geoLocalizacao,
      );

      LocalizacaoBatidaDebugController.instance.logEndereco(
        local: local,
        distancia: distanciaDoLocal.toString(),
      ); ////** DEBUG **/

      if (distanciaDoLocal <= local.distancia) {
        return LocalDefinido(
          nomeLocal: local.descr,
          geoPosition: geoLocalizacao,
          idLocal: local.loccheckpontoId,
          distancia: distanciaDoLocal.round(),
        );
      }
    }
    return null;
  }
}
