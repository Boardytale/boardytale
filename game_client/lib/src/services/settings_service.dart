import 'package:angular/core.dart';
import 'package:shared/model/model.dart';

@Injectable()
class SettingsService {
  Lang language = Lang.cz;
  int defaultFieldWidth = 72;
}
