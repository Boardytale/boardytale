part of model;

@Typescript()
@JsonSerializable()
class LobbyTale {
  String id;
  Map<Lang, String> name;
  Map<Lang, String> description;
  // 100 × 100 px  base64 jpg or png
  Image image;

  static LobbyTale fromJson(Map json) {
    return _$LobbyTaleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LobbyTaleToJson(this);
  }
}

@Typescript()
@JsonSerializable()
class OpenedLobby extends LobbyTale {
  String lobbyName;
  List<LobbyPlayer> players = [];

  static OpenedLobby fromLobbyTale(LobbyTale tale) {
    return OpenedLobby()
      ..id = tale.id
      ..name = tale.name
      ..image = tale.image
      ..description = tale.description;
  }

  static OpenedLobby fromJson(Map json) {
    return _$OpenedLobbyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OpenedLobbyToJson(this);
  }
}
