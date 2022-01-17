import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Users {
  int? id;
  String? name;
  String? email;
  String? userType;
  String? phone;
  String? password;
  String? emailVerifiedAt;
  String? firebaseToken;
  String? apiToken;
  int? flag;
  String? createdAt;
  String? updatedAt;

  Users(
      {this.id,
      this.name,
      this.email,
      this.userType,
      this.phone,
      this.password,
      this.emailVerifiedAt,
      this.firebaseToken,
      this.apiToken,
      this.flag,
      this.createdAt,
      this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userType = json['user_type'];
    phone = json['phone'];
    password = json['password'];
    emailVerifiedAt = json['email_verified_at'];
    firebaseToken = json['firebase_token'];
    apiToken = json['api_token'];
    flag = json['flag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['user_type'] = userType;
    data['phone'] = phone;
    data['password'] = password;

    return data;
  }

  Map<String, dynamic> toPreference() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['user_type'] = userType;
    data['phone'] = phone;
    data['password'] = password ?? "";
    data['email_verified_at'] = emailVerifiedAt ?? "";
    data['firebase_token'] = firebaseToken;
    data['api_token'] = apiToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ErrorResponse {
  List<String>? phone;
  List<String>? email;

  ErrorResponse({this.phone, this.email});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'].cast<String>();
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

Future<ApiResponse<Users?>> loginApi(
    String phone, String password, String role, String firebaseToken) async {
  var bodyData = {
    "phone": phone,
    "password": password,
    "role": role,
    "firebase_token": firebaseToken,
  };

  var headers = {"Accept": "application/json"};

  try {
    final response = await http.post(Uri.parse(ApiUrls.login),
        headers: headers, body: bodyData);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["success"]) {
        // var data = mapResponse["data"].cast<Map<String, dynamic>>();

        return ApiResponse(mapResponse["success"], mapResponse["message"],
            Users.fromJson(mapResponse["data"]));
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

Future<ApiResponse<Users?>> registerApi(Users users) async {
  try {
    var headers = {
      "Accept": "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.register),
        headers: headers, body: users.toJson());
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);

      String message = "";

      if (mapResponse["message"] is String) {
        message = mapResponse["message"];
      } else {
        message =
            "Either email or phone is already taken. Try again with different number or email";
        // var messageJson = ErrorResponse.fromJson(mapResponse["message"]);
        // if (messageJson.email != null) {
        //   message = " " + message + messageJson.email!.first;
        // }
        // if (messageJson.phone != null) {
        //   message = " " + message + messageJson.phone!.first;
        // }
      }
      print(message);

      return ApiResponse(mapResponse["success"], message, null);
    } else {
      return ApiResponse(false, response.reasonPhrase!, null);
    }
  } catch (e) {
    print(e.toString());
    return ApiResponse(false, e.toString(), null);
  }
}

Future<ApiResponse> changePasswordApi(
    String oldPassword, String newPassword) async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}",
    };

    var bodyData = {
      "old_password": oldPassword,
      "new_password": newPassword,
    };

    final response = await http.post(Uri.parse(ApiUrls.changePassword),
        headers: headers, body: bodyData);

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

Future<ApiResponse<dynamic>> getProfileApi() async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}",
    };
    var response = await http.get(
      Uri.parse(ApiUrls.profile),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      if (mapResponse["success"]) {
        return ApiResponse(mapResponse["success"], mapResponse["message"],
            mapResponse["data"]);
      } else {
        return ApiResponse(
            mapResponse["success"], mapResponse["message"], null);
      }
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

Future<ApiResponse> logoutApi() async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}"
    };

    final response =
        await http.get(Uri.parse(ApiUrls.logout), headers: headers);

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
