
(* Sum of list *)
let rec sumList l = match l with 
    | [] -> 0
    | elem::elems -> elem + sumList elems;;

(* QCheck test *)
open QCheck;;

let sumListTest = Test.make 
                        ~name:"sum_list_test" 
                        ~count:10000 
                        (pair (list small_int) (list small_int))
                        (fun (l1, l2) -> sumList (l1 @ l2) = (sumList l1 + sumList l2));;

let _ = QCheck_runner.run_tests ~verbose:true [sumListTest];;