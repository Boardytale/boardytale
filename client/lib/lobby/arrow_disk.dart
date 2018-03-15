part of 'lobby.dart';

@Component(
    selector: "arrow-disk",
    directives: const[NgFor],
    template: """
      <button *ngFor="let arrow of arrows" (click)='onClick(arrow)'>{{arrow}}</button>

""",styles: const[""":host{
  position:fixed;
  right:0;
  bottom:0;
  z-index: 2;
  }"""])
class ArrowDisk {
  final StateService state;
  final List<int> arrows=const[0,1,2,3,4,5];
  final LobbyComponent lobby;

  ArrowDisk(this.state, this.lobby);

  void onClick(int arrow){
    int meId = lobby.me.id;
    Unit unit=state.tale.units.values.firstWhere((commonLib.Unit unit)=>unit.player.id==meId,orElse: ()=>null);
    String target=unit.field.stepToDirection(arrow);
    lobby.socket.send(JSON.encode({"type": "command", "command": "move","unit":unit.id,"origin":unit.field.id,"target":target}));
  }
}
