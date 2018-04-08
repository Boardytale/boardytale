import '../../mock_storage/gateway.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main(){
  String jsonEncoded = (new File("compiled.json")).readAsStringSync();
  Map<String, dynamic> json = JSON.decode(jsonEncoded);
  String name = json['taleId']+'_v'+json['taleVersion'].toString();
  save('raw_tale', name, jsonEncoded);
//  Future<Process> process = Process.start("dart", ['../../mock_storage/gateway.dart', 'save', 'raw_tale', name, jsonEncoded]);
//  process.then((Process p){
//    p.stdout.transform(UTF8.decoder).listen((data) {
//      print(data);
//    });
//    print('done');
//  });
//  print("dart ../../mock_storage/gateway.dart save raw_tale $name $jsonEncoded");
}