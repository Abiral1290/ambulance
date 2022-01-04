import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminChecklist {
  int? ambulanceId;
  String? ambulanceType;
  String? rejectedMessage;
  String? rejectedType;
  String? vehicleNumber;
  String? stethoscope;
  String? bpSet;
  String? trouchLight;
  String? tongueDepressure;
  String? ivDrips;
  String? cannulaAndSyringes;
  String? ecgMoniterAndOxygenMoniter;
  String? intubationSet;
  String? variousIntubationTubesAndLaryngealTubes;
  String? nebulizerSet;
  String? ambuBag;
  String? manualSuctionSet;
  String? cervicalCollars;
  String? cprBoard;
  String? oxygenSupply;
  String? automatedExternalDefibrillator;
  String? deliverySets;
  String? dressingSets;
  String? splints;
  String? catheterizationsSets;
  String? haemostaticSets;
  String? aEmergencyMedicines;
  String? aTravellingVentilator;
  String? aChestDrainageTubes;
  String? others;
  String? medicines;
  String? washingEquipment;
  String? wheelchairAndTrolley;
  String? radioCommunication;
  String? twoWayVideoConsultationDevice;
  String? mobileDeviceWith4gConnectivity;
  String? walkieTalkie;
  String? camera;
  String? gps;

  AdminChecklist(
      {this.ambulanceId,
      this.ambulanceType,
      this.rejectedMessage,
      this.rejectedType,
      this.vehicleNumber,
      this.stethoscope,
      this.bpSet,
      this.trouchLight,
      this.tongueDepressure,
      this.ivDrips,
      this.cannulaAndSyringes,
      this.ecgMoniterAndOxygenMoniter,
      this.intubationSet,
      this.variousIntubationTubesAndLaryngealTubes,
      this.nebulizerSet,
      this.ambuBag,
      this.manualSuctionSet,
      this.cervicalCollars,
      this.cprBoard,
      this.oxygenSupply,
      this.automatedExternalDefibrillator,
      this.deliverySets,
      this.dressingSets,
      this.splints,
      this.catheterizationsSets,
      this.haemostaticSets,
      this.aEmergencyMedicines,
      this.aTravellingVentilator,
      this.aChestDrainageTubes,
      this.others,
      this.medicines,
      this.washingEquipment,
      this.wheelchairAndTrolley,
      this.radioCommunication,
      this.twoWayVideoConsultationDevice,
      this.mobileDeviceWith4gConnectivity,
      this.walkieTalkie,
      this.camera,
      this.gps});

  AdminChecklist.fromJson(Map<String, dynamic> json) {
    ambulanceId = json['ambulance_id'];
    ambulanceType = json['ambulance_type'];
    rejectedMessage = json['rejected_message'];
    rejectedType = json['rejected_type'];
    vehicleNumber = json['vehicle_number'];
    stethoscope = json['stethoscope'];
    bpSet = json['bp_set'];
    trouchLight = json['trouch_light'];
    tongueDepressure = json['tongue_depressure'];
    ivDrips = json['iv_drips'];
    cannulaAndSyringes = json['cannula_and_syringes'];
    ecgMoniterAndOxygenMoniter = json['ecg_moniter_and_oxygen_moniter'];
    intubationSet = json['intubation_set'];
    variousIntubationTubesAndLaryngealTubes =
        json['various_intubation_tubes_and_laryngeal_tubes'];
    nebulizerSet = json['nebulizer_set'];
    ambuBag = json['ambu_bag'];
    manualSuctionSet = json['manual_suction_set'];
    cervicalCollars = json['cervical_collars'];
    cprBoard = json['cpr_board'];
    oxygenSupply = json['oxygen_supply'];
    automatedExternalDefibrillator = json['automated_external_defibrillator'];
    deliverySets = json['delivery_sets'];
    dressingSets = json['dressing_sets'];
    splints = json['splints'];
    catheterizationsSets = json['catheterizations_sets'];
    haemostaticSets = json['haemostatic_sets'];
    aEmergencyMedicines = json['a_emergency_medicines'];
    aTravellingVentilator = json['a_travelling_ventilator'];
    aChestDrainageTubes = json['a_chest_drainage_tubes'];
    others = json['others'];
    medicines = json['medicines'];
    washingEquipment = json['washing_equipment'];
    wheelchairAndTrolley = json['wheelchair_and_trolley'];
    radioCommunication = json['radio_communication'];
    twoWayVideoConsultationDevice = json['two_way_video_consultation_device'];
    mobileDeviceWith4gConnectivity = json['mobile_device_with_4g_connectivity'];
    walkieTalkie = json['walkie_talkie'];
    camera = json['camera'];
    gps = json['gps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ambulance_id'] = ambulanceId.toString();
    data['ambulance_type'] = ambulanceType;
    data['rejected_message'] = rejectedMessage;
    data['rejected_type'] = rejectedType;
    data['vehicle_number'] = vehicleNumber;
    data['stethoscope'] = stethoscope;
    data['bp_set'] = bpSet;
    data['trouch_light'] = trouchLight;
    data['tongue_depressure'] = tongueDepressure;
    data['iv_drips'] = ivDrips;
    data['cannula_and_syringes'] = cannulaAndSyringes;
    data['ecg_moniter_and_oxygen_moniter'] = ecgMoniterAndOxygenMoniter;
    data['intubation_set'] = intubationSet;
    data['various_intubation_tubes_and_laryngeal_tubes'] =
        variousIntubationTubesAndLaryngealTubes;
    data['nebulizer_set'] = nebulizerSet;
    data['ambu_bag'] = ambuBag;
    data['manual_suction_set'] = manualSuctionSet;
    data['cervical_collars'] = cervicalCollars;
    data['cpr_board'] = cprBoard;
    data['oxygen_supply'] = oxygenSupply;
    data['automated_external_defibrillator'] = automatedExternalDefibrillator;
    data['delivery_sets'] = deliverySets;
    data['dressing_sets'] = dressingSets;
    data['splints'] = splints;
    data['catheterizations_sets'] = catheterizationsSets;
    data['haemostatic_sets'] = haemostaticSets;
    data['a_emergency_medicines'] = aEmergencyMedicines;
    data['a_travelling_ventilator'] = aTravellingVentilator;
    data['a_chest_drainage_tubes'] = aChestDrainageTubes;
    data['others'] = others;
    data['medicines'] = medicines;
    data['washing_equipment'] = washingEquipment;
    data['wheelchair_and_trolley'] = wheelchairAndTrolley;
    data['radio_communication'] = radioCommunication;
    data['two_way_video_consultation_device'] = twoWayVideoConsultationDevice;
    data['mobile_device_with_4g_connectivity'] = mobileDeviceWith4gConnectivity;
    data['walkie_talkie'] = walkieTalkie;
    data['camera'] = camera;
    data['gps'] = gps;
    return data;
  }
}

Future<ApiResponse> postAdminFormApi(AdminChecklist adminChecklist) async {
  try {
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}"
    };
    var bodyData = adminChecklist.toJson();
    final response = await http.post(Uri.parse(ApiUrls.adminChecklist),
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
