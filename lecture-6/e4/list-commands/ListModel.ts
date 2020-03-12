import fc from 'fast-check';
import {ListWrapper} from '../src/ListWrapper';
import { AddCommand } from './AddCommand';
import { RemoveCommand } from './RemoveCommand';

export class ListModel {
    list: number[];

    constructor(l: number[] = []){
        this.list = l;
    }

    add = (element: number) => {
        this.list.push(element);
    }
    remove = (index: number) => {
            this.list.splice(index,1);
    }
}

export type ListCommand = fc.Command<ListModel, ListWrapper>;

export const CommandGenerator = fc.commands([
    fc.integer().map(i => new AddCommand(i)),
    fc.nat().map(v => new RemoveCommand(v))
]);