import {IActionType} from '../storage_identifiers';
import {ISuperMember} from '../complete';

export interface IAction {
  actionType: IActionType,
  members: ISuperMember[]
}
