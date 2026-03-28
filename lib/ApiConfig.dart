class ApiConfig {
  static const String baseUrl = "http://192.168.68.103:8000";

  static String getImage(String path) {
    return "$baseUrl$path";
  }

  static String getApi(String endpoint) {
    return "$baseUrl$endpoint";
  }
}