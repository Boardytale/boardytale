import {ISuperAbility, ISuperBuff} from "../complete";

export interface IHero{
  x: number,
  y: number,
// default full hp
  currentHP: number,
// default full steps
  currentSteps: number,
  buffs: ISuperBuff[],
  additionalAbilities: ISuperAbility[],
}