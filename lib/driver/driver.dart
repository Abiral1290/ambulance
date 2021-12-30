import 'dart:convert';

import 'package:ambulance_nepal/authentication/user.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Driver extends Users {
  String? addressId;
  String? wodaNo;
  String? address;
  String? dob;
  String? driverPhoto;
  String? licenceNumber;
  String? licencePhoto;
  String? hospitalId;
  String? trainingCertificate;
  String? remarks;
  int? isApproved;

  Driver({
    this.addressId,
    this.wodaNo,
    this.address,
    this.dob,
    this.driverPhoto,
    this.licenceNumber,
    this.licencePhoto,
    this.hospitalId,
    this.trainingCertificate,
    this.remarks,
    this.isApproved,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    addressId = json['address_id'].toString();
    wodaNo = json['woda_no'];
    address = json['address'];
    dob = json['dob'];
    firebaseToken = json['firebase_token'];
    apiToken = json['api_token'];
    flag = json['flag'];
    userType = json['user_type'];
    driverPhoto = ApiUrls.storageUrl + json['driver_photo'];
    licenceNumber = json['licence_number'];
    licencePhoto = ApiUrls.storageUrl + json['licence_photo'];
    hospitalId = json['hospital_id'].toString();
    trainingCertificate = ApiUrls.storageUrl + json['training_certificate'];
    remarks = json['remarks'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['address_id'] = addressId;
    data['woda_no'] = wodaNo;
    data['address'] = address;
    data['dob'] = dob;
    data['user_type'] = userType;
    data['driver_photo'] = driverPhoto;
    data['licence_number'] = licenceNumber;
    data['licence_photo'] = licencePhoto;
    data['hospital_id'] = hospitalId;
    data['training_certificate'] = trainingCertificate;
    data['remarks'] = remarks.toString();
    data['email'] = email;
    return data;
  }
}

Future<ApiResponse<Driver?>> registerDriverApi(Driver driver) async {
  try {
    var headers = {
      "Accept": "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.register),
        headers: headers, body: driver.toJson());
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
