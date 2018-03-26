import {IEventType, IVariableId} from "../storage_identifiers";

export interface IEvent{
//  many different types, compiler and interpret must be ready for each one
  type: IEventType,
//  some predefined variables will be filled so later conditions and actions can work with them
  filledVariables: [IVariableId]
}
