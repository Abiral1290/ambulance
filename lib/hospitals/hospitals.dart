import 'dart:convert';

import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Hospitals {
  int? id;
  String? hospitalName;

  Hospitals({this.id, this.hospitalName});

  Hospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_name'] = hospitalName;
    return data;
  }
}

Future<ApiResponse<List<Hospitals>?>> fetchHospitalsApi() async {
  try {
    var headers = {
      "Accept": "application/json",
    };
    final response =
        await http.get(Uri.parse(ApiUrls.hospitals), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (mapResponse["success"]) {
        final data = mapResponse["data"].cast<Map<String, dynamic>>();
        List<Hospitals> hospitalList = await data
            .map<Hospitals>((json) => Hospitals.fromJson(json))
            .toList();
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], hospitalList);
      } else {
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], null);
      }
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    return ApiResponse(false, e.toString(), null);
  }
}
