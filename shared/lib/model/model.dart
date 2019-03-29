library model;

import "dart:math" as Math;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:typescript_reporter/typescript_reporter.dart';
import 'package:utils/utils.dart' as utils;
import 'package:rxdart/rxdart.dart';
import 'package:fff/parser.dart';

part 'package:shared/model/image.dart';

part 'package:shared/model/user.dart';

part "package:shared/model/lang.dart";

part 'package:shared/model/buff.dart';

part 'package:shared/model/triggers.dart';

part 'package:shared/model/ai_instruction.dart';

part 'package:shared/model/race.dart';

part 'package:shared/model/alea.dart';

part 'package:shared/model/player.dart';

part 'package:shared/model/unit/unit.dart';

part 'package:shared/model/unit/unit_create_or_update_action.dart';

part 'package:shared/model/unit/unit_type.dart';

part 'package:shared/model/unit/hero.dart';

part 'package:shared/model/map/field.dart';

part 'package:shared/model/map/world.dart';

part 'package:shared/model/map/stage_geometry.dart';

part 'package:shared/model/map/map_utils.dart';

part 'package:shared/model/tale/tale.dart';

part 'package:shared/model/tale/tale_create_envelope.dart';

part 'package:shared/model/tale/lobby_tale.dart';

part 'package:shared/model/tale/client_tale_data.dart';

part 'package:shared/model/game/state.dart';

part 'package:shared/model/game/to_client_messages.dart';

part 'package:shared/model/game/to_game_server_messages.dart';

part 'package:shared/model/game/to_hero_server_message.dart';

part 'package:shared/model/game/to_ai_server_message.dart';

part "package:shared/model/abilities/ability.dart";

part "package:shared/model/abilities/move.dart";

part "package:shared/model/abilities/attack.dart";

part 'package:shared/model/abilities/targets.dart';

part 'package:shared/model/map/track.dart';

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
