part of configuration;

@JsonSerializable()
@GenerateTypescript()
class DatabaseConfiguration {
  String username;
  String password;
  String host;
  num port;
  String databaseName;

  static fromJson(Map<String, dynamic> json) {
    return _$DatabaseConfigurationFromJson(json);
  }
}

@JsonSerializable()
@GenerateTypescript()
class ServerConfiguration {
  // use load balancing (uris) if uri is null
  String uri;
  List<String> uris;

  // route is not used if there is not public api
  String route;
  String innerRoute;

  static ServerConfiguration fromJson(Map<String, dynamic> json) {
    return _$ServerConfigurationFromJson(json);
  }
}

@JsonSerializable()
@GenerateTypescript()
class FrontEndDevelopment {
  bool active;
  String route;
  String proxyPass;

  static fromJson(Map<String, dynamic> json) {
    return _$FrontEndDevelopmentFromJson(json);
  }
}

@JsonSerializable()
@GenerateTypescript()
class BoardytaleConfiguration {
  ServerConfiguration gameServer;
  ServerConfiguration editorServer;
  DatabaseConfiguration editorDatabase;
  ServerConfiguration userService;
  DatabaseConfiguration userDatabase;
  ServerConfiguration aiService;
  FrontEndDevelopment gameStaticDev;
  FrontEndDevelopment editorStaticDev;

  static fromJson(Map<String, dynamic> json) {
    return _$BoardytaleConfigurationFromJson(json);
  }
}
