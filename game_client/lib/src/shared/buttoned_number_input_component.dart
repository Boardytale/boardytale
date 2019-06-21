import 'dart:async';
import 'package:angular/src/core/metadata.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'buttoned-input',
  template: '''
  <button *ngIf="decimal && enabledMinus" (click)="decreaseDecimal()">--</button>
  <button *ngIf="enabledMinus" (click)="decrease()">-</button>
  {{value}}
  <button
   *ngIf="enabledPlus"
   (click)="increase()">+</button>
  <button *ngIf="decimal && enabledPlus" (click)="increaseDecimal()">++</button>
  ''',
  directives: [coreDirectives, formDirectives],
)
class ButtonedNumberInputComponent {
  int _value = 1;

  int get value => _value;

  @Input()
  bool enabledMinus = false;

  @Input()
  bool enabledPlus = true;

  @Input("value")
  void set value(int val) {
    _value = val;
  }

  final _valueChange = StreamController<int>();

  @Output()
  Stream<int> get valueChange => _valueChange.stream;

  @Input("decimal")
  bool decimal = false;

  void increase() {
    _value++;
    _valueChange.add(_value);
  }

  void decrease() {
    _value--;
    _valueChange.add(_value);
  }

  void increaseDecimal() {
    _value = _value + 10;
    _valueChange.add(_value);
  }

  void decreaseDecimal() {
    _value = _value - 10;
    _valueChange.add(_value);
  }
}
