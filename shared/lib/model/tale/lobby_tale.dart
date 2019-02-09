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

  Map<String, dynamic> toJson(){
    return _$LobbyTaleToJson(this);
  }
}

class OpenedLobby extends LobbyTale{
  List<LobbyPlayer> players = [];

  static OpenedLobby fromJson(Map json) {
    return _$LobbyTaleFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$LobbyTaleToJson(this);
  }
}
