import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'create_image.service.dart';

@Component(
  selector: 'create-image',
  template: '''
    <div class="create-image__container">
      <h1>Create image</h1>
      <textarea [(ngModel)]="newImage"></textarea>
      <button (click)="add()">Add</button>
    </div>
  ''',
  directives: [
    NgFor,
    NgIf,
    formDirectives,
  ],
  providers: [ClassProvider(CreateImageService)],
)
class CreateImageComponent implements OnInit {
  final CreateImageService createImageService;
  String newImage = "";
  CreateImageComponent(this.createImageService);

  @override
  Future<Null> ngOnInit() async {}

  void add() {
    print('click');
    createImageService.addImage(newImage);
  }
}
