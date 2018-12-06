import {ISuperMember} from '../complete';
import {IAiType} from '../storage_identifiers';

export interface IAi{
  name: IAiType,
  agressivness: number,
  target: ISuperMember,
  // mode: "KING_OF_THE_HILL",
  eraticity: number
//  and more ai parameters
}
