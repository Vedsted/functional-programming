import * as fc from 'fast-check';
import { reverse } from '../src/reverse';

// (list int) (fun i -> reverse i = List.rev i);;
// (list int) (fun i -> i = reverse (reverse i));;
// (pair (list int) int) (fun (l, i) -> reverse (i::l) = (reverse l)@[i]);;


describe('reverse', () => {
    it('should be the same as source when reversed twice', () => {
        fc.assert(
            fc.property(fc.array(fc.integer()), data => {
                let processed = reverse(reverse(data)); 
                processed.forEach((val, i) => {
                    expect(val==data[i]).toBeTruthy();
                })
            })
        );
    });

    it('Should be the same length as source', () => {
        fc.assert(
            fc.property(fc.array(fc.integer()).noShrink(), data => {
                expect(reverse(data)).toHaveLength(data.length)
            })
        )
    });

    it('Should be the same when int is added to the front before the list is reversed as when added to the end after', () => {
        fc.assert(
            fc.property(fc.array(fc.integer()), fc.integer(), (data, i) => {
                // add to front after reversing
                let r1 = reverse(data);
                r1.push(i);

                // add to back before reversing
                let r2 = reverse([i, ...data]);

                r1.forEach( (e,i) => {
                    expect(e).toEqual(r2[i]);
                })

            })
        );
    });
});

fc.statistics(
    fc.float(),
    v => v < 0.5 ? 'Less than 0.5' : 'More or equal to 0.5',
    {numRuns: 10000, logger: console.log}
);

