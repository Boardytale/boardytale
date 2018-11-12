import {ISuperTerrain, ISuperImage} from '../complete';

export interface IField {
  x: number,
  y: number,
  terrain: ISuperTerrain,
  height: number,
  customTexture: ISuperImage
}