import 'dart:convert';
import 'dart:html';
import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';
import 'package:boardytale_client/services/state_service.dart';
import 'package:boardytale_client/world/model/instance_generator.dart';
import 'package:boardytale_client/world/model/model.dart';
import 'package:boardytale_client/world/world_component.dart';

@Component(
    selector: 'lobby',
    directives: const [WorldComponent, NgFor],
    template: '''
      <h1>lobby</h1>
      <div class="players">
        <div *ngFor="let player of players" [class.is-me]="connectionName==player.connectionName" style="color:{{player.color}}">
          {{player.name}} - {{player.connectionName}}
        </div>
      </div>
      <world></world>
      ''',
    styles: const [
      """
        :host{
          color: white;
        }
        .is-me{
          font-weight: bold;
        }
        .players{
          background-color: white;
          position:absolute;
          top:0;
          right:0;
        }
      """
    ])
class LobbyComponent {
  final StateService state;
  String connectionName;
  List<Player> players = const [];
  WebSocket socket;
  final ChangeDetectorRef changeDetector;

  LobbyComponent(this.changeDetector, this.state) {
    socket = new WebSocket('ws://127.0.0.1:8086/ws');
    socket.onMessage.listen((MessageEvent e) {
      Map<String, dynamic> message = JSON.decode(e.data.toString());
      handleMessages(message);
    });
    socket.onOpen.listen((_) {
      socket.send(JSON.encode({"type": "ping", "message": "ahoj"}));
    });
  }
  void handleMessages(Map<String, dynamic> message) {
    print("Message ${message["type"]}");
    if(!message.containsKey("type")) throw "Message do not contain \"type\"";
    switch (message["type"]) {
      case "error":
        throw message["message"];
        break;
      case "message":
        print(message["message"]);
        break;
      case "players":
        ClientInstanceGenerator generator = new ClientInstanceGenerator();
        players = (message["players"] as Iterable<Map<String, dynamic>>)
            .map((Map<String, dynamic> data) => generator.player()..fromMap(data))
            .toList();
        changeDetector.detectChanges();
        break;
      case "connection":
        connectionName = message["name"];
        changeDetector.detectChanges();
        break;
      case "tale":
        state.loadTaleFromData(message["tale"]);
        changeDetector.detectChanges();
        break;
      case "ping":
        print(message["message"]);
        break;
      default:
        throw new UnimplementedError("Type ${message["type"]} unimplemented");
    }
  }
}
