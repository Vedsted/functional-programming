import * as L from 'list';

export class ListWrapper {
    
    public list: L.List<number>;

    constructor(l: number[] = []){
        this.list = L.from(l);
    }   
}