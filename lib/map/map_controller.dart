import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final Set<Polyline> _polyLines = {};
  GoogleMapController? _mapController;
  MapType mapType = MapType.normal;

  GoogleMapController get mapController => _mapController!;
  Set<Polyline> get polyLines => _polyLines;

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    update();
  }

  changeMapType(MapType newMapType) {
    mapType = newMapType;
    update();
  }

  void animateCameraToDesireLocation(LatLng destination) {
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: destination, zoom: 15)));
    update();
  }
}
