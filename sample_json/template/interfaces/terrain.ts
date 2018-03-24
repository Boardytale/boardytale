import {ISuperText, ISuperImage} from '../complete';
import {ITerrainId} from "../storage_identifiers";

export interface ITerrain{
  name: ISuperText,
      description: ISuperText,
//  to enable terrain mechanics on custom terrains:
//  e.g.: magical forrest river will have ids of forest and river, so forest and river mechanics will work,
//  but you can add your own
        terrainGroups: [ITerrainId],
        textures:[ISuperImage],
//  which kind of projectiles or other it blocks
        barrier: {
        linear: Boolean,
            ballistic: Boolean,
            occurrence: Boolean,
            unit: Boolean,
            vision: Boolean
    },
    defaultStepCost: number
}