import 'dart:convert';
import 'dart:async';
import 'package:io_utils/io_utils.dart';
import 'package:io_utils/aqueduct/wraps.dart';
import 'package:http/http.dart' as http;
import 'package:shared/model/model.dart' as shared;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared/configuration/configuration.dart';
import 'package:rxdart/rxdart.dart';

main(){
  final BoardytaleConfiguration config = getConfiguration();
  Future<shared.TaleCompiled> getTaleByName(String name) async {
    String uri =
        makeAddressFromUri(config.editorServer.uris.first) + "inner/taleByName";
    print(IdWrap.packId(name));
    print('{"id": "${name}"}');
    http.Response response =
    await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: '{"id": "${name}"}');

    print(response.body);
    return shared.TaleCompiled.fromJson(json.decode(response.body));
  }

  getTaleByName("0lvl_bandits");
}
