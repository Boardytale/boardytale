import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:core/model/model.dart' as core;
import 'package:game_client/src/services/app_service.dart';
import 'package:game_client/src/services/game_service.dart';
import 'package:game_client/src/services/gateway_service.dart';

@Component(
    selector: 'banter',
    directives: [coreDirectives, formDirectives],
    templateUrl: "banter.html",
    changeDetection: ChangeDetectionStrategy.OnPush)
class BanterComponent {
  GameService gameService;
  AppService appService;
  GatewayService gateway;
  final ChangeDetectorRef changeDetector;

  core.ShowBanterAction getBanter() {
    CurrentBanter current = gameService.currentBanter.value;
    return current != null ? current.banter : null;
  }

  BanterComponent(this.gameService, this.gateway, this.changeDetector, this.appService) {
    gameService.currentBanter.listen((_) {
      changeDetector.markForCheck();
    });
  }

  bool showImage() {
    return getBanter().image != null;
  }

  String getImageWidth() {
    return "${(getBanter().image.width * getBanter().image.multiply).toInt()}px";
  }

  String getImageHeight() {
    return "${(getBanter().image.height * getBanter().image.multiply).toInt()}px";
  }
}
