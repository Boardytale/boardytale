library tale_service;

import 'dart:async';

import 'package:angular/core.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:core/model/model.dart' as core;

@Injectable()
class GameService {
  final SettingsService settings;
  final AppService appService;
  final GatewayService gatewayService;
  BehaviorSubject<bool> showCoordinateLabels = BehaviorSubject<bool>(seedValue: false);
  Map<String, core.AiGroup> aiGroups = {};
  BehaviorSubject<core.World> onTaleLoaded = BehaviorSubject();
  BehaviorSubject<List<ClientPlayer>> playersOnMove = BehaviorSubject(seedValue: null);

  ReplaySubject<EnhancedUnitCreateOrUpdateAction> unitCreateOrUpdateAction = ReplaySubject();
  BehaviorSubject<core.CancelOnField> cancelOnField = BehaviorSubject();
  BehaviorSubject<CurrentBanter> currentBanter = BehaviorSubject();
  List<core.ShowBanterAction> _banterQueue = [];
  core.Assets assets;
  Map<String, ClientField> fields = {};
  BehaviorSubject<Null> onDimensionsChanged = BehaviorSubject();
  BehaviorSubject<ClientAbility> onUnitAssistanceChanged = BehaviorSubject();

  List<String> startingFieldIds = [];
  String taleName;
  Map<core.Lang, Map<String, String>> langs;
  Map<core.Lang, String> langName;
  Map<String, ClientPlayer> aiPlayers = {};
  Map<String, core.Event> events = {};
  Map<String, core.Dialog> dialogs = {};
  Map<String, core.Unit> units = {};
  Map<String, core.UnitType> unitTypes = {};

  ClientPlayer get currentPlayer => appService.currentPlayer;

  ClientWorldParams worldParams = ClientWorldParams();

  GameService(this.gatewayService, this.settings, this.appService) {
    worldParams.defaultHex = HexaBorders(this);
    gatewayService.handlers[core.OnClientAction.taleData] = handleTaleData;
    gatewayService.handlers[core.OnClientAction.cancelOnField] = handleCancelOnField;
    gatewayService.handlers[core.OnClientAction.unitCreateOrUpdate] = (core.ToClientMessage message) {
      taleUpdate(message.getUnitCreateOrUpdate);
    };
  }

  void addBanter(core.ShowBanterAction banter) {
    if (banter == null) {
      if (_banterQueue.isNotEmpty) {
        addBanter(_banterQueue.removeAt(0));
      }
      return;
    }
    if (currentBanter.value == null) {
      CurrentBanter current = CurrentBanter()..banter = banter;
      if (banter.speakingUnitId != null && units.containsKey(banter.speakingUnitId)) {
        current.unit = units[banter.speakingUnitId];
      }
      currentBanter.add(current);
      Future.delayed(Duration(milliseconds: banter.showTimeInMilliseconds)).then((_) {
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
      List<ClientPlayer> playersOnMoveOut = [];
      ids.forEach((id) {
        if (appService.players.containsKey(id)) {
          playersOnMoveOut.add(appService.players[id]);
        }
      });
      playersOnMove.add(playersOnMoveOut);
    }
  }

  void recalculate() {
    worldParams.recalculate(settings);
    fields.forEach((k, v) => v.recalculate());
    onDimensionsChanged.add(null);
  }

  void handleTaleData(core.ToClientMessage message) {
    assets = message.getTaleDataMessage.assets;
    core.Tale tale = message.getTaleDataMessage.tale;
    taleName = tale.name;
    langName = tale.langName;
    ClientWorldUtils.fromEnvelope(tale.world, this);
    recalculate();
    tale.players.forEach((key, player) {
      if (appService.players.containsKey(player.id)) {
        appService.players[player.id].fromCorePlayer(player);
      } else {
        appService.players[player.id] = ClientPlayer()..fromCorePlayer(player);
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

  void taleUpdate(core.TaleUpdate update) {
    if (update.newPlayersToTale != null) {
      update.newPlayersToTale.forEach((player) {
        if (!appService.players.containsKey(player.id)) {
          ClientPlayer newPlayer = ClientPlayer()..fromCorePlayer(player);
          appService.players[newPlayer.id] = newPlayer;
        }
      });
    }
    if (update.newUnitTypesToTale != null) {
      update.newUnitTypesToTale.forEach((type) {
        unitTypes[type.name] = type;
      });
    }
    if (update.newAssetsToTale != null) {
      assets.merge(update.newAssetsToTale);
    }

    if (update.actions != null) {
      unitsCreateOrUpdate(update.actions);
    }
    if (update.unitToRemoveIds != null) {
      update.unitToRemoveIds.forEach((toRemoveId) {
        if (units.containsKey(toRemoveId)) {
          units[toRemoveId].destroy();
          units.remove(toRemoveId);
        }
      });
    }
    if (update.removePlayerId != null) {
      appService.removePlayerById(update.removePlayerId);
    }
    setPlayersOnMoveByIds(update.playerOnMoveIds);

    if (update.banterAction != null) {
      addBanter(update.banterAction);
    }
  }

  void unitsCreateOrUpdate(List<core.UnitCreateOrUpdateAction> actions) {
    actions.forEach((action) {
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

  void handleCancelOnField(core.ToClientMessage message) {
    cancelOnField.add(message.getCancelOnField);
  }
}

class EnhancedUnitCreateOrUpdateAction {
  core.UnitCreateOrUpdateAction action;
  ClientUnit unit;
}

class CurrentBanter {
  core.ShowBanterAction banter;
  ClientUnit unit;
}
