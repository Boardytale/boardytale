const fs = require('fs');
let baseTerrain = "grass";
let waterProbability = 0.0001;
let forestProbability = 0.05;
let rockProbability = 0.005;
let waterProbBonus = 0.5;
let forestProbBonus = 0.2;
let rockProbBonus = 0.01;
let width = 30;
let height = 30;

function getDirection(x, y, direction) {
    if (x%2 ===1) {
        switch (direction) {
            case 0:
                return [x, y - 1];
            case 1:
                return [x + 1, y - 1];
            case 2:
                return [x + 1, y];
            case 3:
                return [x, y + 1];
            case 4:
                return [x - 1, y];
            case 5:
                return [x - 1, y - 1];
        }
    } else {
        switch (direction) {
            case 0:
                return [x, y - 1];
            case 1:
                return [x + 1, y];
            case 2:
                return [x + 1, y + 1];
            case 3:
                return [x, y + 1];
            case 4:
                return [x - 1, y + 1];
            case 5:
                return [x - 1, y];
        }
    }
    return null;
}

function toId(offset){
    return offset[0] + "_" + offset[1];
}

let out = {};

for(let x = 0;x<width;x++){
    for(let y = 0;y<height;y++){
        out[toId([x,y])] = baseTerrain;
    }
}

for(let x = 0;x<width;x++){
    for(let y = 0;y<height;y++){
        let fieldId = toId([x,y]);
        let forests = 0;
        let rocks = 0;
        let waters = 0;
        for(let direction = 0;direction<6;direction++){
            let nextFieldId = toId(getDirection(x, y, direction));
            if(out.hasOwnProperty(nextFieldId)){
                if(out[nextFieldId] === "forest"){
                    forests++;
                }
                if(out[nextFieldId] === "rock"){
                    rocks++;
                }
                if(out[nextFieldId] === "water"){
                    waters++;
                }
                let forestProb = forestProbability + forestProbBonus*forests;
                let rockProb = rockProbability + rockProbBonus*rocks;
                let waterProb = waterProbability + waterProbBonus*waters;
                let r1 = Math.random();
                let r2 = Math.random();
                let r3 = Math.random();
                if(r1 < forestProbability){
                    out[fieldId] = "forest";
                }else if(r2 < rockProb){
                    out[fieldId] = "rock";
                }else if(r3 < waterProb){
                    out[fieldId] = "water";
                }
            }
        }
    }
}

let cleared = {};

for(let x = 0;x<width;x++){
    for(let y = 0;y<height;y++){
        if(out[toId([x,y])] !== baseTerrain){
            cleared[toId([x,y])] = {
                terrain: out[toId([x,y])]
            };

        }
    }
}

fs.writeFileSync("shared/lib/data/generated-map.json", JSON.stringify(cleared));
console.log(cleared);
