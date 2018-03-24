import {IOperationType} from "../storage_identifiers";
import {ISuperMember, ISuperVariable} from "../complete";

export interface IMember{
//  it is basicly function on predefined variables
  operationType: IOperationType,
  "submembers": [
//    there will be accepted the following: variable ids, member ids.
//    Should we accept even full members?
//    PRO: json can be easily read by human
//    CON: structural complexity, harder validation
    ISuperMember | ISuperVariable
  ]
}
