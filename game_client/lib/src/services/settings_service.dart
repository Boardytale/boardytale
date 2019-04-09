import 'package:angular/core.dart';
import 'package:shared/model/model.dart';

@Injectable()
class SettingsService {
  Lang language = Lang.cz;
  int defaultFieldWidth = 72;
  int defaultFieldHeight;
  double widthHeightRatio = 1;

  SettingsService(){
    defaultFieldHeight = (defaultFieldWidth * widthHeightRatio).toInt();
  }
}
