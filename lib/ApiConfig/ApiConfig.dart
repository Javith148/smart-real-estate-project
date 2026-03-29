class ApiConfig {
  static const String baseUrl = "https://9638-2401-4900-93da-6d70-cdd0-f781-4239-d2f3.ngrok-free.app";

  static String getImage(String path) {
    return "$baseUrl$path";
  }

  static String getApi(String endpoint) {
    return "$baseUrl$endpoint";
  }
}