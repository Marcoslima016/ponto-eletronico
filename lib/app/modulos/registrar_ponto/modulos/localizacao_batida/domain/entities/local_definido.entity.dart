import 'package:flutter/material.dart';

import 'entities.imports.dart';

class LocalDefinido implements ILocalDaBatida {
  String nomeLocal;
  int idLocal;
  @override
  GeoPosition geoPosition;
  int distancia;
  LocalDefinido({
    @required this.nomeLocal,
    @required this.geoPosition,
    @required this.idLocal,
    @required this.distancia,
  });
}
