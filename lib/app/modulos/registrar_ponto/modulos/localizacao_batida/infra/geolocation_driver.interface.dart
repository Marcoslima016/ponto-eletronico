import '../localizacao_batida.imports.dart';

abstract class IGeolocationDriver {
  //

  Future<bool> locationIsEnable();

  Future<GeoPosition> getPosition();

  //Checa permissao e se não estiver aprovada, solicita a permissão
  Future<bool> checkPermission();

  Future<double> distanciaEntreDoisPontos({GeoPosition pontoA, GeoPosition pontoB});

  ///Verifica o status da permissão, sem fazer a solicitação de permissão
  Future<bool> checkPermissionStatus();
}
