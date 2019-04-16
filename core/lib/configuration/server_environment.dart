part of configuration;

@JsonSerializable()
@Typescript()
class Uri {
  String host;
  num port;

  Map toJson() {
    return _$UriToJson(this);
  }

  static Uri fromJson(Map<String, dynamic> json) {
    return _$UriFromJson(json);
  }
}

@JsonSerializable()
@Typescript()
class DatabaseConfiguration {
  String username;
  String password;
  String host;
  int port;
  String databaseName;

  Map toJson() {
    return _$DatabaseConfigurationToJson(this);
  }

  static fromJson(Map<String, dynamic> json) {
    return _$DatabaseConfigurationFromJson(json);
  }
}

@JsonSerializable()
@Typescript()
class ServerConfiguration {
  List<Uri> uris;
  @TypescriptOptional()
  int innerPort;
  String route;
  String pathToExecutable;
  String pathToWorkingDirectory;
  ExecutableType executableType;

  Map toJson() {
    return _$ServerConfigurationToJson(this);
  }

  static ServerConfiguration fromJson(Map<String, dynamic> json) {
    return _$ServerConfigurationFromJson(json);
  }
}

@JsonSerializable()
@Typescript()
class FrontEndDevelopment {
  bool active;
  num port;
  String route;

  Map toJson() {
    return _$FrontEndDevelopmentToJson(this);
  }

  static fromJson(Map<String, dynamic> json) {
    return _$FrontEndDevelopmentFromJson(json);
  }
}

@JsonSerializable()
@Typescript()
class BoardytaleConfiguration {
  ServerConfiguration gameServer;
  ServerConfiguration editorServer;
  DatabaseConfiguration userDatabase;
  DatabaseConfiguration editorDatabase;
  ServerConfiguration userServer;
  ServerConfiguration heroesServer;
  ServerConfiguration aiServer;
  ServerConfiguration proxyServer;
  FrontEndDevelopment gameStaticDev;
  FrontEndDevelopment editorStaticDev;

  Map toJson() {
    return _$BoardytaleConfigurationToJson(this);
  }

  static fromJson(Map<String, dynamic> json) {
    return _$BoardytaleConfigurationFromJson(json);
  }
}

@Typescript()
enum ExecutableType {
  @JsonValue('ts-node')
  tsNode,
  @JsonValue('js')
  js,
  @JsonValue('dart')
  dart,
}
