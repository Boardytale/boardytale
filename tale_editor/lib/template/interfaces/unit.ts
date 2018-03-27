import {ISuperAiPlayer, ISuperBuff, ISuperText, ISuperUnitGroup, ISuperUnitType} from "../complete";

export interface IUnit{
  name: ISuperText,
  unitType: ISuperUnitType,
// default full hp
  currentHP: number,
// default full steps
  currentSteps: number,
  buffs: ISuperBuff[],
//  duplicities: keep?
  unitGroup: ISuperUnitGroup,
  aiPlayer: ISuperAiPlayer,
}