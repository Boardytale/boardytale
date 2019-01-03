import {IEventType} from "../storage_identifiers";
import {ISuperAction, ISuperMember} from "../complete";

export interface ITrigger{
    event: IEventType,
    condition: ISuperMember,
    actions: ISuperAction[]
}