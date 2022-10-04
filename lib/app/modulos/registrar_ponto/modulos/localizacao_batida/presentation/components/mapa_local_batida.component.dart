import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../presentation.imports.dart';

class MapaLocalBatida extends StatelessWidget {
  bool falhaAoObterLocalizacao = true;

  LocalizacaoBatidaController controller = Get.find<LocalizacaoBatidaController>();

  double w;
  double h;

  MapaLocalBatida({
    @required this.falhaAoObterLocalizacao,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    if (falhaAoObterLocalizacao == true) {
      //
      //============ FALHA AO OBTER LOCALIZACAO ============

      return FalhaLocalizacao();
      //
      //
    } else {
      //
      //================ LOCALIZACAO OBTIDA =================

      return mapBody(context);
    }
  }

  Widget mapBody(BuildContext context) {
    //
    // Marcador
    final Set<Marker> _markers = {
      Marker(
        markerId: MarkerId("posição trabalhador"),
        position: LatLng(
          controller.localDaBatida.geoPosition.latitude,
          controller.localDaBatida.geoPosition.longitude,
        ),
        infoWindow: InfoWindow(title: 'Nice Place'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };

    // Mapa
    return AreaMapa(
      bgColor: Colors.grey[100],
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: GoogleMap(
          // onMapCreated: mapController.map.controller.complete,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.localDaBatida.geoPosition.latitude,
              controller.localDaBatida.geoPosition.longitude,
            ),
            // zoom: 12.0,
            zoom: 14.0,
          ),
          mapType: MapType.normal,
          markers: _markers,
          // markers: mapaController.configMapaService.markers,
          // markers: snapshot.data,
          // onCameraMove: _onCameraMove,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
