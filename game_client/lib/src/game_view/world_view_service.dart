library world_view;

import 'dart:async';
import 'dart:html';
import 'dart:math' as math;
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:game_client/src/services/settings_service.dart';
import 'package:game_client/src/game_model/model.dart';
import 'package:game_client/src/game_model/abilities/abilities.dart';
import 'package:shared/model/model.dart' as shared;
import 'package:stagexl/stagexl.dart' as stage_lib;
import 'package:angular/core.dart';

part 'package:game_client/src/game_view/unit_manager.dart';

part 'package:game_client/src/game_view/paintable.dart';

part 'package:game_client/src/game_view/view_field.dart';

part 'package:game_client/src/game_view/paintables/unit_paintable.dart';

part 'package:game_client/src/game_view/paintables/active_field_paintable.dart';

part 'package:game_client/src/game_view/paintables/user_intention_paintable.dart';

part 'package:game_client/src/game_view/paintables/image_paintable.dart';

@Injectable()
class WorldViewService {
  final AppService appService;
  final GameService gameService;
  final SettingsService settings;
  stage_lib.Stage worldStage;
  stage_lib.Stage unitStage;
  ImageElement grassBackground;
  bool _imageLoaded = false;
  Map<shared.Terrain, stage_lib.Bitmap> fieldBitmaps = {};
  Map<String, ViewField> fields = {};
  shared.Assets assets;

  WorldViewService(this.appService, this.gameService, this.settings) {
    Map<shared.Terrain, ImageElement> resources = {};
    Map<shared.Terrain, String> paths = {
      shared.Terrain.grass: "img/map_tiles/grass.png",
      shared.Terrain.rock: "img/map_tiles/rock.png",
      shared.Terrain.water: "img/map_tiles/water.png",
      shared.Terrain.forest: "img/map_tiles/forest2.png",
    };
    List<Future<Event>> imageLoads = [];

    paths.forEach((terrain, path) {
      ImageElement image = ImageElement(src: path);
      resources[terrain] = image;
      imageLoads.add(image.onLoad.first);
    });

    Future.wait(imageLoads).then((_) {
      _imageLoaded = true;
      createBitmapsByTerrain(resources);
      init();
    });

    gameService.showCoordinateLabels.listen(repaint);
  }

  void onWorldLoaded(worldStage, unitStage, shared.Assets assets) {
    this.assets = assets;
    this.worldStage = worldStage;
    this.unitStage = unitStage;
    gameService.fields.forEach((key, ClientField field) {
      fields[key] = ViewField(field, this);
    });
    init();
  }

  void createBitmapsByTerrain(Map<shared.Terrain, ImageElement> resources) {
    HexaBorders defaultHex = gameService.worldParams.defaultHex;
    var path = stage_lib.Shape();
    stage_lib.Graphics graphics = path.graphics;
    graphics
      ..beginPath()
      ..moveTo(defaultHex.topLeft.x, defaultHex.topLeft.y)
      ..lineTo(defaultHex.topRight.x, defaultHex.topRight.y)
      ..lineTo(defaultHex.right.x, defaultHex.right.y)
      ..lineTo(defaultHex.bottomRight.x, defaultHex.bottomRight.y)
      ..lineTo(defaultHex.bottomLeft.x, defaultHex.bottomLeft.y)
      ..lineTo(defaultHex.left.x, defaultHex.left.y)
      ..closePath()
      ..strokeColor(0xff1E350D, 1.8);

    resources.forEach((shared.Terrain k, ImageElement v) {
      v.width = defaultHex.rectangle.width.toInt() + 1;
      v.height = defaultHex.rectangle.height.toInt() + 1;
      stage_lib.BitmapData data = stage_lib.BitmapData.fromImageElement(v);
      data.draw(path);
      fieldBitmaps[k] = stage_lib.Bitmap(data);
    });
  }

  void init() {
    if(!_imageLoaded || worldStage == null){
      return;
    }
    bool showLabel = gameService.showCoordinateLabels.value;
    fields.forEach((key, ViewField field) {
      field.refresh(showLabel);
    });
    worldStage.materialize(0.0, 0.0);
  }

  void repaint([_]) {
    if (!_imageLoaded) {
      return;
    }
    init();
    worldStage.materialize(0.0, 16.6);
  }
}
