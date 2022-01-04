import 'dart:convert';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/api_reponse.dart';
import 'package:ambulance_nepal/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// initial 5, first reject 6, second reject 7, third reject 8, accept 9
class Ambulance {
  int? id;
  String? hospitalOperation;
  String? vehicleNumber;
  String? inactiveVehicleReason;
  String? inactiveVehicleAnya;
  String? vehicleCc;
  String? vehicleType;
  String? vehicleTypeAnya;
  String? vehicleCompanyname;
  String? deathvehiclePurchaseDonation;
  String? vehiclePurchaseAnya;
  String? vehiclePrice;
  String? vehiclePermissionTwoyears;
  String? gpsConnection;
  String? gpsConnectionAnya;
  String? deathVehicleOptionTwo;
  String? deathVehicleOptiontwoAnya;
  String? deathvehicleNumber;
  String? vehiclePurchaseDate;
  String? vehicleName;
  int? vehicleSupplierName;
  String? vehiclePurchaseType;
  String? preshanKendra;
  String? govnTaxoff;
  String? govnTaxoffOnya;
  String? ambulanceSeenNumber;
  String? ambulanceContactNum;
  String? ambulanceWritten;
  String? sairen;
  String? sairenAnya;
  String? ambulanceAgreement;
  String? ambCoordinationAnya;
  String? ambulanceDriver;
  String? ambDriverAnya;
  String? driverAge;
  String? driverTraining;
  String? driverNameOne;
  String? driverTrainingtimeOne;
  String? trainingCenterNameOne;
  String? ambEmtTraining;
  String? driverNameTwo;
  String? driverTrainingtimeTwo;
  String? trainingCenterNameTwo;
  String? noOfdriver;
  String? driverExp;
  String? ambEmt;
  String? patientCaretakerInsurance;
  String? patientInsurance;
  String? patientFamilyDeal;
  String? patientHandover;
  String? deal;
  String? customs;
  String? hospitalName;
  String? ambulanceCategory;
  String? discussion;
  String? remarks;
  int? formLevel;
  String? provinces;
  String? district;
  String? municipality;
  int? wardNo;
  String? proceedTo;
  String? rejectedBy;
  String? rejectedMessage;
  String? createdBy;
  String? barga;
  int? hospitalId;
  String? createdAt;
  String? updatedAt;
  int? isRejected;
  String? ambulanceCatagory;
  String? driverInsurance;
  String? contactPersonName;
  String? contactPersonPost;
  String? ambulanceServiceOffice;
  String? contactNo;
  String? organizationEmail;
  String? socialMedia;
  String? websiteDomain;
  String? ambulanceRunningOrgcatagory;
  String? ambulanceRunningOrganizationName;
  String? organizationRegisterDate;
  String? organizationRegisterNum;
  String? bidhan;
  String? districtnameOfregisteredOrganization;
  String? ambRunningOrgDetail;
  String? mbRenewDate;
  String? panExamin;
  String? bidhanAnya;
  String? panNumber;
  String? socialWelfare;
  String? dartaNo;
  String? totalAmbulance;
  String? ambRunningOrganizationCatagory;
  String? ambDetails;
  String? ambDetailsAnya;
  String? ambulanceServiceAnya;
  String? ambCatagoryAnya;
  String? ambulanceVerified;
  String? uniqueId;
  String? file1;
  String? file2;

  Ambulance(
      {this.id,
      this.hospitalOperation,
      this.vehicleNumber,
      this.inactiveVehicleReason,
      this.inactiveVehicleAnya,
      this.vehicleCc,
      this.vehicleType,
      this.vehicleTypeAnya,
      this.vehicleCompanyname,
      this.deathvehiclePurchaseDonation,
      this.vehiclePurchaseAnya,
      this.vehiclePrice,
      this.vehiclePermissionTwoyears,
      this.gpsConnection,
      this.gpsConnectionAnya,
      this.deathVehicleOptionTwo,
      this.deathVehicleOptiontwoAnya,
      this.deathvehicleNumber,
      this.vehiclePurchaseDate,
      this.vehicleName,
      this.vehicleSupplierName,
      this.vehiclePurchaseType,
      this.preshanKendra,
      this.govnTaxoff,
      this.govnTaxoffOnya,
      this.ambulanceSeenNumber,
      this.ambulanceContactNum,
      this.ambulanceWritten,
      this.sairen,
      this.sairenAnya,
      this.ambulanceAgreement,
      this.ambCoordinationAnya,
      this.ambulanceDriver,
      this.ambDriverAnya,
      this.driverAge,
      this.driverTraining,
      this.driverNameOne,
      this.driverTrainingtimeOne,
      this.trainingCenterNameOne,
      this.ambEmtTraining,
      this.driverNameTwo,
      this.driverTrainingtimeTwo,
      this.trainingCenterNameTwo,
      this.noOfdriver,
      this.driverExp,
      this.ambEmt,
      this.patientCaretakerInsurance,
      this.patientInsurance,
      this.patientFamilyDeal,
      this.patientHandover,
      this.deal,
      this.customs,
      this.hospitalName,
      this.ambulanceCategory,
      this.discussion,
      this.remarks,
      this.formLevel,
      this.provinces,
      this.district,
      this.municipality,
      this.wardNo,
      this.proceedTo,
      this.rejectedBy,
      this.rejectedMessage,
      this.createdBy,
      this.barga,
      this.hospitalId,
      this.createdAt,
      this.updatedAt,
      this.isRejected,
      this.ambulanceCatagory,
      this.driverInsurance,
      this.contactPersonName,
      this.contactPersonPost,
      this.ambulanceServiceOffice,
      this.contactNo,
      this.organizationEmail,
      this.socialMedia,
      this.websiteDomain,
      this.ambulanceRunningOrgcatagory,
      this.ambulanceRunningOrganizationName,
      this.organizationRegisterDate,
      this.organizationRegisterNum,
      this.bidhan,
      this.districtnameOfregisteredOrganization,
      this.ambRunningOrgDetail,
      this.mbRenewDate,
      this.panExamin,
      this.bidhanAnya,
      this.panNumber,
      this.socialWelfare,
      this.dartaNo,
      this.totalAmbulance,
      this.ambRunningOrganizationCatagory,
      this.ambDetails,
      this.ambDetailsAnya,
      this.ambulanceServiceAnya,
      this.ambCatagoryAnya,
      this.ambulanceVerified,
      this.uniqueId,
      this.file1,
      this.file2});

  Ambulance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalOperation = json['hospital_operation'] ?? "";
    vehicleNumber = json['vehicle_number'] ?? "";
    inactiveVehicleReason = json['inactive_vehicle_reason'] ?? "";
    inactiveVehicleAnya = json['inactive_vehicle_anya'] ?? "";
    vehicleCc = json['vehicle_cc'] ?? "";
    vehicleType = json['vehicle_type'] ?? "";
    vehicleTypeAnya = json['vehicle_type_anya'] ?? "";
    vehicleCompanyname = json['vehicle_companyname'] ?? "";
    deathvehiclePurchaseDonation = json['deathvehicle_purchase_donation'] ?? "";
    vehiclePurchaseAnya = json['vehicle_purchase_anya'] ?? "";
    vehiclePrice = json['vehicle_price'] ?? "";
    vehiclePermissionTwoyears = json['vehicle_permission_twoyears'] ?? "";
    gpsConnection = json['gps_connection'] ?? "";
    gpsConnectionAnya = json['gps_connection_anya'] ?? "";
    deathVehicleOptionTwo = json['death_vehicle_option_two'] ?? "";
    deathVehicleOptiontwoAnya = json['death_vehicle_optiontwo_anya'] ?? "";
    deathvehicleNumber = json['deathvehicle_number'] ?? "";
    vehiclePurchaseDate = json['vehicle_purchase_date'] ?? "";
    vehicleName = json['vehicle_name'] ?? "";
    vehicleSupplierName = json['vehicle_supplier_name'];
    vehiclePurchaseType = json['vehicle_purchase_type'] ?? "";
    preshanKendra = json['preshan_kendra'] ?? "";
    govnTaxoff = json['govn_taxoff'] ?? "";
    govnTaxoffOnya = json['govn_taxoff_onya'] ?? "";
    ambulanceSeenNumber = json['ambulance_seen_number'] ?? "";
    ambulanceContactNum = json['ambulance_contact_num'] ?? "";
    ambulanceWritten = json['ambulance_written'] ?? "";
    sairen = json['sairen'] ?? "";
    sairenAnya = json['sairen_anya'] ?? "";
    ambulanceAgreement = json['ambulance_agreement'] ?? "";
    ambCoordinationAnya = json['amb_coordination_anya'] ?? "";
    ambulanceDriver = json['ambulance_driver'] ?? "";
    ambDriverAnya = json['amb_driver_anya'] ?? "";
    driverAge = json['driver_age'] ?? "";
    driverTraining = json['driver_training'] ?? "";
    driverNameOne = json['driver_name_one'] ?? "";
    driverTrainingtimeOne = json['driver_trainingtime_one'] ?? "";
    trainingCenterNameOne = json['training_center_name_one'] ?? "";
    ambEmtTraining = json['amb_emt_training'] ?? "";
    driverNameTwo = json['driver_name_two'] ?? "";
    driverTrainingtimeTwo = json['driver_trainingtime_two'] ?? "";
    trainingCenterNameTwo = json['training_center_name_two'] ?? "";
    noOfdriver = json['no_ofdriver'] ?? "";
    driverExp = json['driver_exp'] ?? "";
    ambEmt = json['amb_emt'] ?? "";
    patientCaretakerInsurance = json['patient_caretaker_insurance'] ?? "";
    patientInsurance = json['patient_insurance'] ?? "";
    patientFamilyDeal = json['patient_family_deal'] ?? "";
    patientHandover = json['patient_handover'] ?? "";
    deal = json['deal'] ?? "";
    customs = json['customs'] ?? "";
    hospitalName = json['hospital_name'] ?? "";
    ambulanceCategory = json['ambulance_category'] ?? "";
    discussion = json['discussion'] ?? "";
    remarks = json['remarks'] ?? "";
    formLevel = json['form_level'];
    provinces = json['provinces'] ?? "";
    district = json['district'] ?? "";
    municipality = json['municipality'] ?? "";
    wardNo = json['ward_no'];
    proceedTo = json['proceed_to'] ?? "";
    rejectedBy = json['rejected_by'] ?? "";
    rejectedMessage = json['rejected_message'] ?? "";
    createdBy = json['created_by'] ?? "";
    barga = json['barga'] ?? "";
    hospitalId = json['hospital_id'];
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    isRejected = json['is_rejected'];
    ambulanceCatagory = json['ambulance_catagory'] ?? "";
    driverInsurance = json['driver_insurance'] ?? "";
    contactPersonName = json['contact_person_name'] ?? "";
    contactPersonPost = json['contact_person_post'] ?? "";
    ambulanceServiceOffice = json['ambulance_service_office'] ?? "";
    contactNo = json['contact_no'] ?? "";
    organizationEmail = json['organization_email'] ?? "";
    socialMedia = json['social_media'] ?? "";
    websiteDomain = json['website_domain'] ?? "";
    ambulanceRunningOrgcatagory = json['ambulance_running_orgcatagory'] ?? "";
    ambulanceRunningOrganizationName =
        json['ambulance_running_organization_name'] ?? "";
    organizationRegisterDate = json['organization_register_Date'] ?? "";
    organizationRegisterNum = json['organization_register_num'] ?? "";
    bidhan = json['bidhan'] ?? "";
    districtnameOfregisteredOrganization =
        json['districtname_ofregistered_organization'] ?? "";
    ambRunningOrgDetail = json['amb_running_org_detail'] ?? "";
    mbRenewDate = json['mb_renew_date'] ?? "";
    panExamin = json['pan_examin'] ?? "";
    bidhanAnya = json['bidhan_anya'] ?? "";
    panNumber = json['pan_number'] ?? "";
    socialWelfare = json['social_welfare'] ?? "";
    dartaNo = json['darta_no'] ?? "";
    totalAmbulance = json['total_ambulance'] ?? "";
    ambRunningOrganizationCatagory =
        json['amb_running_organization_catagory'] ?? "";
    ambDetails = json['amb_details'] ?? "";
    ambDetailsAnya = json['amb_details_anya'] ?? "";
    ambulanceServiceAnya = json['ambulance_service_anya'] ?? "";
    ambCatagoryAnya = json['amb_catagory_anya'] ?? "";
    ambulanceVerified = json['ambulance_verified'] ?? "";
    uniqueId = json['unique_id'] ?? "";
    file1 = json['file1'] ?? "";
    file2 = json['file2'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_operation'] = hospitalOperation;
    data['vehicle_number'] = vehicleNumber;
    data['inactive_vehicle_reason'] = inactiveVehicleReason;
    data['inactive_vehicle_anya'] = inactiveVehicleAnya;
    data['vehicle_cc'] = vehicleCc;
    data['vehicle_type'] = vehicleType;
    data['vehicle_type_anya'] = vehicleTypeAnya;
    data['vehicle_companyname'] = vehicleCompanyname;
    data['deathvehicle_purchase_donation'] = deathvehiclePurchaseDonation;
    data['vehicle_purchase_anya'] = vehiclePurchaseAnya;
    data['vehicle_price'] = vehiclePrice;
    data['vehicle_permission_twoyears'] = vehiclePermissionTwoyears;
    data['gps_connection'] = gpsConnection;
    data['gps_connection_anya'] = gpsConnectionAnya;
    data['death_vehicle_option_two'] = deathVehicleOptionTwo;
    data['death_vehicle_optiontwo_anya'] = deathVehicleOptiontwoAnya;
    data['deathvehicle_number'] = deathvehicleNumber;
    data['vehicle_purchase_date'] = vehiclePurchaseDate;
    data['vehicle_name'] = vehicleName;
    data['vehicle_supplier_name'] = vehicleSupplierName;
    data['vehicle_purchase_type'] = vehiclePurchaseType;
    data['preshan_kendra'] = preshanKendra;
    data['govn_taxoff'] = govnTaxoff;
    data['govn_taxoff_onya'] = govnTaxoffOnya;
    data['ambulance_seen_number'] = ambulanceSeenNumber;
    data['ambulance_contact_num'] = ambulanceContactNum;
    data['ambulance_written'] = ambulanceWritten;
    data['sairen'] = sairen;
    data['sairen_anya'] = sairenAnya;
    data['ambulance_agreement'] = ambulanceAgreement;
    data['amb_coordination_anya'] = ambCoordinationAnya;
    data['ambulance_driver'] = ambulanceDriver;
    data['amb_driver_anya'] = ambDriverAnya;
    data['driver_age'] = driverAge;
    data['driver_training'] = driverTraining;
    data['driver_name_one'] = driverNameOne;
    data['driver_trainingtime_one'] = driverTrainingtimeOne;
    data['training_center_name_one'] = trainingCenterNameOne;
    data['amb_emt_training'] = ambEmtTraining;
    data['driver_name_two'] = driverNameTwo;
    data['driver_trainingtime_two'] = driverTrainingtimeTwo;
    data['training_center_name_two'] = trainingCenterNameTwo;
    data['no_ofdriver'] = noOfdriver;
    data['driver_exp'] = driverExp;
    data['amb_emt'] = ambEmt;
    data['patient_caretaker_insurance'] = patientCaretakerInsurance;
    data['patient_insurance'] = patientInsurance;
    data['patient_family_deal'] = patientFamilyDeal;
    data['patient_handover'] = patientHandover;
    data['deal'] = deal;
    data['customs'] = customs;
    data['hospital_name'] = hospitalName;
    data['ambulance_category'] = ambulanceCategory;
    data['discussion'] = discussion;
    data['remarks'] = remarks;
    data['form_level'] = formLevel;
    data['provinces'] = provinces;
    data['district'] = district;
    data['municipality'] = municipality;
    data['ward_no'] = wardNo;
    data['proceed_to'] = proceedTo;
    data['rejected_by'] = rejectedBy;
    data['rejected_message'] = rejectedMessage;
    data['created_by'] = createdBy;
    data['barga'] = barga;
    data['hospital_id'] = hospitalId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_rejected'] = isRejected;
    data['ambulance_catagory'] = ambulanceCatagory;
    data['driver_insurance'] = driverInsurance;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_post'] = contactPersonPost;
    data['ambulance_service_office'] = ambulanceServiceOffice;
    data['contact_no'] = contactNo;
    data['organization_email'] = organizationEmail;
    data['social_media'] = socialMedia;
    data['website_domain'] = websiteDomain;
    data['ambulance_running_orgcatagory'] = ambulanceRunningOrgcatagory;
    data['ambulance_running_organization_name'] =
        ambulanceRunningOrganizationName;
    data['organization_register_Date'] = organizationRegisterDate;
    data['organization_register_num'] = organizationRegisterNum;
    data['bidhan'] = bidhan;
    data['districtname_ofregistered_organization'] =
        districtnameOfregisteredOrganization;
    data['amb_running_org_detail'] = ambRunningOrgDetail;
    data['mb_renew_date'] = mbRenewDate;
    data['pan_examin'] = panExamin;
    data['bidhan_anya'] = bidhanAnya;
    data['pan_number'] = panNumber;
    data['social_welfare'] = socialWelfare;
    data['darta_no'] = dartaNo;
    data['total_ambulance'] = totalAmbulance;
    data['amb_running_organization_catagory'] = ambRunningOrganizationCatagory;
    data['amb_details'] = ambDetails;
    data['amb_details_anya'] = ambDetailsAnya;
    data['ambulance_service_anya'] = ambulanceServiceAnya;
    data['amb_catagory_anya'] = ambCatagoryAnya;
    data['ambulance_verified'] = ambulanceVerified;
    data['unique_id'] = uniqueId;
    data['file1'] = file1;
    data['file2'] = file2;
    return data;
  }
}

Future<ApiResponse<List<Ambulance>?>> getAmbulanceApi() async {
  // try {
  var headers = {
    "Accept": "application/json",
    "Authorization": "Bearer ${Get.find<AuthController>().users!.apiToken}"
  };

  var response =
      await http.get(Uri.parse(ApiUrls.adminAmbulanceList), headers: headers);
  if (response.statusCode == 200) {
    var mapResponse = json.decode(response.body);
    if (mapResponse["success"]) {
      var data = mapResponse["data"].cast<Map<String, dynamic>>();
      List<Ambulance> ambulanceList = await data.map<Ambulance>((json) {
        return Ambulance.fromJson(json);
      }).toList();
      return ApiResponse(
          mapResponse["success"], mapResponse["message"], ambulanceList);
    } else {
      return ApiResponse(mapResponse["success"], mapResponse["message"], null);
    }
  } else {
    return ApiResponse(false, response.reasonPhrase!, null);
  }
  // } catch (e) {
  //   return ApiResponse(false, e.toString(), null);
  // }
}
