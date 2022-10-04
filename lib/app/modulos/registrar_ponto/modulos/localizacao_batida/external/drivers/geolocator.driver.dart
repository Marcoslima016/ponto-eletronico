import 'dart:math';

import '../../localizacao_batida.imports.dart';
import 'package:geolocator/geolocator.dart';

///Driver de geolocalização que utiliza o package "Geolocator"
class GeolocatorDriver implements IGeolocationDriver {
  //

  //[========================== locationIsEnable ===========================]

  @override
  Future<bool> locationIsEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  //[============================= getPosition =============================]

  @override
  Future<GeoPosition> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    return GeoPosition(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  //[=========================== checkPermission ===========================]

  @override
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    return true;
  }

  @override
  Future<bool> checkPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  //[======================= distanciaEntreDoisPontos =======================]

  Future<double> distanciaEntreDoisPontos({GeoPosition pontoA, GeoPosition pontoB}) async {
    try {
      // return Geolocator.distanceBetween(pontoA.latitude, pontoA.longitude, pontoB.latitude, pontoB.longitude);

      double lat1 = pontoA.latitude;
      double lon1 = pontoA.longitude;

      double lat2 = pontoB.latitude;
      double lon2 = pontoB.longitude;

      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      var resultKM = 12742 * asin(sqrt(a));

      return resultKM * 1000;
    } catch (e) {
      throw ("Erro ao calcular distância");
    }
  }
}
