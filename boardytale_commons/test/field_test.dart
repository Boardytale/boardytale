import 'package:boardytale_commons/model/model.dart';
import 'package:test/test.dart';

class DistanceTest{
  Field _origin;
  Field _target;
  int _distance;

  DistanceTest(String origin,String target,this._distance){
    _origin = new Field(origin,null);
    _target = new Field(target,null);
  }
  String get name => "${_origin.id} => ${_target.id} == $_distance";
  void test(){
    expect(_origin.distance(_target),_distance);
  }
}
void main(){
  group("Field",(){
    group("distance",(){
      List<DistanceTest> tests=[
        new DistanceTest("0_0","3_3", 5),
        new DistanceTest("0_0","5_3", 6),
        new DistanceTest("0_0","1_3", 4),
        new DistanceTest("0_0","0_3", 3),
        new DistanceTest("2_1","1_3", 3),
        new DistanceTest("8_4","11_0", 5),
        new DistanceTest("11_4","8_1", 5),
        new DistanceTest("11_3","6_4", 5),
        new DistanceTest("9_0","6_4", 5)
      ];
      for(DistanceTest distanceTest in tests){
        test(distanceTest.name, distanceTest.test);
      }
    });
  });
}
