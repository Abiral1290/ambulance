import 'dart:convert';

import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:http/http.dart' as http;

class Address {
  int? id;
  String? province;
  String? district;
  String? localLevelEn;

  Address({this.id, this.province, this.district, this.localLevelEn});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province = json['province'];
    district = json['district'];
    localLevelEn = json['local_level_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province'] = province;
    data['district'] = district;
    data['local_level_en'] = localLevelEn;
    return data;
  }
}

class Districts {
  int? id;
  int? provinceId;
  String? name;
  List<Areas>? areas;

  Districts({this.id, this.provinceId, this.name, this.areas});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    name = json['name'];
    if (json['areas'] != null) {
      areas = [];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province_id'] = provinceId;
    data['name'] = name;
    if (areas != null) {
      data['areas'] = areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  int? id;
  int? districtId;
  String? name;
  List<Streets>? streets;

  Areas({this.id, this.districtId, this.name, this.streets});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    if (json['streets'] != null) {
      streets = [];
      json['streets'].forEach((v) {
        streets!.add(Streets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['district_id'] = districtId;
    data['name'] = name;
    if (streets != null) {
      data['streets'] = streets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Streets {
  int? id;
  int? areaId;
  String? name;

  Streets({this.id, this.areaId, this.name});

  Streets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaId = json['area_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['area_id'] = areaId;
    data['name'] = name;
    return data;
  }
}

Future<ApiResponse<List<Address>?>> fetchAddressApi() async {
  var headers = {
    "Accept": "application/json",
  };
  try {
    final response =
        await http.get(Uri.parse(ApiUrls.address), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (mapResponse["success"]) {
        var data = mapResponse["data"].cast<Map<String, dynamic>>();

        List<Address> addressList =
            await data.map<Address>((json) => Address.fromJson(json)).toList();
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], addressList);
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
