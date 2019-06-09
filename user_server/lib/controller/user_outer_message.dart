import 'dart:async';
import 'dart:convert';

import 'package:core/model/model.dart' as core;
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:user_server/model/db_objects.dart';
import 'package:http/http.dart' as http;
import 'package:user_server/model/heroes.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class UserOuterMessageController extends ResourceController {
  UserOuterMessageController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> toUserMessage(@Bind.body() ToUserServerMessageWrap messageWrap) async {
    core.ToUserServerMessage message = messageWrap.message;
    if (message.message == core.OnUserServerAction.getHeroesToCreate) {
      message.addHeroes(heroesData);
    }
    if (message.message == core.OnUserServerAction.createHero) {
      core.CreateHero heroToCreate = message.getCreateHeroMessage;
      var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
      User user = await query.fetchOne();
      if (user != null) {
        List<core.GameHeroCreateEnvelope> heroEnvelope = heroesData.where((hero) {
          return hero.type.name == heroToCreate.typeName;
        }).toList();

        if (heroEnvelope.isEmpty) {
          return Response.badRequest(body: "something wrong with data - probably not existing type name");
        }

        core.GameHeroCreateEnvelope copyOfHeroEnvelope = core.GameHeroCreateEnvelope.fromJson(heroEnvelope.first.toJson());
        copyOfHeroEnvelope.name = heroToCreate.name;

        Hero newHero = Hero()
          ..level = 0
          ..user = user
          ..dataFormatVersion = 0
          ..heroData = Document(copyOfHeroEnvelope.toJson());
        newHero = await (Query<Hero>(context)..values = newHero).insert();
        message.addHero(copyOfHeroEnvelope);
      }
      else{
        return Response.badRequest(body: {"message": "bad inner token"});
      }
    }
    if (message.message == core.OnUserServerAction.getMyHeroes) {
      var query = Query<User>(context)..where((u) => u.innerToken).equalTo(message.getUser.innerToken);
      User user = await query.fetchOne();
      if (user != null) {
        var heroesQuery = Query<Hero>(context)..where((hero) => hero.user.id).equalTo(user.id);

        List<Hero> heroesData = await heroesQuery.fetch();
        message.addHeroesOfPlayer(heroesData.map((Hero heroData){
          return core.GameHeroCreateEnvelope.fromJson(heroData.heroData.data as Map<String, dynamic>);
        }).toList());
      }
      else{
        return Response.badRequest(body: {"message": "bad inner token"});
      }
    }
    return Response.ok(messageWrap.asMap());
  }
}
