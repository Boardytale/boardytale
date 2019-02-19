part of deskovka_client;

class ClientField extends Field {
  CanvasRenderingContext2D ctx;
  ClientWorld map;
  int offsetX;
  int offsetY;
  String highlightImageId;
  bool repaintRequested = true;

  ClientField(
      this.map, int index, int x, int y, this.offsetX, this.offsetY, this.ctx)
      : super(index, x, y) {}

  void highlight() {
    repaintRequested = true;
    highlightImageId = "highlight_emphasis";
  }

  void clearEnlights() {
    highlightImageId = null;
    repaintRequested = true;
  }

  @override
  void addUnit(Unit unit) {
    units.add(unit);
    unit.onHealthChanged.listen(refresh);
    unit.onStepsChanged.listen(refresh);
    unit.onTypeChanged.listen(refresh);
    repaintRequested = true;
  }

  @override
  void refresh([event]) {
    repaintRequested = true;
  }

  void repaint() {
    if (!repaintRequested) return;
    repaintRequested = false;
    var c = map.ctx;
    c.lineWidth = 2;
    c.beginPath();
    c.moveTo(offsetX, offsetY + 42);
    c.lineTo(offsetX + 24, offsetY);
    c.lineTo(offsetX + 72, offsetY);
    c.lineTo(offsetX + 96, offsetY + 42);
    c.lineTo(offsetX + 72, offsetY + 83);
    c.lineTo(offsetX + 24, offsetY + 83);
    c.lineTo(offsetX, offsetY + 42);
    c.stroke();
    c.drawImage(images["trav"], offsetX, offsetY);
    if (highlightImageId != null) {
      c.drawImage(images[highlightImageId], offsetX, offsetY);
    }
    c.font = "10px sans-serif";
    c.fillText("$x $y", offsetX + 20, offsetY + 20);

    List<Unit> alives = alivesOnField();
    List<Unit> deaths = deathsOnField();

    Unit firstAlive;

    if (!alives.isEmpty) {
      if (player == gf.game.you) {
        c.fillStyle = 'rgba(44,44,255,0.5)';
      } else {
        c.fillStyle = 'rgba(255,44,44,0.5)'; //"#ff4444"
      }
      c.fill();
    }
    if (!this.units.isEmpty) {
      if (!alives.isEmpty) {
        firstAlive = alives.first;
      }

      var healthWidth =
          (!alives.isEmpty ? 47 / firstAlive.type.health : 47 / 5);
      var stepsWidth = 47 / units.first.speed;

      if (alives.isEmpty) {
        c.globalAlpha = 0.5;
      }
      if (firstAlive != null) {
        c.drawImage(
            images["unit_${firstAlive.type.id}"], offsetX + 2, offsetY + 2);
      }
      c.globalAlpha = 0.8;
      c.fillStyle = "#222222";
      c.fillRect(offsetX + 24, offsetY - 1, 48, 6);
      c.fillStyle = alives.length > 0 ? "#ff0000" : "purple";
      for (var i = 0; i < (!alives.isEmpty ? firstAlive.type.health : 5); i++) {
        if (i == (units.first.actualHealth).abs()) {
          c.fillStyle = "#888888";
        }
        c.fillRect(
            offsetX + healthWidth * i + 25, offsetY, (healthWidth - 1.5), 4);
      }
      if (!alives.isEmpty) {
        c.fillStyle = "#222222";
        c.fillRect(offsetX + 24, offsetY + 77, 48, 6);
        c.fillStyle = "#00bb00";
        for (int i = 0; i < firstAlive.speed; i++) {
          if (i == units.first.steps) c.fillStyle = "#444444";
          c.fillRect(offsetX + stepsWidth * i + 25, offsetY + 78,
              (stepsWidth - 1.5), 4);
        }
        c.globalAlpha = 1;
      } else {
        c.globalAlpha = 1;
      }
      c.font = "16px sans-serif";
      if (deaths.length > 1) {
        c.fillStyle = "#000000";
        c.fillText(deaths.length.toString(), offsetX + 79, offsetY + 47);
      }
      if (alives.length > 1) {
        c.fillStyle = "#ff0000";
        c.fillText(alives.length.toString(), offsetX + 79, offsetY + 47);
      }

      c.fillStyle = "black";
    }
//            if(this.apply!==false){
//                var e = this.enlights;
////            alert("apply")
////            for(i = 0;i<e.length;i++){
////                if(!e[i].apply && !(uu && pocetZivych==0 && pocetMrtvych>0 && e[i].name=="death"))continue;
//                    c.save();
//                    var grd = e[this.apply].grd;
//                    c.fillStyle=grd;
//                    c.translate(offsetX, offsetY);
//                    c.globalCompositeOperation=e[this.apply].operation||"lighter";
//                    c.beginPath();
//                    c.moveTo(0,42);
//                    c.lineTo(24,0);
//                    c.lineTo(72,0);
//                    c.lineTo(96,42);
//                    c.lineTo(72,83);
//                    c.lineTo(24,83);
//                    c.lineTo(0,42);
//                    c.fill();
//                    c.restore();
////            }
//            }else if(pocetZivych==0 && pocetMrtvych>0){
//                    e = this.enlights;
//                    c.save();
//                    grd = e[7].grd;
//                    c.fillStyle=grd;
//                    c.translate(offsetX, offsetY);
//                    c.globalCompositeOperation="source-over";
//                    c.beginPath();
//                    c.moveTo(0,42);
//                    c.lineTo(24,0);
//                    c.lineTo(72,0);
//                    c.lineTo(96,42);
//                    c.lineTo(72,83);
//                    c.lineTo(24,83);
//                    c.lineTo(0,42);
//                    c.fill();
//                    c.restore();
//
//            }
  }
}
