import {ISuperAnimation, ISuperImage, ISuperText, ITrigger} from "../complete";

export interface IBuff{
  name: ISuperText,
  description: ISuperText,
// values exist so that there do not have to be more types of buffs only because of differing strngth/parameters
  values: ({})[],
  graphics:{
    imgIcon: ISuperImage,
    imgField: ISuperImage,
    applyAnimation: ISuperAnimation,
    ticAnimation: ISuperAnimation,
    dissipateAnimation: ISuperAnimation,
    purgeAnimation: ISuperAnimation,
    ambientAnimation: ISuperAnimation
  },
//  implicitTriggers are a duplicity, but this is how buffs will be stored in storage
//  -> easy compilation, easy validation
  implicitTriggers: ITrigger[]
}
