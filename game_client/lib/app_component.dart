import 'package:angular/angular.dart';
import 'package:game_client/src/user_bar/user_bar.component.dart';

@Component(
  selector: 'my-app',
  template: '''
  <div class="main-wrapper">
    <user-bar class="navbar navbar-expand-lg navbar-light bg-light"></user-bar>
  </div>
  ''',
  directives: [UserBarComponent]
)
class AppComponent {
}
