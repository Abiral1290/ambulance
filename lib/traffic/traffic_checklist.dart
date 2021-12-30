import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TrafficForm {
  String? ambulanceBluebook;
  String? driverLicense;
  String? ambulancePermisision;
  String? ambulanceRenew;
  String? taxFreeClearification;
  String? standardColor;
  String? bigWord102;
  String? starOfLightLogoLeftRightBehind;
  String? gps;
  String? standardSairan;
  String? ambulanceType;
  String? cUpgardeToAB;
  String? fourWheeler;
  String? pricelistInSeenArea;
  String? noSeatBehindDriver;
  String? ambulanceStartedDate;
  String? trainedHealthWorker;
  String? driverAge25;
  String? ambulanceDrivingTranning;
  String? driverName;
  String? driverNumber;
  String? examinatedLocation;
  String? examinatedDatetime;
  String? punishment;
  String? trafficeNameNumber;
  String? updatedAt;
  String? createdAt;
  int? id;

  TrafficForm(
      {this.ambulanceBluebook,
      this.driverLicense,
      this.ambulancePermisision,
      this.ambulanceRenew,
      this.taxFreeClearification,
      this.standardColor,
      this.bigWord102,
      this.starOfLightLogoLeftRightBehind,
      this.gps,
      this.standardSairan,
      this.ambulanceType,
      this.cUpgardeToAB,
      this.fourWheeler,
      this.pricelistInSeenArea,
      this.noSeatBehindDriver,
      this.ambulanceStartedDate,
      this.trainedHealthWorker,
      this.driverAge25,
      this.ambulanceDrivingTranning,
      this.driverName,
      this.driverNumber,
      this.examinatedLocation,
      this.examinatedDatetime,
      this.punishment,
      this.trafficeNameNumber,
      this.updatedAt,
      this.createdAt,
      this.id});

  TrafficForm.fromJson(Map<String, dynamic> json) {
    ambulanceBluebook = json['ambulance_bluebook'];
    driverLicense = json['driver_license'];
    ambulancePermisision = json['ambulance_permisision'];
    ambulanceRenew = json['ambulance_renew'];
    taxFreeClearification = json['tax_free_clearification'];
    standardColor = json['standard_color'];
    bigWord102 = json['big_word_102'];
    starOfLightLogoLeftRightBehind =
        json['star_of_light_logo_left_right_behind'];
    gps = json['gps'];
    standardSairan = json['standard_sairan'];
    ambulanceType = json['ambulance_type'];
    cUpgardeToAB = json['c_upgarde_to_a_b'];
    fourWheeler = json['four_wheeler'];
    pricelistInSeenArea = json['pricelist_in_seen_area'];
    noSeatBehindDriver = json['no_seat_behind_driver'];
    ambulanceStartedDate = json['ambulance_started_date'];
    trainedHealthWorker = json['trained_health_worker'];
    driverAge25 = json['driver_age_25'];
    ambulanceDrivingTranning = json['ambulance_driving_tranning'];
    driverName = json['driver_name'];
    driverNumber = json['driver_number'];
    examinatedLocation = json['examinated_location'];
    examinatedDatetime = json['examinated_datetime'];
    punishment = json['punishment'];
    trafficeNameNumber = json['traffice_name_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ambulance_bluebook'] = ambulanceBluebook;
    data['driver_license'] = driverLicense;
    data['ambulance_permisision'] = ambulancePermisision;
    data['ambulance_renew'] = ambulanceRenew;
    data['tax_free_clearification'] = taxFreeClearification;
    data['standard_color'] = standardColor;
    data['big_word_102'] = bigWord102;
    data['star_of_light_logo_left_right_behind'] =
        starOfLightLogoLeftRightBehind;
    data['gps'] = gps;
    data['standard_sairan'] = standardSairan;
    data['ambulance_type'] = ambulanceType;
    data['c_upgarde_to_a_b'] = cUpgardeToAB;
    data['four_wheeler'] = fourWheeler;
    data['pricelist_in_seen_area'] = pricelistInSeenArea;
    data['no_seat_behind_driver'] = noSeatBehindDriver;
    data['ambulance_started_date'] = ambulanceStartedDate;
    data['trained_health_worker'] = trainedHealthWorker;
    data['driver_age_25'] = driverAge25;
    data['ambulance_driving_tranning'] = ambulanceDrivingTranning;
    data['driver_name'] = driverName;
    data['driver_number'] = driverNumber;
    data['examinated_location'] = examinatedLocation;
    data['examinated_datetime'] = examinatedDatetime;
    data['punishment'] = punishment;
    data['traffice_name_number'] = trafficeNameNumber;
    return data;
  }
}

Future<ApiResponse<bool?>> postTrafficFormApi(TrafficForm trafficForm) async {
  try {
    var headers = {
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}",
      "Accept": "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.trafficCheckList),
        headers: headers, body: trafficForm.toJson());
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      return ApiResponse(mapResponse["success"], mapResponse["message"], null);
      // } else if (response.statusCode == 401) {
      //   //check if user is authenticated
      //   Get.find<AuthController>().clearAllData();
      //   Get.offAll(() => const LoginHomePage());
      //   return ApiResponse(false, response.reasonPhrase!, null);
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}
