//part of inner;
//
//@JsonSerializable()
//class ToAiServerMessage {
//  OnAiServerAction message;
//  String content;
//
//  ToAiServerMessage();
//
//  Map<String, dynamic> toJson() {
//    return _$ToAiServerMessageToJson(this);
//  }
//
//  static ToAiServerMessage fromJson(Map<String, dynamic> json) => _$ToAiServerMessageFromJson(json);
//
//  // ---
//
//  GetNextMoveByState get getNextMoveByState => GetNextMoveByState.fromJson(json.decode(content));
//
//  void addActionToByStateResponse(shared.UnitTrackAction action) {
//    content = json.encode(getNextMoveByState..responseAction = action);
//  }
//
//  factory ToAiServerMessage.fromState(shared.InitialTaleData state, shared.AiEngine engine, String idOfAiPlayerOnMove) {
//    return ToAiServerMessage()
//      ..message = OnAiServerAction.getNextMoveByState
//      ..content = json.encode((GetNextMoveByState()
//        ..requestData = state
//        ..idOfAiPlayerOnMove = idOfAiPlayerOnMove
//        ..requestEngine = engine)
//          .toJson());
//  }
//
//  // ---
//
//  GetNextMoveByUpdate get getNextMoveByUpdate => GetNextMoveByUpdate.fromJson(json.decode(content));
//
//  void addActionToByUpdateResponse(shared.UnitTrackAction action) {
//    content = json.encode(getNextMoveByUpdate..responseAction = action);
//  }
//
//  factory ToAiServerMessage.fromUpdate(shared.UnitCreateOrUpdate update) {
//    return ToAiServerMessage()
//      ..message = OnAiServerAction.getNextMoveByUpdate
//      ..content = json.encode((GetNextMoveByUpdate()..requestUpdateData = update).toJson());
//  }
//
//// ---
//}
//
//@Typescript()
//enum OnAiServerAction {
//@JsonValue('getNextMoveByState')
//getNextMoveByState,
//@JsonValue('getNextMoveByUpdate')
//getNextMoveByUpdate,
//}
//
//@JsonSerializable()
//class GetNextMoveByState extends shared.MessageContent {
//  shared.UnitTrackAction responseAction;
//  shared.InitialTaleData requestData;
//  shared.AiEngine requestEngine;
//  String idOfAiPlayerOnMove;
//
//  static GetNextMoveByState fromJson(Map<String, dynamic> json) => _$GetNextMoveByStateFromJson(json);
//
//  Map<String, dynamic> toJson() {
//    return _$GetNextMoveByStateToJson(this);
//  }
//}
//
//@JsonSerializable()
//class GetNextMoveByUpdate extends shared.MessageContent {
//  shared.UnitTrackAction responseAction;
//  shared.UnitCreateOrUpdate requestUpdateData;
//
//  static GetNextMoveByUpdate fromJson(Map<String, dynamic> json) => _$GetNextMoveByUpdateFromJson(json);
//
//  Map<String, dynamic> toJson() {
//    return _$GetNextMoveByUpdateToJson(this);
//  }
//}
