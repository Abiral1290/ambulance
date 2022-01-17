import 'dart:io';

import 'package:ambulance_nepal/driver/driver.dart';
import 'package:ambulance_nepal/driver/driver_controller.dart';
import 'package:ambulance_nepal/hospitals/hospitals.dart';
import 'package:ambulance_nepal/hospitals/hospitals_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:ambulance_nepal/widget/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

// ignore: must_be_immutable
class DriverRegisterPage extends StatelessWidget {
  DriverRegisterPage({Key? key}) : super(key: key);

  Driver driver = Driver();
  final ImagePicker _picker = ImagePicker();

  var driverController = Get.put(DriverController());
  var hospitalController = Get.put(HospitalsController());

  late var provinceList = Get.find<DriverController>().provinceList.obs;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _wardNoController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();

  var age = "".obs;
  var dob = "Select DOB".obs;
  var driverImage = "Tap to add photo".obs;
  var licenseImage = "Tap to add license".obs;
  var trainingImage = "Tap to add registration image".obs;

  bool isProvinceSelected = false;

  bool validateRequired() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _licenseNumberController.text.isNotEmpty &&
        _wardNoController.text.isNotEmpty &&
        dob.value != "Select DOB" &&
        driverImage.value != "Tap to add photo" &&
        licenseImage.value != "Tap to add license" &&
        trainingImage.value != "Tap to add registration image";
  }

  bool validateNumber() {
    return _phoneController.text.isPhoneNumber &&
        _phoneController.text.length == 10;
  }

  bool validateEmail() {
    return _emailController.text.isEmail;
  }

  bool validateDob() {
    var diffInYears = ((picker.NepaliDateTime.parse(dob.value))
            .difference(picker.NepaliDateTime.now())
            .inDays
            .abs()) /
        365;
    if (diffInYears > 24) {
      return true;
    } else {
      return false;
    }
  }

  pickImage(String type, ImageSource source) async {
    switch (type) {
      case "LICENSE":
        XFile? licenseFile =
            await _picker.pickImage(source: source, imageQuality: 30);
        licenseImage.value = licenseFile!.path;
        break;

      case "TRAINING":
        XFile? trainingFile =
            await _picker.pickImage(source: source, imageQuality: 30);
        trainingImage.value = trainingFile!.path;
        break;

      case "DRIVER":
        XFile? driverFile =
            await _picker.pickImage(source: source, imageQuality: 30);
        driverImage.value = driverFile!.path;
        break;

      default:
    }
  }

  InputDecoration decoration(String label, {Icon? icon}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      labelText: label,
      prefixIcon: icon ?? const Icon(Icons.circle),
    );
  }

  Driver assignValue() {
    Driver driver = Driver();
    driver.name = _nameController.text;
    driver.email = _emailController.text;
    driver.phone = _phoneController.text;
    driver.addressId = Get.find<DriverController>().selectedAreaId.toString();
    driver.address = _addressController.text;
    driver.wodaNo = _wardNoController.text;
    driver.hospitalId =
        Get.find<HospitalsController>().selectedHospital!.id.toString();
    driver.dob = dob.value;
    driver.driverPhoto = Utilities.encodeToBase64(File(driverImage.value));
    driver.licenceNumber = _licenseNumberController.text;
    driver.licencePhoto = Utilities.encodeToBase64(File(licenseImage.value));
    driver.trainingCertificate =
        Utilities.encodeToBase64(File(trainingImage.value));
    driver.userType = Constants.loginType;
    return driver;
  }

  Widget _driverImage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            pickImage("DRIVER", ImageSource.gallery);
          },
          child: Obx(
            () => driverImage.value.contains("Tap")
                ? CircleAvatar(
                    minRadius: 50,
                    maxRadius: 60,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                    backgroundColor: Constants.color,
                  )
                : CircleAvatar(
                    minRadius: 50,
                    maxRadius: 60,
                    backgroundImage: FileImage(
                      File(driverImage.value),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _fullNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: TextField(
        controller: _nameController,
        decoration: decoration("Full Name", icon: const Icon(Icons.person)),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: TextField(
        controller: _emailController,
        decoration: decoration("Email", icon: const Icon(Icons.email)),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: TextField(
        controller: _phoneController,
        decoration: decoration("Phone", icon: const Icon(Icons.phone)),
        maxLength: 10,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildHospitalDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: InputDecorator(
        decoration: decoration("Hospital"),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Hospitals>(
              iconEnabledColor: Colors.green,
              iconDisabledColor: Colors.red,
              isDense: true,
              isExpanded: true,
              hint: Text(Get.find<HospitalsController>()
                  .selectedHospital!
                  .hospitalName!),
              items: Get.find<HospitalsController>().hospitalList.map((e) {
                return DropdownMenuItem<Hospitals>(
                    value: e, child: Text(e.hospitalName!));
              }).toList(),
              onChanged: (hospitals) {
                Get.find<HospitalsController>().setSelectedHospital(hospitals!);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: InputDecorator(
        decoration: decoration("Province"),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconEnabledColor: Colors.green,
              iconDisabledColor: Colors.red,
              isDense: true,
              isExpanded: true,
              hint: Text(Get.find<DriverController>().selectedProvince),
              items: Get.find<DriverController>().provinceList.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              onChanged: (province) {
                isProvinceSelected = true;
                Get.find<DriverController>().setSelectedProvince(province!);
                Get.find<DriverController>().getDistrictList(province);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistrictDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: InputDecorator(
        decoration: decoration("District"),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconEnabledColor: Colors.green,
              iconDisabledColor: Colors.red,
              isDense: true,
              isExpanded: true,
              hint: Text(Get.find<DriverController>().selectedDistrict),
              items: Get.find<DriverController>().districtList.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              onChanged: (district) {
                Get.find<DriverController>().setSelectedDistrict(district!);
                Get.find<DriverController>().getAreaList(district);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAreaDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: InputDecorator(
        decoration: decoration("Area"),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconEnabledColor: Colors.green,
              iconDisabledColor: Colors.red,
              isDense: true,
              isExpanded: true,
              hint: Text(Get.find<DriverController>().selectedArea),
              items: Get.find<DriverController>().areaList.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              onChanged: (area) {
                Get.find<DriverController>().setSelectedArea(area!);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressField() {
    return SizedBox(
      width: Get.size.width * 0.5,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
        child: TextField(
          controller: _addressController,
          decoration: decoration("Address",
              icon: const Icon(Icons.location_city_rounded)),
        ),
      ),
    );
  }

  Widget _wardNoField() {
    return SizedBox(
      width: Get.size.width * 0.35,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
        child: TextField(
          controller: _wardNoController,
          decoration: decoration("Ward No",
              icon: const Icon(Icons.location_city_rounded)),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget _dobSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: SizedBox(
        height: Get.size.height * 0.07,
        width: Get.size.width,
        child: InkWell(
          onTap: () async {
            picker.NepaliDateTime? selectedDateTime =
                await picker.showAdaptiveDatePicker(
              context: context,
              initialDate: picker.NepaliDateTime.now()
                  .subtract(const Duration(days: 9125)),
              firstDate: picker.NepaliDateTime(1970),
              lastDate: picker.NepaliDateTime(picker.NepaliDateTime.now().year),
              language: picker.Language.nepali,
            );

            if (selectedDateTime != null) {
              print(selectedDateTime);
              var dateTime = selectedDateTime.toString();
              dob.value = dateTime;
            }
          },
          child: InputDecorator(
            decoration: decoration("DOB", icon: const Icon(Icons.date_range)),
            child: Obx(() {
              return Text(
                dob.value.split(" ").first,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _licenseNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
      child: TextField(
        controller: _licenseNumberController,
        decoration: decoration("License Number",
            icon: const Icon(Icons.confirmation_number)),
      ),
    );
  }

  Widget _licenseImage() {
    return InkWell(
      onTap: () {
        pickImage("LICENSE", ImageSource.gallery);
      },
      child: SizedBox(
        height: Get.size.height * 0.2,
        width: Get.size.width * 0.35,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Obx(() {
            return licenseImage.value.contains("Tap")
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(licenseImage.value)),
                  )
                : Image.file(File(licenseImage.value));
          }),
        ),
      ),
    );
  }

  Widget _trainingImage() {
    return InkWell(
      onTap: () {
        pickImage("TRAINING", ImageSource.gallery);
      },
      child: SizedBox(
        height: Get.size.height * 0.2,
        width: Get.size.width * 0.35,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Obx(() {
            return trainingImage.value.contains("Tap")
                ? Padding(
                    padding: const EdgeInsets.all(Constants.verticalPadding),
                    child: Center(child: Text(trainingImage.value)),
                  )
                : Image.file(File(trainingImage.value));
          }),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());

            if (validateRequired()) {
              if (validateNumber()) {
                if (validateEmail()) {
                  if (validateDob()) {
                    Driver driver = assignValue();
                    print(driver);
                    Get.to(() => PasswordField(user: driver));
                  } else {
                    Utilities.showToast(
                        "You must be greater than 25 years to register as driver",
                        toastType: ToastType.error);
                  }
                } else {
                  Utilities.showToast("Email is not valid",
                      toastType: ToastType.error);
                }
              } else {
                Utilities.showToast("Phone number is not in valid format",
                    toastType: ToastType.error);
              }
            } else {
              Utilities.showToast("All Fields are required",
                  toastType: ToastType.error);
            }
          },
          child: const Text("Next"),
          color: Constants.color,
          height: Get.size.height * 0.05,
          minWidth: Get.size.width,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          Text(
            "Register Driver",
            style: TextStyle(color: Constants.color),
          ),
          color: Constants.color,
        ),
        body: GetBuilder<DriverController>(builder: (builder) {
          return Get.find<DriverController>().provinceList.isEmpty &&
                  Get.find<HospitalsController>().hospitalList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Scrollbar(
                  hoverThickness: 10.0,
                  isAlwaysShown: true,
                  thickness: 10.0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _driverImage(),
                          _fullNameField(),
                          _emailField(),
                          _phoneField(),
                          _buildHospitalDropdown(),
                          _buildProvinceDropdown(),
                          _buildDistrictDropdown(),
                          _buildAreaDropdown(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [_addressField(), _wardNoField()],
                          ),
                          _dobSelector(context),
                          _licenseNumberField(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [_licenseImage(), _trainingImage()],
                          ),
                          _nextButton(context),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }
}
