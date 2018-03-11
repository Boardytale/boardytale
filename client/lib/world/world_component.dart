import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:boardytale_client/services/settings_service.dart';
import 'package:boardytale_client/services/state_service.dart';
import 'package:boardytale_client/world/view/world_view.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:stagexl/stagexl.dart' as stage_lib;

@Component(
    selector: 'world',
    template: r'''
        <canvas id="worldMap" #world [ngStyle]="{'width': widthString, 'height': heightString}"></canvas>
        <canvas id="mapObjects" #objects [ngStyle]="{'width': widthString, 'height': heightString}"></canvas>
        <div id="eventOverlay" [ngStyle]="{'width': widthString, 'height': heightString}"
        (mousedown)="onMouseDown($event)"
        (mouseup)="onMouseUp($event)"
        (mousemove)="onMouseMove($event)"
        (mouseout)="onMouseOut($event)"
        (mousewheel)="onMouseWheel($event)"

        ></div>
      ''',
    styles: const [
      """
      :host{
        display: block;
        position:absolute;
        top: 0;
      }
    """
    ],
    directives: const [COMMON_DIRECTIVES],
    changeDetection: ChangeDetectionStrategy.OnPush)
class WorldComponent implements OnDestroy {
  String get widthString => "${window.innerWidth}px";

  String get heightString => "${window.innerHeight}px";
  bool destroyed = false;
  stage_lib.Stage worldStage;
  stage_lib.Stage unitStage;
  StateService state;
  WorldView view;
  CanvasElement worldElement;
  CanvasElement mapObjectsElement;
  StreamSubscription onResizeSubscription;
  ChangeDetectorRef changeDetector;
  final SettingsService settings;
  UnitManager unitManager;

  bool _moving = false;
  UnitPaintable _draggedUnit;
  Point _start;
  int _startOffsetTop;
  int _startOffsetLeft;

  WorldComponent(this.changeDetector, this.settings, this.state) {
    onResizeSubscription = window.onResize.listen(detectChanges);
    state.onWorldLoaded.add(this.modelLoaded);
  }
  ClientWorld get world => state.world;

  @ViewChild("world")
  set worldElementRef(ElementRef element) {
    worldElement = element.nativeElement as CanvasElement;
  }

  @ViewChild("objects")
  set objectsElementRef(ElementRef element) {
    mapObjectsElement = element.nativeElement as CanvasElement;
  }

  void detectChanges([dynamic _]) {
    if (destroyed || view == null) return;
    view.repaint();
    changeDetector.markForCheck();
    changeDetector.detectChanges();
  }

  void modelLoaded() {
    worldStage = new stage_lib.Stage(worldElement,
        width: window.innerWidth,
        height: window.innerHeight,
        options: new stage_lib.StageOptions()
          ..antialias = true
          ..backgroundColor = stage_lib.Color.Transparent);
    worldStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
    worldStage.align = stage_lib.StageAlign.TOP_LEFT;
    view = new WorldView(worldStage, world);

    unitStage = new stage_lib.Stage(mapObjectsElement,
        width: window.innerWidth,
        height: window.innerHeight,
        options: new stage_lib.StageOptions()
          ..antialias = true
          ..backgroundColor = 0
          ..transparent = true);
    unitStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
    unitStage.align = stage_lib.StageAlign.TOP_LEFT;
    unitManager = new UnitManager(unitStage, view, settings);

//    view = new WorldViewService(worldStage, world, unitStage, settings);

    var renderLoop = new stage_lib.RenderLoop();
    renderLoop.addStage(unitStage);
    detectChanges();
  }

  void onMouseDown(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    Field field = world.getFieldByMouseOffset(event.page.x, event.page.y);
    UnitPaintable unit = unitManager.getFirstUnitPaintableOnField(field);
    if (unit != null) {
      _draggedUnit = unit;
    } else {
      _moving = true;
      _start = event.page;
      _startOffsetTop = world.userTopOffset;
      _startOffsetLeft = world.userLeftOffset;
    }
  }

  void onMouseUp(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    if (_draggedUnit != null) {
      Field field = world.getFieldByMouseOffset(event.page.x, event.page.y);
      _draggedUnit.unit.move(field, 0);
      _draggedUnit.field = field;
    }
    _moving = false;
    _draggedUnit = null;
  }

  void onMouseMove(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();
    if (!_moving) {
      Field field = world.getFieldByMouseOffset(event.page.x, event.page.y);
      unitManager.setActiveField(field);
      return;
    }
    if (_draggedUnit != null) {
      return;
    }
    int deltaX = (event.page.x - _start.x).toInt();
    int deltaY = (event.page.y - _start.y).toInt();
    world.userLeftOffset = _startOffsetLeft - deltaX;
    world.userTopOffset = _startOffsetTop - deltaY;
    // TODO: stack on anim frame
    world.recalculate();
    view.repaint();
  }

  void onMouseWheel(WheelEvent event) {
    event.preventDefault();
    event.stopPropagation();
    double zoomMultiply = event.deltaY < 0 ? 1.1 : 0.9;
    world.zoom *= zoomMultiply;

    if (world.zoom < 0.3) {
      world.zoom = 0.3;
    } else {
      int topOfMap = (event.page.y + world.userTopOffset).toInt();
      int leftOfMap = (event.page.x + world.userLeftOffset).toInt();
      world.userLeftOffset += (leftOfMap * zoomMultiply - leftOfMap).toInt();
      world.userTopOffset += (topOfMap * zoomMultiply - topOfMap).toInt();
    }
    world.recalculate();
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
    destroyed = true;
    onResizeSubscription.cancel();
  }
}
