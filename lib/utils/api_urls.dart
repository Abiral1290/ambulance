class ApiUrls {
  static String mainUrl = "http://202.52.240.148:8095/ams/api/";
  static String storageUrl = "http://202.52.240.148:8095/ams/public/";

  static String login = mainUrl + "login";
  static String logout = mainUrl + "logout"; //post
  static String register = mainUrl + "register"; //post
  static String changePassword = mainUrl + "change_password"; //post
  static String profile = mainUrl + "get_profile";

  // driver
  static String driverAttributes = mainUrl + "driver_attributes";
  static String address = mainUrl + "address";
  static String hospitals = mainUrl + "hospitals";

  // traffic
  static String trafficCheckList =
      mainUrl + "traffic_ambulance_checklists"; //post

  // admin
  static String adminAmbulanceList = mainUrl + "admin_ambulance_checklists";
  static String adminChecklist = mainUrl + "admin_ambulance_checklists"; //post

  // deviceList
  static String ambulanceList = mainUrl + "get_ambulance_lists"; //post
  static String individualDevice = mainUrl + "get_device_location"; //post

  // vehicle request
  static String vehicleRequest = mainUrl + "requests"; //post
  static String vehicleResponse = mainUrl + "response"; //post
}
