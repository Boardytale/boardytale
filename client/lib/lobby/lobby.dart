import 'dart:convert';
import 'dart:html';
import 'package:angular/core.dart';
import 'package:angular/src/common/directives.dart';

@Component(
    selector: 'lobby',
    directives: const [NgFor],
    template: '''
      <h1>lobby</h1>
      <div *ngFor="let other of connections" [class.is-me]="connection==other">{{other}}</div>
      ''',
    styles: const [
      """
        :host{
          color: white;
        }
        .is-me{
          font-weight: bold;
        }
      """
    ])
class LobbyComponent {
  String connection;
  List<String> connections = const [];
  WebSocket socket;
  final ChangeDetectorRef changeDetector;

  LobbyComponent(this.changeDetector) {
    socket = new WebSocket('ws://127.0.0.1:8086/ws');
    socket.onMessage.listen((MessageEvent e) {
      Map<String, dynamic> message = JSON.decode(e.data);
      if (message.containsKey("name")) {
        connection = message["name"];
      }
      if (message.containsKey("sockets")) {
        connections = message["sockets"];
      }
      changeDetector.detectChanges();
      print(message);
    });
    socket.onOpen.listen((_) {
      socket.send(JSON.encode({"message": "ahoj"}));
    });
  }
}
