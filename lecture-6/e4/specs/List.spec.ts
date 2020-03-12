import fc from 'fast-check';
import { ListWrapper } from '../src/ListWrapper';
import { ListModel, CommandGenerator } from '../list-commands/ListModel';

describe('List', () => {
  it('should detect potential issues from an initial List', () =>
    fc.assert(
      fc.property(CommandGenerator, fc.array(fc.integer()), (commands, initialList) => {
        const real = new ListWrapper(initialList);
        const model = new ListModel(initialList);
        
        fc.modelRun(() => ({ model, real }), commands);
      }), {verbose: true, numRuns: 1000})
    );

  it('should detect potential issues from an empty List', () =>
    fc.assert(
      fc.property(CommandGenerator, commands => {
        const real = new ListWrapper();
        const model = new ListModel();
        
        fc.modelRun(() => ({ model, real }), commands);
      }), {verbose: true, numRuns: 1000})
    );
});