export {
    IFieldId,
    IUnitTypeId,
    IAbilityId,
    IActionId,
    IImageId,
    IAnimationId,
    IAiId,
    IAiPlayerId,
    IDialogId,
    IVariableId,
    IMemberId,
    ITerrainId,
    IRaceId,
    ITextId,
    IBuffId
} from './storage_identifiers';
//@marker1
import {
    IFieldId,
    IUnitTypeId,
    IAbilityId,
    IActionId,
    IImageId,
    IAnimationId,
    IAiId,
    IAiPlayerId,
    IDialogId,
    IVariableId,
    IMemberId,
    ITerrainId,
    IRaceId,
    ITextId,
    IBuffId,
    IFavouriteControls,
    IEffectType,
    ITargetType,
    IActionType,
    IAnimationType,
    IAiType,
    IAttitudeTowardsHumans,
    IVariableType,
    IOperationType,
    IEventType,
    ILangId,
} from './storage_identifiers';

//@marker1
export {IMap} from 'interfaces/map';
export {ITerrain} from 'interfaces/terrain';
export {IField} from 'interfaces/field';
export {IRace} from 'interfaces/race';
export {IUnit} from 'interfaces/unit';
export {IUnitGroup} from 'interfaces/unitGroup';
export {IBuff} from 'interfaces/buff';
export {IUnitType} from 'interfaces/unitType';
export {IAbility} from 'interfaces/ability';
export {IAction} from 'interfaces/action';
export {IImage} from 'interfaces/image';
export {IAnimation} from 'interfaces/animation';
export {IAi} from 'interfaces/ai';
export {IAiPlayer} from 'interfaces/aiPlayer';
export {IDialog} from 'interfaces/dialog';
export {IVariable} from 'interfaces/variable';
export {IMember} from 'interfaces/member';
export {ITrigger} from 'interfaces/trigger';
export {IHero} from 'interfaces/hero';
export {ILang} from 'interfaces/lang';
//@marker1
import {IMap} from 'interfaces/map';
import {ITerrain} from 'interfaces/terrain';
import {IField} from 'interfaces/field';
import {IRace} from 'interfaces/race';
import {IUnit} from 'interfaces/unit';
import {IUnitGroup} from 'interfaces/unitGroup';
import {IBuff} from 'interfaces/buff';
import {IUnitType} from 'interfaces/unitType';
import {IAbility} from 'interfaces/ability';
import {IAction} from 'interfaces/action';
import {IImage} from 'interfaces/image';
import {IAnimation} from 'interfaces/animation';
import {IAi} from 'interfaces/ai';
import {IAiPlayer} from 'interfaces/aiPlayer';
import {IDialog} from 'interfaces/dialog';
import {IVariable} from 'interfaces/variable';
import {IMember} from 'interfaces/member';
import {ITrigger} from 'interfaces/trigger';
import {IHero} from 'interfaces/hero';
import {ILang} from 'interfaces/lang';
//@marker1
export interface ITale {
    taleId: string,
    taleName: ISuperText,
    taleVersion: number,
    defaultDifficulty: number,
    compilerVersion: string,
    map: IMap,


    units: { [key: string]: IUnit },
    unitGroups: { [key: string]: IUnitGroup },
    unitTypes: { [key: string]: IUnitType },
    abilities: { [key: string]: IAbility },
    actions: { [key: string]: IAction },
    images: { [key: string]: IImage },
    animations: { [key: string]: IAnimation },
    ais: { [key: string]: IAi },
    aiPlayers: { [key: string]: IAiPlayer },
    dialogs: { [key: string]: IDialog },
    variables: { [key: string]: IVariable },
    members: { [key: string]: IMember },
    langs: ILang[],
// events: { [key: string]: IEvent },
// sounds: { [key: string]: ISound },

    triggers: ITrigger[],
    heroes: IHero[],

    other: {
        //    hotfix-stuff
    },
}

export type ISuperRace = IRace | IRaceId | string;
export type ISuperTerrain = ITerrain | ITerrainId | string;
export type ISuperField = IField | IFieldId | string;
export type ISuperImage = IImage | IImageId | string;
export type ISuperMember = IMember | IMemberId | string;
export type ISuperText = ITextId | string;
export type ISuperAbility = IAbilityId | IAbility | string;
export type ISuperDialog = IDialogId | IDialog | string;
export type ISuperAction = IActionId | IAction | string;
export type ISuperAi = IAiId | IAi | string;
export type ISuperUnitType = IUnitTypeId | IUnitType | string;
export type ISuperBuff = IBuffId | IBuff | string;
export type ISuperUnitGroup = IUnitGroup | string;
export type ISuperAiPlayer = IAiPlayer | IAiPlayerId | string;
export type ISuperAnimation = IAnimation | IAnimationId | string;
export type ISuperVariable = IVariable | IVariableId | string;
// export type ISuperEvent        = IEventId | IEvent | string;


