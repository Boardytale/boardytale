part of model;

@Typescript()
@JsonSerializable()
class LobbyTale {
  String id;
  Map<Lang, String> name;
  Map<Lang, String> description;
  // 100 × 100 px  base64 jpg or png
  String image;

  static LobbyTale fromJson(Map json) {
    return _$LobbyTaleFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$LobbyTaleToJson(this);
  }
}


