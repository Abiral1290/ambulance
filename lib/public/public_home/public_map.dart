import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/map/devices/device_controller.dart';
import 'package:ambulance_nepal/map/map_controller.dart';
import 'package:ambulance_nepal/services/location_services.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class PublicMapPage extends StatefulWidget {
  const PublicMapPage({Key? key}) : super(key: key);

  @override
  State<PublicMapPage> createState() => _PublicMapPageState();
}

class _PublicMapPageState extends State<PublicMapPage> {
  var controller = Get.put(MapController());
  var dController = Get.put(DeviceController());

  late MapController mapController = Get.find<MapController>();
  late DeviceController deviceController = Get.find<DeviceController>();

  LocationServices locationServices = Get.find<LocationServices>();

  final double minZoom = 12.0, maxZoom = 19.0, midZoom = 15.0;

  final _markers = <String, Marker>{}.obs;

  var selectedLatitude = 0.0.obs;
  var selectedLongitude = 0.0.obs;

  BitmapDescriptor? ambulanceIcon;

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
    createMarkerIcon();
    fetchDevices();
    timer = Timer(const Duration(seconds: 10), () {
      fetchDevices();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  createMarkerIcon() async {
    await getBytesFromAsset('assets/ambulance_marker.png', 64).then((onValue) {
      ambulanceIcon = BitmapDescriptor.fromBytes(onValue);
    });
    // var bitmap = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(
    //     devicePixelRatio: 2.5,
    //     size: Size(1000, 1000),
    //   ),
    //   "assets/ambulance_marker.png",
    // );
    // ambulanceIcon = bitmap;
  }

  fetchDevices() async {
    if (Get.find<LocationServices>().locationData != null) {
      deviceController
          .fetchDevice(
              Get.find<LocationServices>().locationData!.latitude.toString(),
              Get.find<LocationServices>().locationData!.longitude.toString())
          .then((value) {
        print(deviceController.devicesList);
        createMarker(deviceController.devicesList);
      });
    }
  }

  createSourceMarker(LatLng position) {
    var userMarker = Marker(
      markerId: const MarkerId("user"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: Get.find<AuthController>().users!.name,
        snippet: "This is where ambulance will arrive",
      ),
      visible: true,
      position: LatLng(position.latitude, position.longitude),
    );

    _markers["user"] = userMarker;
  }

  createMarker(List<dynamic> devices) {
    for (var device in devices) {
      var deviceMarker = Marker(
        markerId: MarkerId(device.uniqueid + device.deviceId.toString()),
        rotation: device.course.toDouble(),
        icon: ambulanceIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: device.name,
          snippet: device.uniqueid,
          onTap: () {
            if (Constants.isRequestedForVehicle.value) {
              Utilities.showToast("You Have already requested for ambulance",
                  toastType: ToastType.info);
            } else {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: Text(device.name),
                      content: SizedBox(
                        height: Get.size.height * 0.5,
                        child: VehicleRequestViewPage(
                          devices: device,
                          latitude: selectedLatitude.value == 0.0
                              ? Get.find<LocationServices>()
                                  .locationData!
                                  .latitude
                              : selectedLatitude.value,
                          longitude: selectedLongitude.value == 0.0
                              ? Get.find<LocationServices>()
                                  .locationData!
                                  .longitude
                              : selectedLongitude.value,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                      scrollable: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    );
                  });
            }
          },
        ),
        position: LatLng(device.latitude, device.longitude),
      );

      _markers[device.uniqueid + device.deviceId.toString()] = deviceMarker;
    }
  }

  Widget sourceText() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: Get.size.width * 0.6,
        // padding: const EdgeInsets.all(10.0),
        // color: Colors.black,
        child: const Text(
          "Long press on map to change the source of request",
          style: TextStyle(
            backgroundColor: Colors.black,
            color: Colors.white,
          ),
        ),
      ),
    );
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
        onLongPress: (position) {
          selectedLatitude.value = position.latitude;
          selectedLongitude.value = position.longitude;
          createSourceMarker(position);
        },
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
                        child: mapTypesToggleButton(context),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: sourceText(),
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
