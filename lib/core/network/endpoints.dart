class Endpoints {
  final String baseUrl;
  Endpoints({required this.baseUrl});

  static String version = "api/v3";
  String get baseEndpoint => "$baseUrl/$version";

  String get pet => "$baseEndpoint/pet";
}
