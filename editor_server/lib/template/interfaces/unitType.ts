import {ISuperText, ISuperImage, ISuperRace, ISuperAbility} from '../complete';

//@unitType
export interface IUnitType {
    name: ISuperText,
    iconImg: ISuperImage,
    unitImgs: ISuperImage[],
    race: ISuperRace,
    hp: number,
    dmg: number[],
    armor: number,
    steps: number,
    range: number,
    bounty: number,
//  omitted will default to first ability of given type from "abilities". If there is not such ability -> validation error
//  space for saving control settings (defaultShiftAbility,...)
    defaultAttackAbility: ISuperAbility,
    defaultMoveAbility: ISuperAbility,
    defaultCtrlAbility: ISuperAbility,
    defaultShiftAbility: ISuperAbility,
    abilities: ISuperAbility[]
}
