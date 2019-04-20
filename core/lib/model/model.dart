library model;

import "dart:math" as Math;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:typescript_reporter/typescript_reporter.dart';
import 'package:utils/utils.dart' as utils;
import 'package:rxdart/rxdart.dart';
import 'package:fff/parser.dart';

part 'package:core/model/image.dart';

part 'package:core/model/user.dart';

part "package:core/model/lang.dart";

part 'package:core/model/buff.dart';

part 'package:core/model/triggers.dart';

part 'package:core/model/ai_instruction.dart';

part 'package:core/model/race.dart';

part 'package:core/model/alea.dart';

part 'package:core/model/player.dart';

part 'package:core/model/unit/unit.dart';

part 'package:core/model/unit/unit_create_or_update_action.dart';

part 'package:core/model/unit/unit_type.dart';

part 'package:core/model/unit/hero.dart';

part 'package:core/model/map/field.dart';

part 'package:core/model/map/world.dart';

part 'package:core/model/map/stage_geometry.dart';

part 'package:core/model/map/map_utils.dart';

part 'package:core/model/tale/tale.dart';

part 'package:core/model/tale/tale_create_envelope.dart';

part 'package:core/model/tale/lobby_tale.dart';

part 'package:core/model/game/state.dart';

part 'package:core/model/game/to_client_messages.dart';

part 'package:core/model/game/to_game_server_messages.dart';

part 'package:core/model/game/to_hero_server_message.dart';

part 'package:core/model/game/to_ai_server_message.dart';

part 'package:core/model/game/to_user_server_message.dart';

part 'package:core/model/logger/logger_message.dart';

part 'package:core/model/logger/logger_tale.dart';

part "package:core/model/abilities/ability.dart";

part "package:core/model/abilities/move.dart";

part "package:core/model/abilities/attack.dart";

part 'package:core/model/abilities/targets.dart';

part 'package:core/model/map/track.dart';

//part "abilities/raise.dart";
//part "abilities/teleport.dart";
//part "abilities/shoot.dart";
//part "abilities/change_type.dart";
//part "abilities/heal.dart";
//part "abilities/revive.dart";
//part "abilities/regeneration.dart";
//part "abilities/boost.dart";
//part "abilities/hand_heal.dart";
//part "abilities/linked_move.dart";
//part "abilities/summon.dart";
//part "abilities/step_shoot.dart";
//part "abilities/dismiss.dart";
//part "abilities/dark_shoot.dart";
//part "abilities/light.dart";

part 'model.g.dart';

class SimpleLogger {
  String log = "";
}
