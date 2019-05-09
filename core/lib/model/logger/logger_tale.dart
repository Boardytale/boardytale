part of model;

@JsonSerializable()
class LoggerTale{
  Tale initial;
  List<TaleUpdate> updates = [];
  List<String> trace = [];

  Map<String, dynamic> toJson() {
    return _$LoggerTaleToJson(this);
  }

  static LoggerTale fromJson(Map<String, dynamic> json) => _$LoggerTaleFromJson(json);

}
