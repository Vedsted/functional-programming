(*********************

    Exercise 3

    Consider the following test that uses the built-in pair generator and shrinker:

        let t = Test.make (pair small_nat small_nat) (fun (i,j) -> i+j = 0);;
        QCheck_runner.run_tests ~verbose:true [t];;
    
    Despite randomization QCheck's pair shrinker consistently produces the same reduced counterexample. Which? Why?

*********************)
open QCheck;;
let t = Test.make (pair small_nat small_nat) (fun (i,j) -> i+j = 0);;
QCheck_runner.run_tests ~verbose:true [t];;

(****
    counter example will always be: (0, 1) or (1, 0)

    The counter example is shrunck so that it is as simple as possible. In this case it would be: 0+1 != 0 OR 1+0 != 0 

****)