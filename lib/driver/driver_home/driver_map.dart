import 'package:ambulance_nepal/map/devices/device_controller.dart';
import 'package:ambulance_nepal/map/map_controller.dart';
import 'package:ambulance_nepal/services/location_services.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class DriverMapPage extends StatefulWidget {
  DriverMapPage(
      {Key? key,
      required this.lat,
      required this.long,
      required this.patientName,
      required this.name,
      required this.number,
      required this.injuryType,
      required this.requestId})
      : super(key: key);

  double lat;
  double long;
  String patientName;
  String name;
  String number;
  String injuryType;
  String requestId;

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  var controller = Get.put(MapController());
  var dController = Get.put(DeviceController());

  late MapController mapController = Get.find<MapController>();

  LocationServices locationServices = Get.find<LocationServices>();

  final double minZoom = 12.0, maxZoom = 19.0, midZoom = 15.0;

  final _markers = <String, Marker>{}.obs;

  List<ToggleButtonItem> mapTypeList = <ToggleButtonItem>[
    ToggleButtonItem(
      name: "Normal",
      icon: Icon(
        Icons.map,
        color: Constants.color,
      ),
    ),
    ToggleButtonItem(
      name: "Hybrid",
      icon: Icon(
        Icons.scanner_outlined,
        color: Constants.color,
      ),
    ),
    ToggleButtonItem(
      name: "Terrain",
      icon: Icon(
        Icons.monochrome_photos,
        color: Constants.color,
      ),
    ),
    ToggleButtonItem(
      name: "Satellite",
      icon: Icon(
        Icons.satellite,
        color: Constants.color,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    createPatientMarker(widget.lat, widget.long);
  }

  @override
  void dispose() {
    super.dispose();
  }

  createPatientMarker(double lat, double long) {
    var userMarker = Marker(
      markerId: const MarkerId("patient"),
      infoWindow: InfoWindow(
        title: widget.name,
        snippet: "Patient is waiting here",
      ),
      visible: true,
      position: LatLng(lat, long),
    );

    _markers["patient"] = userMarker;
  }

  Widget _mapView() {
    CameraPosition pos =
        CameraPosition(target: LatLng(widget.lat, widget.long), zoom: midZoom);
    return Obx(
      () => GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: true,
        markers: Set<Marker>.of(_markers.values),
        polylines: mapController.polyLines,
        mapType: mapController.mapType,
        initialCameraPosition: pos,
        onMapCreated: mapController.onCreated,
      ),
    );
  }

  Widget mapTypesToggleButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 15.0),
      child: CircleAvatar(
        backgroundColor: Constants.color,
        child: PopupMenuButton<ToggleButtonItem>(
            icon: const Icon(
              Icons.map,
              color: Colors.white,
            ),
            onSelected: (ToggleButtonItem value) {
              if (value.name == "Normal") {
                mapController.changeMapType(MapType.normal);
              } else if (value.name == "Hybrid") {
                mapController.changeMapType(MapType.hybrid);
              } else if (value.name == "Terrain") {
                mapController.changeMapType(MapType.terrain);
              } else if (value.name == "Satellite") {
                mapController.changeMapType(MapType.satellite);
              }
            },
            itemBuilder: (BuildContext context) {
              return mapTypeList.map((ToggleButtonItem mapTypeItem) {
                return PopupMenuItem<ToggleButtonItem>(
                  value: mapTypeItem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      mapTypeItem.icon!,
                      Text(
                        mapTypeItem.name!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            }),
      ),
    );
  }

  Widget startEndTripButton() {
    return ElevatedButton(
        onPressed: () {
          if (!(Constants.isTripStarted.value)) {
            //start trip
            Constants.isTripEnded.value = false;
            Constants.isTripStarted.value = true;

            Get.find<VehicleRequestController>()
                .sendStartTrip(Constants.requestId, DateTime.now().toString());
          } else if (Constants.isTripStarted.value &&
              !(Constants.isTripEnded.value)) {
            //end trip
            Constants.isTripStarted.value = false;
            Constants.isTripEnded.value = true;
            Get.back();

            Get.find<VehicleRequestController>().sendEndTrip(
                Constants.requestId,
                DateTime.now().toString(),
                Get.find<LocationServices>().locationData!.latitude.toString(),
                Get.find<LocationServices>().locationData!.latitude.toString());
          } else {
            Constants.isTripEnded.value = false;
            Constants.isTripStarted.value = false;
          }
        },
        child: Obx(
          () => Constants.isTripStarted.value
              ? const Text("End trip")
              : const Text("Start Trip"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<LocationServices>(builder: (builder) {
          return Get.find<LocationServices>().locationData == null
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : GetBuilder<MapController>(builder: (builder) {
                  return SafeArea(
                    bottom: false,
                    child: Stack(
                      children: [
                        _mapView(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: mapTypesToggleButton(context),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: startEndTripButton(),
                        ),
                      ],
                    ),
                  );
                });
        }),
      ),
    );
  }
}

class ToggleButtonItem {
  String? name;
  Icon? icon;

  ToggleButtonItem({
    this.name,
    this.icon,
  });
}
