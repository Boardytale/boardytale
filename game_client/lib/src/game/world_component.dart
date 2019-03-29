import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:game_client/src/game/action_feedback.dart';
import 'package:game_client/src/game/game_controls_component.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/game_view/world_view_service.dart';
import 'package:game_client/src/services/gateway_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:shared/model/model.dart' as shared;
import 'package:stagexl/stagexl.dart' as stage_lib;
import 'package:rxdart/rxdart.dart';

@Component(
    selector: 'world',
    templateUrl: 'world_component.html',
    directives: [coreDirectives, GameControlsComponent, ActionsFeedback],
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
  UnitManager unitManager;
  bool _moving = false;
  ClientUnit _draggedUnit;
  Point _start;
  int _startOffsetTop;
  int _startOffsetLeft;
  int _lastActionId = 0;
  ClientField _lastActiveField;
  ClientWorldService _clientWorldService;
  List<shared.Field> trackFields;

  // Helper for async loader of the game. Source of Actions is in gameService.
  ReplaySubject<List<shared.UnitCreateOrUpdateAction>> _unitCreateOrUpdateAction = ReplaySubject();
  StreamSubscription _destroySubscription;
  StreamSubscription _unitCreateOrUpdateActionSubscription;
  StreamSubscription _onWorldLoadedSubscription;

  String get widthString => "${window.innerWidth}px";

  String get heightString => "${window.innerHeight}px";

  WorldComponent(this.changeDetector, this.settings, this.appService, this.gatewayService, this.gameService, this.view,
      this._clientWorldService) {
    print("world component construct");
    _onResizeSubscription = window.onResize.listen(detectChanges);
    _onWorldLoadedSubscription = gameService.onWorldLoaded.listen(modelLoaded);
    gatewayService.handlers[shared.OnClientAction.intentionUpdate] = handleIntentionUpdate;
    gatewayService.handlers[shared.OnClientAction.unitCreateOrUpdate] = (shared.ToClientMessage message) {
      var action = message.getUnitCreateOrUpdate;
      _unitCreateOrUpdateAction.add(action.actions);
      gameService.setPlayersOnMoveByIds(action.playerOnMoveIds);
    };
    _destroySubscription = appService.destroyCurrentTale.listen(clear);
  }

  @ViewChild("world")
  set worldElementRef(Element element) {
    worldElement = element as CanvasElement;
  }

  @ViewChild("objects")
  set objectsElementRef(Element element) {
    mapObjectsElement = element as CanvasElement;
  }

  void handleIntentionUpdate(shared.ToClientMessage message) {
    List<String> activeFieldIds = message.getIntentionUpdate.trackFieldsId;
    String playerId = message.getIntentionUpdate.playerId;
    ClientPlayer player = appService.players[playerId];
    int color = player.getStageColor();
    unitManager.addIntention(
        activeFieldIds == null ? null : activeFieldIds.map((id) => _clientWorldService.fields[id]).toList(), color);
  }

  void detectChanges([dynamic _]) {
    if (destroyed || view == null) return;
    Future.delayed(Duration.zero).then((_) {
      view.repaint();
    });
    changeDetector.markForCheck();
    changeDetector.detectChanges();
  }

  void modelLoaded(bool isLoad) {
    if(!isLoad){
      return;
    }
    _unitCreateOrUpdateActionSubscription = _unitCreateOrUpdateAction.listen(_clientWorldService.handleUnitCreateOrUpdate);
    if(worldStage == null){
      worldStage = stage_lib.Stage(worldElement,
          width: window.innerWidth,
          height: window.innerHeight,
          options: stage_lib.StageOptions()
            ..antialias = true
            ..backgroundColor = stage_lib.Color.Transparent);
      worldStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
      worldStage.align = stage_lib.StageAlign.TOP_LEFT;
    }
    view.onWorldLoaded(worldStage);

    if(unitStage == null){
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
    if(unitManager == null){
      unitManager = UnitManager(unitStage, view, settings);
    }
    unitManager.addInitialUnits();
    detectChanges();
  }

  void onMouseDown(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    ClientField field = _clientWorldService.getFieldByMouseOffset(event.page.x, event.page.y);
    ClientUnit unit = field.getFirstPlayableUnitOnField();
    trackFields = [field];
    _lastActiveField = field;
    if (unit != null) {
      bool isMe = gameService.currentPlayer == unit.player;
      bool isOnMove = gameService.playersOnMove.value.any((player) => player.id == unit.player.id);
      if (isMe && isOnMove) {
        _draggedUnit = unit;
      }
    } else {
      _moving = true;
      _start = event.page;
      _startOffsetTop = _clientWorldService.userTopOffset;
      _startOffsetLeft = _clientWorldService.userLeftOffset;
    }
  }

  void onMouseUp(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    _clientWorldService.onUnitAssistanceChanged.add(null);
    if (_draggedUnit != null) {
      ClientField field = _clientWorldService.getFieldByMouseOffset(event.page.x, event.page.y);
      shared.Track track = shared.Track.clean(trackFields, _clientWorldService.fields);
      shared.Ability ability = _draggedUnit.getAbility(track, event.shiftKey, event.altKey, event.ctrlKey);
      if (ability != null) {
        print(ability.name);
        gatewayService.sendMessage(shared.ToGameServerMessage.unitTrackAction(shared.UnitTrackAction()
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
      ClientField field = _clientWorldService.getFieldByMouseOffset(event.page.x, event.page.y);
      if (field != _lastActiveField) {
        _lastActiveField = field;
        if (_draggedUnit != null) {
          trackFields.add(field);
          shared.Track track = shared.Track.clean(trackFields, _clientWorldService.fields);
          ClientAbility ability =
              _draggedUnit.getAbility(track, event.shiftKey, event.altKey, event.ctrlKey) as ClientAbility;
          if (ability != null) {
            print((ability as shared.Ability).name);
            ability.show(_draggedUnit, track);
            _clientWorldService.onUnitAssistanceChanged.add(ability);
          } else {
            _clientWorldService.onUnitAssistanceChanged.add(null);
          }
          gatewayService.sendIntention(track.fields);
        } else {
          unitManager.setActiveField(field);
          gatewayService.sendIntention(field == null ? null : [field]);
        }
      }
      return;
    }
    if (_draggedUnit == null) {
      int deltaX = (event.page.x - _start.x).toInt();
      int deltaY = (event.page.y - _start.y).toInt();
      _clientWorldService.userLeftOffset = _startOffsetLeft - deltaX;
      _clientWorldService.userTopOffset = _startOffsetTop - deltaY;
      // TODO: stack on anim frame
      _clientWorldService.recalculate();
      view.repaint();
    }
  }

  void onMouseWheel(WheelEvent event) {
    // TODO: refactor mouse wheel to be working in firefox
    event.preventDefault();
    event.stopPropagation();
    double zoomMultiply = event.deltaY < 0 ? 1.1 : 0.9;
    _clientWorldService.zoom *= zoomMultiply;

    if (_clientWorldService.zoom < 0.3) {
      _clientWorldService.zoom = 0.3;
    } else {
      int topOfMap = (event.page.y + _clientWorldService.userTopOffset).toInt();
      int leftOfMap = (event.page.x + _clientWorldService.userLeftOffset).toInt();
      _clientWorldService.userLeftOffset += (leftOfMap * zoomMultiply - leftOfMap).toInt();
      _clientWorldService.userTopOffset += (topOfMap * zoomMultiply - topOfMap).toInt();
    }
    _clientWorldService.recalculate();
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
    unitManager.clear();
    unitManager = null;
    _lastActiveField = null;
    _clientWorldService = null;
    trackFields = null;
    _unitCreateOrUpdateAction.close();
  }

  void clear([_]) {
    print("world component clear");
    // TODO: clear destroy process
    window.location.reload();
    unitManager.clear();
    _lastActiveField = null;
    trackFields = null;
    _unitCreateOrUpdateActionSubscription.cancel();
    _unitCreateOrUpdateActionSubscription = null;
  }
}
