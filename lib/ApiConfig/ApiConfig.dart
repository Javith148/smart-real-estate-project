class ApiConfig {
  static const String baseUrl = "https://e641-2405-201-e017-9148-fc97-893e-eaa6-4cb9.ngrok-free.app/";

  static String getImage(String path) {
    return "$baseUrl$path";
  }

  static String getApi(String endpoint) {
    return "$baseUrl$endpoint";
  }
}