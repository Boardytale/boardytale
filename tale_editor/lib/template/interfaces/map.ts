import {ISuperField, ISuperTerrain} from '../complete';

export interface IMap {
    width: number,
    height: number,
    baseTerrain: ISuperTerrain,
    fields: { [key: string]: ISuperField; }
}