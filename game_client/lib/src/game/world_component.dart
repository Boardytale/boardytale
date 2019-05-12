import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:game_client/src/game/action_feedback.dart';
import 'package:game_client/src/game/banter/banter.dart';
import 'package:game_client/src/game/game_controls_component.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/game_view/world_view_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:core/model/model.dart' as core;
import 'package:stagexl/stagexl.dart' as stage_lib;

@Component(
    selector: 'world',
    templateUrl: 'world_component.html',
    directives: [coreDirectives, GameControlsComponent, ActionsFeedback, BanterComponent],
    changeDetection: ChangeDetectionStrategy.OnPush)
class WorldComponent implements OnDestroy {
  final SettingsService settings;
  final GatewayService gatewayService;
  final WorldViewService view;
  final AppService appService;
  final GameService gameService;
  bool destroyed = false;
  stage_lib.Stage worldStage;
  stage_lib.Stage unitStage;
  CanvasElement worldElement;
  CanvasElement mapObjectsElement;
  StreamSubscription _onResizeSubscription;
  ChangeDetectorRef changeDetector;
  MapObjectsManager mapObjectsManager;
  bool _moving = false;
  ClientUnit _draggedUnit;
  Point _start;
  int _startOffsetTop;
  int _startOffsetLeft;
  int _lastActionId = 0;
  ClientField _lastActiveField;
  List<core.Field> trackFields;
  StreamSubscription _destroySubscription;
  StreamSubscription _onWorldLoadedSubscription;

  String get widthString => "${window.innerWidth}px";

  String get heightString => "${window.innerHeight}px";

  WorldComponent(
      this.changeDetector, this.settings, this.appService, this.gatewayService, this.gameService, this.view) {
    _onResizeSubscription = window.onResize.listen(detectChanges);
    _onWorldLoadedSubscription = gameService.onTaleLoaded.listen(modelLoaded);
    gatewayService.handlers[core.OnClientAction.intentionUpdate] = handleIntentionUpdate;
    _destroySubscription = appService.destroyCurrentTale.listen(clear);
    appService.playerRemoved.listen((ClientPlayer player){
      mapObjectsManager.addIntention(null, player.getStageColor());
    });
  }

  @ViewChild("world")
  set worldElementRef(Element element) {
    worldElement = element as CanvasElement;
  }

  @ViewChild("objects")
  set objectsElementRef(Element element) {
    mapObjectsElement = element as CanvasElement;
  }

  void handleIntentionUpdate(core.ToClientMessage message) {
    List<String> activeFieldIds = message.getIntentionUpdate.trackFieldsId;
    String playerId = message.getIntentionUpdate.playerId;
    ClientPlayer player = appService.players[playerId];
    int color = player.getStageColor();
    mapObjectsManager.addIntention(
        activeFieldIds == null ? null : activeFieldIds.map((id) => gameService.fields[id]).toList(), color);
  }

  void detectChanges([dynamic _]) {
    if (destroyed || view == null) return;
    Future.delayed(Duration.zero).then((_) {
      view.repaint();
    });
    changeDetector.markForCheck();
    changeDetector.detectChanges();
  }

  void modelLoaded([_]) {
    if (worldStage == null) {
      worldStage = stage_lib.Stage(worldElement,
          width: window.innerWidth,
          height: window.innerHeight,
          options: stage_lib.StageOptions()
            ..antialias = true
            ..backgroundColor = stage_lib.Color.Transparent);
      worldStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
      worldStage.align = stage_lib.StageAlign.TOP_LEFT;
    }

    if (unitStage == null) {
      unitStage = stage_lib.Stage(mapObjectsElement,
          width: window.innerWidth,
          height: window.innerHeight,
          options: stage_lib.StageOptions()
            ..antialias = true
            ..backgroundColor = 0
            ..transparent = true);
      unitStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
      unitStage.align = stage_lib.StageAlign.TOP_LEFT;
      var renderLoop = stage_lib.RenderLoop();
      renderLoop.addStage(unitStage);
    }
    view.onWorldLoaded(worldStage, unitStage, gameService.assets);
    if (mapObjectsManager == null) {
      mapObjectsManager = MapObjectsManager(unitStage, view);
    }
//    mapObectsManager.addInitialUnits();
    detectChanges();
  }

  void onMouseDown(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    ClientField field = ClientWorldUtils.getFieldByMouseOffset(event.page.x, event.page.y, gameService);
    if (field != null) {
      ClientUnit unit = field.getFirstPlayableUnitOnField();
      trackFields = [field];
      _lastActiveField = field;
      if (unit != null) {
        bool isMe = gameService.currentPlayer == unit.player;
        bool isOnMove = gameService.playersOnMove.value.any((player) => player.id == unit.player.id);
        if (isMe && isOnMove) {
          _draggedUnit = unit;
        }
        return;
      }
    }
    _moving = true;
    _start = event.page;
    _startOffsetTop = gameService.worldParams.userTopOffset;
    _startOffsetLeft = gameService.worldParams.userLeftOffset;
  }

  void onMouseUp(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    gameService.onUnitAssistanceChanged.add(null);
    if (_draggedUnit != null) {
      ClientField field = ClientWorldUtils.getFieldByMouseOffset(event.page.x, event.page.y, gameService);
      core.Track track = core.Track.clean(trackFields, gameService.fields);
      core.Ability ability = _draggedUnit.getAbility(track, event.shiftKey, event.altKey, event.ctrlKey);
      if (ability != null) {
        print(ability.name);
        gatewayService.sendMessage(core.ToGameServerMessage.unitTrackAction(core.UnitTrackAction()
          ..abilityName = ability.name
          ..unitId = _draggedUnit.id
          ..actionId = "${appService.currentPlayer.id}_${_lastActionId++}"
          ..track = track.toIds()));
        gatewayService.sendIntention(field == null ? null : [field]);
      } else {
        appService.alertError("No ability for ${_draggedUnit.name} | ${_draggedUnit.whyNoAbility(track).join(" | ")}");
      }
    }
    _moving = false;
    _draggedUnit = null;
  }

  void onMouseMove(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    if (!_moving) {
      ClientField field = ClientWorldUtils.getFieldByMouseOffset(event.page.x, event.page.y, gameService);
      if (field != _lastActiveField) {
        _lastActiveField = field;
        if (_draggedUnit != null) {
          trackFields.add(field);
          core.Track track = core.Track.clean(trackFields, gameService.fields);
          ClientAbility ability =
              _draggedUnit.getAbility(track, event.shiftKey, event.altKey, event.ctrlKey) as ClientAbility;
          if (ability != null) {
            print((ability as core.Ability).name);
            ability.show(_draggedUnit, track);
            gameService.onUnitAssistanceChanged.add(ability);
          } else {
            gameService.onUnitAssistanceChanged.add(null);
          }
          gatewayService.sendIntention(track.fields);
        } else {
          mapObjectsManager.setActiveField(field);
          gatewayService.sendIntention(field == null ? null : [field]);
        }
      }
      return;
    }
    if (_draggedUnit == null) {
      int deltaX = (event.page.x - _start.x).toInt();
      int deltaY = (event.page.y - _start.y).toInt();
      gameService.worldParams.userLeftOffset = _startOffsetLeft - deltaX;
      gameService.worldParams.userTopOffset = _startOffsetTop - deltaY;
      // TODO: stack on anim frame
      gameService.recalculate();
      view.repaint();
    }
  }

  void onMouseWheel(WheelEvent event) {
    // TODO: refactor mouse wheel to be working in firefox
    event.preventDefault();
    event.stopPropagation();
    double zoomMultiply = event.deltaY < 0 ? 1.1 : 0.9;
    gameService.worldParams.zoom *= zoomMultiply;

    if (gameService.worldParams.zoom < 0.3) {
      gameService.worldParams.zoom = 0.3;
    } else {
      int topOfMap = (event.page.y + gameService.worldParams.userTopOffset).toInt();
      int leftOfMap = (event.page.x + gameService.worldParams.userLeftOffset).toInt();
      gameService.worldParams.userLeftOffset += (leftOfMap * zoomMultiply - leftOfMap).toInt();
      gameService.worldParams.userTopOffset += (topOfMap * zoomMultiply - topOfMap).toInt();
    }
    gameService.recalculate();
    view.repaint();
  }

  void onMouseOut(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    _moving = false;
    _draggedUnit = null;
  }

  @override
  void ngOnDestroy() {
    print("world component destroyed");
    destroyed = true;
    if (_onWorldLoadedSubscription != null) {
      _onWorldLoadedSubscription.cancel();
      _onWorldLoadedSubscription = null;
    }
    if (_onResizeSubscription != null) {
      _onResizeSubscription.cancel();
      _onResizeSubscription = null;
    }
    if (_destroySubscription != null) {
      _destroySubscription.cancel();
      _destroySubscription = null;
    }
    worldStage = null;
    unitStage = null;
    worldElement = null;
    mapObjectsElement = null;
    mapObjectsManager.clear();
    mapObjectsManager = null;
    _lastActiveField = null;
    trackFields = null;
  }

  void clear([_]) {
    print("world component clear");
    // TODO: clear destroy process
    window.location.reload();
    mapObjectsManager.clear();
    _lastActiveField = null;
    trackFields = null;
  }
}
