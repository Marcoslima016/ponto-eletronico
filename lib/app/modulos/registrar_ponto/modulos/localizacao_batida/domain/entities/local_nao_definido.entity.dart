import '../domain.imports.dart';

class LocalNaoDefinido implements ILocalDaBatida {
  FalhaNaLocalizacao falhaNaLocalizacao;
  @override
  GeoPosition geoPosition;
  String parametroTeste;
  LocalNaoDefinido({
    this.falhaNaLocalizacao,
    this.geoPosition,
    this.parametroTeste,
  });
}
