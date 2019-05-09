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


  TaleUpdate get getTaleUpdateMessage{
    try{
      return TaleUpdate.fromJson(json.decode(content));
    }catch(e){
      throw "cannot decode \"${content} $e\"";
    }
  }

  factory LoggerMessage.fromTaleUpdate(TaleUpdate data) {
    return LoggerMessage()
      ..message = LoggerMessageType.taleUpdate
      ..content = json.encode(data.toJson());
  }

  TaleUpdate get trace => TaleUpdate.fromJson(json.decode(content));

  factory LoggerMessage.fromTrace(String data) {
    return LoggerMessage()
      ..message = LoggerMessageType.trace
      ..content = data;
  }
}

@Typescript()
enum LoggerMessageType {
@JsonValue('initial')
initial,
@JsonValue('taleUpdate')
taleUpdate,
@JsonValue('trace')
trace,
}
