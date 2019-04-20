part of model;

@JsonSerializable()
class LoggerTale{
  Tale initial;

  Map<String, dynamic> toJson() {
    return _$LoggerTaleToJson(this);
  }

  static LoggerTale fromJson(Map<String, dynamic> json) => _$LoggerTaleFromJson(json);

}
