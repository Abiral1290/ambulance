import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Devices {
  String? name;
  String? uniqueid;
  int? deviceId;
  String? address;
  double? course;
  double? speed;
  String? attributes;
  String? devicetime;
  int? valid;
  String? serverTime;
  double? latitude;
  double? altitude;
  double? longitude;
  double? distance;
  String? status;

  Devices(
      {this.name,
      this.uniqueid,
      this.deviceId,
      this.address,
      this.course,
      this.speed,
      this.attributes,
      this.devicetime,
      this.valid,
      this.serverTime,
      this.latitude,
      this.altitude,
      this.longitude,
      this.distance,
      this.status});

  Devices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uniqueid = json['uniqueid'];
    deviceId = int.parse(json['device_id'].toString());
    address = json['address'];
    course = double.parse(json['course'].toString());
    speed = double.parse(json['speed'].toString());
    attributes = json['attributes'];
    devicetime = json['devicetime'];
    valid = int.parse(json['valid'].toString());
    serverTime = json['serverTime'];
    latitude = double.parse(json['latitude'].toString());
    altitude = double.parse(json['altitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    distance = double.parse(json['distance'].toString());
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['uniqueid'] = uniqueid;
    data['device_id'] = deviceId;
    data['address'] = address;
    data['course'] = course;
    data['speed'] = speed;
    data['attributes'] = attributes;
    data['devicetime'] = devicetime;
    data['valid'] = valid;
    data['serverTime'] = serverTime;
    data['latitude'] = latitude;
    data['altitude'] = altitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    data['status'] = status;
    return data;
  }
}

Future<ApiResponse<List<Devices>?>> fetchDeviceApi(
    String latitude, String longitude) async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}",
    };

    var bodyData = {
      "latitude": latitude,
      "longitude": longitude,
    };

    final response = await http.post(Uri.parse(ApiUrls.ambulanceList),
        headers: headers, body: bodyData);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      if (mapResponse["success"]) {
        final data = mapResponse["data"].cast<Map<String, dynamic>>();
        List<Devices> devicesList = await data.map<Devices>((json) {
          var device = Devices.fromJson(json);
          return device;
        }).toList();
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], devicesList);
      } else {
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], null);
      }
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}

Future<ApiResponse<Devices?>> fetchIndividualDeviceApi(String uniqueId) async {
  // try {
  var headers = {
    "Accept": "application/json",
    "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}",
  };

  var bodyData = {"device_uniqueid": uniqueId};

  final response = await http.post(Uri.parse(ApiUrls.individualDevice),
      headers: headers, body: bodyData);

  if (response.statusCode == 200) {
    var mapResponse = json.decode(response.body);
    if (mapResponse["success"]) {
      final device = Devices.fromJson(mapResponse["data"]);

      return ApiResponse(
          mapResponse["success"], mapResponse["message"], device);
    } else {
      return ApiResponse(mapResponse["success"], mapResponse["message"], null);
    }
  } else {
    return ApiResponse(false, response.reasonPhrase!, null);
  }
  // } catch (e) {
  //   print(e.toString());
  //   return ApiResponse(false, e.toString(), null);
  // }
}
