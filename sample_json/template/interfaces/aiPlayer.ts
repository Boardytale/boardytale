import {ISuperAi, ISuperText} from "../complete";
import {IAttitudeTowardsHumans} from "../storage_identifiers";

export interface IAiPlayer{
  name: ISuperText,
  description: ISuperText,
  ai: ISuperAi,
  attitudeTowardsHumans: IAttitudeTowardsHumans,
  enemies: [IAiPlayer],
  allies: [IAiPlayer]
}
