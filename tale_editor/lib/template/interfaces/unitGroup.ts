import {ISuperAiPlayer, ISuperText} from "../complete";
import {IUnit} from "./unit";

export interface IUnitGroup{
  name: ISuperText,
  units: (IUnit | string)[]
  aiPlayer: ISuperAiPlayer,
  aiSettings: {
//    aiSpecific
//    priorities, aggresivness, ...
  }
}
