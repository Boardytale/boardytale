import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'create-tale',
  template: '''
    <div class="create-tale__container">
      <h1>Create image</h1>
      <textarea [(ngModel)]="newTale"></textarea>
      <button (click)="add()">Add</button>
    </div>
  ''',
  directives: [
    NgFor,
    NgIf,
    formDirectives,
  ],
)
class CreateTaleComponent implements OnInit {
  String newTale = "";
  final http.Client _http;

  CreateTaleComponent(this._http);

  @override
  Future<Null> ngOnInit() async {}

  void add() {
    print('click');
    this._http.post("/editorApi/tales", headers: {"Content-Type": "application/json"}, body: newTale);
  }
}
