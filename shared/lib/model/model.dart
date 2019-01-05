library model;

import "dart:math" as Math;
import 'package:json_annotation/json_annotation.dart';
import 'package:typescript_reporter/typescript_reporter.dart';


part 'image.dart';
part 'user.dart';
part 'unit.dart';
part 'unit_type.dart';
part 'race.dart';
part 'track.dart';
part 'field.dart';
part 'world.dart';
part 'alea.dart';
part 'player.dart';
part 'tale/tale.dart';
part 'tale/tale_create_envelope.dart';
part 'tale/lobby_tale.dart';
part "lang.dart";
part 'buff.dart';
part 'targets.dart';
part 'settings.dart';
part 'stage_geometry.dart';
part 'resources.dart';
part "abilities/ability.dart";
part "abilities/move.dart";
part "abilities/raise.dart";
part "abilities/teleport.dart";
part "abilities/attack.dart";
part "abilities/shoot.dart";
part "abilities/change_type.dart";
part "abilities/heal.dart";
part "abilities/revive.dart";
part "abilities/regeneration.dart";
part "abilities/boost.dart";
part "abilities/hand_heal.dart";
part "abilities/linked_move.dart";
part "abilities/summon.dart";
part "abilities/step_shoot.dart";
part "abilities/dismiss.dart";
part "abilities/dark_shoot.dart";
part "abilities/light.dart";
part 'services/unit_service.dart';
part 'services/platform_service.dart';
part 'services/player_service.dart';
part 'services/game_service.dart';
part 'services/instance_generator.dart';

part 'model.g.dart';

Settings settings;

void setSettings(Settings input) {
  settings = input;
}
