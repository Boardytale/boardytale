part of model;

@Typescript()
@JsonSerializable()
class Race {
  Races id;
  Map<Lang,String> name;

  static fromJson(Map data){
    return _$RaceFromJson(data);
  }

  Map toJson(){
    return _$RaceToJson(this);
  }
}

@Typescript()
enum Races {
@JsonValue('human')
human,
@JsonValue('undead')
undead,
@JsonValue('gultam')
gultam,
@JsonValue('elf')
elf,
@JsonValue('animal')
animal
}

