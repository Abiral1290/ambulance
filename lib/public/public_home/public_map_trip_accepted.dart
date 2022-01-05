import 'dart:async';

import 'package:ambulance_nepal/map/devices/device_controller.dart';
import 'package:ambulance_nepal/map/devices/devices.dart';
import 'package:ambulance_nepal/map/map_controller.dart';
import 'package:ambulance_nepal/services/location_services.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class PublicMaptripAcceptedPage extends StatefulWidget {
  const PublicMaptripAcceptedPage({Key? key}) : super(key: key);

  @override
  State<PublicMaptripAcceptedPage> createState() =>
      _PublicMaptripAcceptedPageState();
}

class _PublicMaptripAcceptedPageState extends State<PublicMaptripAcceptedPage> {
  var controller = Get.put(MapController());
  var dController = Get.put(DeviceController());

  late MapController mapController = Get.find<MapController>();
  late DeviceController deviceController = Get.find<DeviceController>();

  LocationServices locationServices = Get.find<LocationServices>();

  final double minZoom = 12.0, maxZoom = 19.0, midZoom = 15.0;

  final _markers = <String, Marker>{}.obs;

  Timer? timer;

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
    fetchDevice();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchDevice();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  fetchDevice() async {
    deviceController
        .fetchSelectedDevice(Constants.selectedDeviceId!)
        .then((value) {
      print(deviceController.device);
      createMarker(deviceController.device.value);
    });
  }

  createMarker(Devices device) {
    var deviceMarker = Marker(
      markerId: const MarkerId("selectedDevice"),
      infoWindow: InfoWindow(
        title: device.name,
        snippet: device.uniqueid,
      ),
      position: LatLng(device.latitude!, device.longitude!),
    );

    _markers["selectedDevice"] = deviceMarker;
  }

  Widget _mapView() {
    CameraPosition pos = CameraPosition(
        target: LatLng(Get.find<LocationServices>().locationData!.latitude,
            Get.find<LocationServices>().locationData!.longitude),
        zoom: midZoom);
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
    return CircleAvatar(
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
    );
  }

  Widget tripDescription() {
    return Container(
      width: Get.size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                "Driver: ",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                Constants.selectedDriverName!,
                style: const TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Number: ",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                Constants.selectedDriverNumber!,
                style: const TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          Obx(
            () => (!(Constants.isTripStarted.value) &&
                    Constants.isTripAccepted.value)
                ? Text("Your ambulance is on the way",
                    style: TextStyle(color: Constants.color))
                : Text("Trip Started",
                    style: TextStyle(color: Constants.color)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mapTypesToggleButton(context),
                              const SizedBox(
                                width: 8.0,
                              ),
                              tripDescription(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
      }),
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
