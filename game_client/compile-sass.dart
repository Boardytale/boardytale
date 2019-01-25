import 'dart:io';
import 'package:sass/sass.dart' as sass;

void main(List<String> arguments) {
  var result = sass.compile('web/styles.scss');
  File('web/styles.css').writeAsStringSync(result);
}
