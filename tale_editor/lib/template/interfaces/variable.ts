//@variable
import {IVariableType} from "../storage_identifiers";
import {ISuperMember} from "../complete";

export interface IVariable{
  name: string,
//  bool, string, int, real, field, area, unit, units, player, players, ability, buff, event, condition, action, ai, unitGroup, animation, image, time and probably much more
//  acceptable types will be stored somewhere handy with predefined accesors (to form $members)
  type: IVariableType,
  "initialValue": ISuperMember
}
