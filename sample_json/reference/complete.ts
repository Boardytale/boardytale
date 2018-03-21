//complete json
//? convention for original and stored entity ids?
import {IMap} from './map';

export interface ITale {
    taleId: number;
    //  convention to begin ids/key with prefix of their type could be usefull
    taleNameId: string;
    // "taleVersion": 152,
    // "defaultDifficulty": 10,
    // "compilerVersion": {
    //   //    core rewrite, no compatibility across major versions
    //   "version": 2,
    //   //    some changes
    //   "subversion": 15,
    //   //    hotfixes, takes only json from "other"
    //   "subsubversion": 153
    // },
    map: IMap;
    // terrains: {
    //   "terr_id1": {
    //     //      @terrain
    //   }
    // },
    // "units": {
    //   "unit_id1": {
    //     //      @unit
    //   }
    // },
    // "unitGroups": {
    //   "unitGroup_id1": {
    //     //      @unitGroup
    //   }
    // },
    // "buffs": {
    //   "buff_id1": {
    //     //      @buff
    //   }
    // },
    // "unitTypes": {
    //   "unitType_id1": {
    //     //      @unitType
    //   }
    // },
    // "heroes": [
    //   {
    //     //    @hero
    //   }
    // ],
    // "abilities": {
    //   "abil_id1": {
    //     //      @ability
    //   }
    // },
    // "events": {
    //   "event_id1": {
    //     //        @event
    //   }
    // },
    // "actions": {
    //   "action_id1": {
    //     //        @action
    //   }
    // },
    // "triggers": /*$triggers*/{
    //   "event_id1": [
    //     {
    //       "condition": "member_id1",
    //       "events": [
    //         "event_id1",
    //         "event_id2",
    //         "event_id3"
    //       ]
    //     }
    //   ]
    // },
    // "sounds": {
    //   "sound_id_154": "comprimed_representation"
    // },
    // "images": {
    //   "img_id1": {
    //     //      @image
    //   }
    // },
    // "animations": {
    //   "animation_id1": {
    //     //      @animation
    //   }
    // },
    // "ais": {
    //   "ai_id": {
    //     //      @ai
    //   }
    // },
    // "aiPlayers": {
    //   //    @aiPlayer
    // },
    // "texts": {
    //   "text_id1": {
    //     //      @text
    //   }
    // },
    // "dialogs": {
    //   "dial_id8": {
    //     //    @dialog
    //   }
    // },
    // "variables": {
    //   "var_id1": {
    //     //      @variable
    //   }
    // },
    // "members": {
    //   "member_id5": {
    //     //      @member
    //   }
    // },
    // "other": {
    //   //    hotfix-stuff
    // }
}

export type IFieldType =
    'grass' | 'rock';

export interface IField {
    a: string;
}

let tale: ITale = {
    map: {
        width: 20,
        fields: {
            aa: 'grass',
            bb: {a: 'aaa'},
        }
    },
    taleId: 10,
    taleNameId: 'aa',
};

console.log(JSON.stringify(tale));
const fs = require('fs');
fs.writeFileSync('aa.json', JSON.stringify(tale));
