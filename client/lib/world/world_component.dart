import 'dart:html';
import 'dart:convert';
import 'package:angular2/core.dart';
import 'package:angular2/src/facade/async.dart';
import 'package:boardytale_client/services/tale_service.dart';
import 'package:boardytale_client/world/model/world_model.dart';
import 'package:boardytale_client/world/view/world_view.dart';
import 'package:boardytale_commons/model/model.dart';
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
    providers: const[TaleService],
    changeDetection: ChangeDetectionStrategy.OnPush)
class WorldComponent implements OnDestroy {
  String get widthString => "${window.innerWidth}px";

  String get heightString => "${window.innerHeight}px";
  bool destroyed = false;
  stage_lib.Stage worldStage;
  WorldModel model;
  WorldView view;
  CanvasElement worldElement;
  CanvasElement mapObjectsElement;
  StreamSubscription onResizeSubscription;
  TaleService taleService;
  ChangeDetectorRef changeDetector;

  WorldComponent(this.taleService, this.changeDetector) {
    this.taleService.onTaleLoaded.add(taleLoaded);
    onResizeSubscription = window.onResize.listen(detectChanges);
  }

  @ViewChild("world")
  set worldElementRef(ElementRef element) {
    worldElement = element.nativeElement;
  }

  @ViewChild("objects")
  set objectsElementRef(ElementRef element) {
    mapObjectsElement = element.nativeElement;
  }

  void detectChanges([_]) {
    if (destroyed) return;
    view.repaint();
    changeDetector.markForCheck();
    changeDetector.detectChanges();
  }

  void taleLoaded() {
    model = new WorldModel(taleService.tale);
    worldStage = new stage_lib.Stage(worldElement, width: window.innerWidth,
        height: window.innerHeight,
        options: new stage_lib.StageOptions()
          ..antialias = true
          ..backgroundColor = stage_lib.Color.Transparent);
    worldStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
    worldStage.align = stage_lib.StageAlign.TOP_LEFT;

    stage_lib.Stage objectsStage = new stage_lib.Stage(
        mapObjectsElement, width: window.innerWidth,
        height: window.innerHeight,
        options: new stage_lib.StageOptions()
          ..antialias = true
          ..backgroundColor  = 0
          ..transparent = true);
    objectsStage.scaleMode = stage_lib.StageScaleMode.NO_SCALE;
    objectsStage.align = stage_lib.StageAlign.TOP_LEFT;

    view = new WorldView(worldStage, model, objectsStage);


//    var renderLoop = new RenderLoop();
//    renderLoop.addStage(stage);
    detectChanges();
  }


  bool _moving = false;
  Point _start;
  int _startOffsetTop;
  int _startOffsetLeft;

  void onMouseDown(MouseEvent event) {
    _moving = true;
    _start = event.page;
    _startOffsetTop = model.userTopOffset;
    _startOffsetLeft = model.userLeftOffset;
  }

  void onMouseUp(MouseEvent event) {
    _moving = false;
  }

  void onMouseMove(MouseEvent event) {
    if (!_moving) return;
    int deltaX = event.page.x - _start.x;
    int deltaY = event.page.y - _start.y;
    model.userLeftOffset = _startOffsetLeft - deltaX;
    model.userTopOffset = _startOffsetTop - deltaY;
    // TODO: stack on anim frame
    model.recalculate();
    view.repaint();
  }

  void onMouseWheel(WheelEvent event) {
    double zoomDelta = event.deltaY < 0 ? 0.1 : -0.1;
    model.zoom += zoomDelta;

    if (model.zoom < 0.3) {
      model.zoom = 0.3;
    } else {
      // TODO: BAD pivot transformation, find out why
      double deltaX = (event.page.x + model.userLeftOffset) * zoomDelta;
      double deltaY = (event.page.y + model.userTopOffset) * zoomDelta;
      print(deltaX);
      model.userLeftOffset += deltaX.toInt();
      model.userTopOffset += deltaY.toInt();
    }
    model.recalculate();
    view.repaint();
  }

  void onMouseOut(MouseEvent event) {
    _moving = false;
  }

  @override
  ngOnDestroy() {
    destroyed = true;
    onResizeSubscription.cancel();
  }
}
