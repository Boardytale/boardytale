library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared/model/model.dart' as shared;

@Injectable()
class GameService {
  final SettingsService settings;
  final AppService appService;
  final GatewayService gatewayService;
  BehaviorSubject<bool> showCoordinateLabels = BehaviorSubject<bool>(seedValue: false);
  Map<String, shared.AiGroup> aiGroups = {};
  BehaviorSubject<shared.World> onTaleLoaded = BehaviorSubject();
  BehaviorSubject<List<ClientPlayer>> playersOnMove = BehaviorSubject(seedValue: null);

  ReplaySubject<EnhancedUnitCreateOrUpdateAction> unitCreateOrUpdateAction = ReplaySubject();
  BehaviorSubject<shared.Banter> currentBanter = BehaviorSubject();
  List<shared.Banter> _banterQueue = [];
  shared.Assets assets;
  Map<String, ClientField> fields = {};
  BehaviorSubject<Null> onDimensionsChanged = BehaviorSubject();
  BehaviorSubject<ClientAbility> onUnitAssistanceChanged = BehaviorSubject();

  List<String> startingFieldIds = [];
  String taleName;
  Map<shared.Lang, Map<String, String>> langs;
  Map<shared.Lang, String> langName;
  Map<String, ClientPlayer> aiPlayers = {};
  Map<String, shared.Event> events = {};
  Map<String, shared.Dialog> dialogs = {};
  Map<String, shared.Unit> units = {};
  Map<String, shared.UnitType> unitTypes = {};

  ClientPlayer get currentPlayer => appService.currentPlayer;

  ClientWorldParams worldParams = ClientWorldParams();

  GameService(this.gatewayService, this.settings, this.appService) {
    gatewayService.handlers[shared.OnClientAction.taleData] = handleTaleData;
    gatewayService.handlers[shared.OnClientAction.showBanter] = handleShowBanter;
    gatewayService.handlers[shared.OnClientAction.unitCreateOrUpdate] = (shared.ToClientMessage message) {
      var action = message.getUnitCreateOrUpdate;
      setPlayersOnMoveByIds(action.playerOnMoveIds);
      unitsCreateOrUpdate(action.actions);
    };
    worldParams.defaultHex = HexaBorders(this);
  }

  void handleShowBanter(shared.ToClientMessage message) {
    addBanter(message.getBanter);
  }

  void addBanter(shared.Banter banter) {
    if (banter == null) {
      if (_banterQueue.isNotEmpty) {
        addBanter(_banterQueue.removeAt(0));
      }
      return;
    }
    if (currentBanter.value == null) {
      currentBanter.add(banter);
      Future.delayed(Duration(milliseconds: banter.milliseconds)).then((_) {
        currentBanter.add(null);
        addBanter(null);
      });
    } else {
      _banterQueue.add(banter);
    }
  }

  void setPlayersOnMoveByIds(Iterable<String> ids) {
    // TODO: optimization - handle identical player set
    if (ids == null) {
      playersOnMove.add(null);
    } else {
      playersOnMove.add(ids.map((String playerId) {
        return appService.players[playerId];
      }).toList());
    }
  }

  void recalculate() {
    worldParams.recalculate(settings);
    fields.forEach((k, v) => v.recalculate());
    onDimensionsChanged.add(null);
  }

  void handleTaleData(shared.ToClientMessage message) {
    assets = message.getTaleDataMessage.assets;
    shared.Tale tale = message.getTaleDataMessage.tale;
    taleName = tale.name;
    langName = tale.langName;
    ClientWorldUtils.fromEnvelope(tale.world, this);
    recalculate();
    tale.players.forEach((key, player) {
      if (appService.players.containsKey(player.id)) {
        appService.players[player.id].fromSharedPlayer(player);
      } else {
        appService.players[player.id] = ClientPlayer()..fromSharedPlayer(player);
      }
      if (player.id == message.getTaleDataMessage.playerIdOnThisClientMachine) {
        appService.currentPlayer = appService.players[player.id];
      }
    });
    unitTypes = tale.unitTypes;
    setPlayersOnMoveByIds(tale.playerOnMoveIds);
    unitsCreateOrUpdate(tale.units);
    onTaleLoaded.add(tale.world);
  }

  void unitsCreateOrUpdate(List<shared.UnitCreateOrUpdateAction> actions) {
    actions.forEach((action) {
      if (action.newPlayerToTale != null && !appService.players.containsKey(action.newPlayerToTale.id)) {
        ClientPlayer newPlayer = ClientPlayer()..fromSharedPlayer(action.newPlayerToTale);
        appService.players[newPlayer.id] = newPlayer;
        if (action.isNewPlayerOnMove) {
          playersOnMove.add(playersOnMove.value..add(newPlayer));
        }
      }
      if (action.newUnitTypeToTale != null) {
        unitTypes[action.newUnitTypeToTale.name] = action.newUnitTypeToTale;
        if (action.newAssetsToTale != null) {
          assets.merge(action.newAssetsToTale);
        }
      }
      ClientUnit unit;
      if (units.containsKey(action.unitId)) {
        unit = units[action.unitId];
        unit.addUnitUpdateAction(action, fields[action.moveToFieldId]);
      } else {
        unit = ClientUnit(action, fields, appService.players, unitTypes);
        units[unit.id] = unit;
      }
      unitCreateOrUpdateAction.add(EnhancedUnitCreateOrUpdateAction()
        ..unit = unit
        ..action = action);
    });
  }
}

class EnhancedUnitCreateOrUpdateAction {
  shared.UnitCreateOrUpdateAction action;
  ClientUnit unit;
}
