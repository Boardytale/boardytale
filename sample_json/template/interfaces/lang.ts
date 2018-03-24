import {ILangId} from "../storage_identifiers";

export interface ILang{
    lang: ILangId,
    strings: {
        string: string
    }
}