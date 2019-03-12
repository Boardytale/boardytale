library client_model;

import 'dart:math';
import 'dart:async';
import 'package:game_client/src/services/settings_service.dart';
import 'package:shared/model/model.dart' as shared;
import 'package:stagexl/stagexl.dart' as stageLib;
import 'package:utils/utils.dart';
import 'package:angular/core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:fff/parser.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';

part 'package:game_client/src/game_model/field.dart';
part 'package:game_client/src/game_model/hexa_borders.dart';
part 'package:game_client/src/game_model/client_unit.dart';
part 'package:game_client/src/game_model/client_tale_service.dart';
part 'package:game_client/src/game_model/client_world_service.dart';
part 'package:game_client/src/game_model/player.dart';
