import 'package:ambulance_nepal/address/address.dart';
import 'package:ambulance_nepal/driver/driver.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import "package:collection/collection.dart";

import 'package:get/get.dart';

class DriverController extends GetxController {
  List<Address> addressList = [];

  List<String> provinceList = [];
  List<String> districtList = [];
  List<String> areaList = [];

  String selectedProvince = "";
  String selectedDistrict = "";
  String selectedArea = "";

  String selectedAreaId = "";

  getSelectedAreaId(String area) {
    var newList =
        addressList.where((element) => element.localLevelEn == selectedArea);
    selectedAreaId = newList.first.id.toString();
    update();
  }

  setSelectedProvince(String province) {
    selectedProvince = province;
    update();
  }

  setSelectedDistrict(String district) {
    selectedDistrict = district;
    update();
  }

  setSelectedArea(String area) {
    selectedArea = area;
    getSelectedAreaId(area);
    update();
  }

  getProvinceList() {
    var newprovinceList =
        addressList.groupListsBy((element) => element.province);
    for (var list in newprovinceList.keys) {
      provinceList.add(list!);
    }
    setSelectedProvince(provinceList.first);

    getDistrictList(provinceList.first);

    update();
  }

  getDistrictList(String selectedProvince) {
    districtList = [];
    var newList = addressList
        .where((element) => element.province == selectedProvince)
        .toList();
    var newdistrictList = newList.groupListsBy((element) => element.district);
    for (var district in newdistrictList.keys) {
      districtList.add(district!);
    }
    setSelectedDistrict(districtList.first);

    getAreaList(districtList.first);

    update();
  }

  getAreaList(String selectedDistrict) {
    areaList = [];
    var newList = addressList
        .where((element) => element.district == selectedDistrict)
        .toList();
    var newArealist = newList.groupListsBy((element) => element.localLevelEn);
    for (var area in newArealist.keys) {
      areaList.add(area!);
    }
    setSelectedArea(areaList.first);

    update();
  }

  Address getUserAddress(String addressId) {
    var list = addressList
        .where((element) => element.id.toString() == addressId)
        .toList();
    return list.first;
  }

  @override
  void onInit() {
    districtList = [];
    areaList = [];
    fetchAddress();
    // fetchHospitals();
    super.onInit();
  }

  fetchAddress() async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      fetchAddressApi().then((value) {
        if (value.success) {
          addressList = value.response!;
          getProvinceList();
          update();
        } else {
          Utilities.showToast(value.message, toastType: ToastType.error);
        }
      });
    } else {
      Utilities.showToast("No internet connection", toastType: ToastType.info);
    }
  }

  Future<bool> registerDriver(Driver driver) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var data = await registerDriverApi(driver);
      Utilities.showToast(data.message);
      return data.success;
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
      return false;
    }
  }
}
