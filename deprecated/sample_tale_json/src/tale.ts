import {IAbility, ITale} from 'tale_editor/lib/tale_format';

let specMove: IAbility =  {
    name: 'custom_special_move',
    effects: [],
    favouriteControls: 'placeHolder1',
    targetType: 'placeHolder2',
    values: [],
    variablesFilled: []
};

export let tale: ITale = {
    taleId: 'shit',
    taleName: 'tale_name_shit',
    taleVersion: 1,
    defaultDifficulty: 10,
    compilerVersion: "0.0.0",
    map: {
        width: 20,
        height: 20,
        baseTerrain: "edit default terrain",
        fields: {}
    },
    units: {},
    unitGroups: {},
    unitTypes: {},
    abilities: {
        special_move: specMove
    },
    actions: {},
    images: {},
    animations: {},
    ais: {},
    aiPlayers: {},
    dialogs: {},
    variables: {},
    members: {},
    langs: [],
    triggers: [],
    heroes: [],
    other: {},
};

console.clear();
console.log(JSON.stringify(tale));