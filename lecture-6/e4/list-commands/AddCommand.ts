import {ListCommand, ListModel} from './ListModel';
import * as L from 'list';
import { ListWrapper } from '../src/ListWrapper';
import * as assert from 'assert';

export class AddCommand implements ListCommand{
    constructor(readonly toAdd: number){}
    
    check(m: Readonly<ListModel>): boolean {
        return true;
    }

    run(m: ListModel, r: ListWrapper): void {
        
        r.list = L.append(this.toAdd, r.list);
        m.add(this.toAdd);

        L.toArray(r.list).forEach( (e, i) => {
            assert.strictEqual(e, m.list[i]);
        })
    }

    toString(): string {
        return 'ADD'
    }
}