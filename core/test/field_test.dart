import 'package:core/model/model.dart';
import 'package:test/test.dart';

class DistanceTest {
  Field _origin;
  Field _target;
  int _distance;

  DistanceTest(String origin, String target, this._distance) {
    _origin = new Field(origin);
    _target = new Field(target);
  }
  String get name => "${_origin.id} => ${_target.id} == $_distance";
  void test() {
    expect(_origin.distance(_target), _distance);
  }
}

class DirectionToTest {
  Field _origin;
  Field _target;
  int _direction;

  DirectionToTest(String origin, String target, this._direction) {
    _origin = new Field(origin);
    _target = new Field(target);
  }
  String get name => "${_origin.id} => ${_target.id} == $_direction";
  void test() {
    expect(_origin.directionTo(_target), _direction);
  }
}

class GetShortestPathTest {
  Field _origin;
  Field _target;
  List<String> _path;

  GetShortestPathTest(String origin, String target, this._path) {
    _origin = new Field(origin);
    _target = new Field(target);
  }
  String get name => "${_origin.id} => ${_target.id} == $_path";
  void test() {
    expect(_origin.getShortestPath(_target), _path);
  }
}

void main() {
  group("Field", () {
    group("distance", () {
      List<DistanceTest> tests = [
        new DistanceTest("0_0", "3_3", 5),
        new DistanceTest("0_0", "5_3", 6),
        new DistanceTest("0_0", "1_3", 4),
        new DistanceTest("0_0", "0_3", 3),
        new DistanceTest("2_1", "1_3", 3),
        new DistanceTest("8_4", "11_0", 5),
        new DistanceTest("11_4", "8_1", 5),
        new DistanceTest("11_3", "6_4", 5),
        new DistanceTest("9_0", "6_4", 5)
      ];
      for (DistanceTest distanceTest in tests) {
        test(distanceTest.name, distanceTest.test);
      }
    }, skip: true);
    group("directionTo", () {
      List<DirectionToTest> tests = [
        new DirectionToTest("0_0", "3_3", 2),
        new DirectionToTest("0_0", "5_3", 2),
        new DirectionToTest("0_0", "1_3", 3),
        new DirectionToTest("0_0", "0_3", 3),
        new DirectionToTest("2_1", "1_3", 3),
        new DirectionToTest("8_4", "11_0", 1),
        new DirectionToTest("11_4", "8_1", 5),
        new DirectionToTest("11_3", "6_4", 4),
        new DirectionToTest("9_0", "6_4", 4)
      ];
      for (DirectionToTest directionToTest in tests) {
        test(directionToTest.name, directionToTest.test);
      }
    }, skip: true);
    group("getShortestPath", () {
      List<GetShortestPathTest> tests = [
        new GetShortestPathTest("0_0", "2_2", ["0_0", "1_0", "1_1", "2_2"]),
        new GetShortestPathTest("8_3", "5_3", ["8_3", "7_3", "6_3", "5_3"]),
        new GetShortestPathTest("8_3", "8_6", ["8_3", "8_4", "8_5", "8_6"]),
//        new GetShortestPathTest("0_0","1_3", 3),
      ];
      for (GetShortestPathTest directionToTest in tests) {
        test(directionToTest.name, directionToTest.test);
      }
    });
  });
}
