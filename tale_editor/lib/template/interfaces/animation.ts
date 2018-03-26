import {IAnimationType} from "../storage_identifiers";

export interface IAnimation{
//  type = fade, move, accelerated move, desc. move, ascention, ...
  type: IAnimationType,
  defaultColors: [string],
  defaultImgSize: 100,
  defaultFontSize: 12,
  defaultOpacity: 80,
  delayInMs: 200,
  animationTimeInMs: 500
//  thanks to delay and animation time, these animations are ment to be composed into more complete animations
//  e.g.: fireball will have 3 components - fireball flying toward target, explosion and number of dmg dealt.
}
