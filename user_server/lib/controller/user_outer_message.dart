import 'dart:async';
import 'package:core/model/model.dart' as core;
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/controller/user_utils/user_utils.dart';
import 'package:user_server/model/heroes.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class UserOuterMessageController extends ResourceController {
  UserOuterMessageController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> toUserMessage(@Bind.body() ToUserServerMessageWrap messageWrap) async {
    core.ToUserServerMessage message = messageWrap.message;
    if(message.message == core.OnUserServerAction.updateUser){
      return updateUser(message, context);
    }
    if (message.message == core.OnUserServerAction.getHeroesToCreate) {
      message.addHeroes(heroesData.map((envelope){
        return envelope.gameHeroEnvelope;
      }).toList());
      return Response.ok(messageWrap.asMap());
    }
    if (message.message == core.OnUserServerAction.createHero) {
      return createHero(message, context);
    }
    if (message.message == core.OnUserServerAction.getMyHeroes) {
      return getMyHeroes(message, context);
    }
    if (message.message == core.OnUserServerAction.getHeroDetail) {
      return getMyHeroDetail(message, context);
    }
    return Response.forbidden(body: "${message.message} is not handled");
  }
}
