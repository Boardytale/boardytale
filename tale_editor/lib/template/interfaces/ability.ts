import {ISuperMember, ISuperText, ISuperVariable} from "../complete";
import {IEffectType, IFavouriteControls, ITargetType} from "../storage_identifiers";

export interface IAbility{
    name: ISuperText,
    favouriteControls: IFavouriteControls,
    effects: [IEffectType],
    values: [ISuperMember|string|number|null],
    targetType: ITargetType,
    variablesFilled: [ISuperVariable]
}