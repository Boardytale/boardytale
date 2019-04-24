part of model;

@JsonSerializable()
class LoggerMessage {
  LoggerMessageType message;
  String content;
  String gameId;

  LoggerMessage();

  Map<String, dynamic> toJson() {
    return _$LoggerMessageToJson(this);
  }

  static LoggerMessage fromJson(Map<String, dynamic> json) => _$LoggerMessageFromJson(json);

  // ---

  Tale get getTaleDataMessage => Tale.fromJson(json.decode(content));

  factory LoggerMessage.fromTaleData(Tale data) {
    return LoggerMessage()
      ..message = LoggerMessageType.initial
      ..content = json.encode(data.toJson());
  }


  TaleUpdate get getTaleUpdateMessage => TaleUpdate.fromJson(json.decode(content));

  factory LoggerMessage.fromTaleUpdate(TaleUpdate data) {
    return LoggerMessage()
      ..message = LoggerMessageType.taleUpdate
      ..content = json.encode(data.toJson());
  }
}

@Typescript()
enum LoggerMessageType {
@JsonValue('initial')
initial,
@JsonValue('taleUpdate')
taleUpdate,
}
