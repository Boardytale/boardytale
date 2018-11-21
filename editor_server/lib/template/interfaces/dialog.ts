import {ISuperText, ISuperMember, ISuperAction, ISuperDialog} from '../complete';
//@dialog
export interface IDialog{
  title: "text_id52",
  text: "text_id63",
  options: [
    {
      buttonText: ISuperText,
      followupDialog: ISuperDialog,
//      conditions are simply members expected to evaluate as boolean
//      whether option is enabled
      optionCondition: ISuperMember,
      unconditionalActions: ISuperAction[],
      conditionalActions: ({
          condition: ISuperMember,
          actions: ISuperAction[]
      })[]
    }
  ]
}
