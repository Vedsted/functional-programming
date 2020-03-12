import {ListCommand, ListModel} from './ListModel';
import * as L from 'list';
import { ListWrapper } from '../src/ListWrapper';
import * as assert from 'assert';

export class RemoveCommand implements ListCommand{

    constructor(readonly indexToRemove: number){}

    check(m: Readonly<ListModel>): boolean {
        return m.list.length > 0;
    }
    
    run(m: ListModel, r: ListWrapper): void {
        

        let index = this.indexToRemove % L.length(r.list);

        r.list = L.remove(index,1, r.list);
        m.remove(index);

        assert.strictEqual(L.length(r.list), m.list.length);

        L.toArray(r.list).forEach( (e, i) => {
            assert.strictEqual(e, m.list[i]);
        })
       
    }
    
    toString(): string {
        return 'REMOVE'
    }


}