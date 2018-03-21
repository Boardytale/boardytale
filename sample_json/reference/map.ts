import {IField, IFieldType} from './complete';

export interface IMap {
    width: number;
    fields: { [key: string]: IField | IFieldType; }
}