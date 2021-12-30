import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VehicleRequest {
  int? patientUserid;
  String? patientName;
  String? deviceUniqueid;
  String? patientInjuryType;
  String? remarks;
  String? lat;
  String? long;
  String? updatedAt;
  String? createdAt;
  int? id;

  VehicleRequest(
      {this.patientUserid,
      this.patientName,
      this.deviceUniqueid,
      this.patientInjuryType,
      this.remarks,
      this.lat,
      this.long,
      this.updatedAt,
      this.createdAt,
      this.id});

  VehicleRequest.fromJson(Map<String, dynamic> json) {
    patientUserid = json['patient_userid'];
    patientName = json['patient_name'];
    deviceUniqueid = json['device_uniqueid'];
    patientInjuryType = json['patient_injury_type'];
    remarks = json['remarks'];
    lat = json['lat'];
    long = json['long'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_name'] = patientName;
    data['device_uniqueid'] = deviceUniqueid;
    data['patient_injury_type'] = patientInjuryType;
    data['remarks'] = remarks;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

Future<ApiResponse> sendRequestApi(VehicleRequest vehicleRequest) async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}"
    };
    var bodyData = vehicleRequest.toJson();
    var response = await http.post(Uri.parse(ApiUrls.vehicleRequest),
        headers: headers, body: bodyData);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      return ApiResponse(mapResponse["success"], mapResponse["message"], null);
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}

Future<ApiResponse> sendResponseApi(String respons, String requestId) async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}"
    };
    var bodyData = {"response": respons, "request_id": requestId};
    var response = await http.post(Uri.parse(ApiUrls.vehicleResponse),
        headers: headers, body: bodyData);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      return ApiResponse(mapResponse["success"], mapResponse["message"], null);
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
