(* Exercise 5 *)

(* Part A. -  Merge two ordered lists*)
let rec merge list1 list2 = match (list1, list2) with
    | ([], []) -> []
    | (e::l, []) -> list1
    | ([], e::l) -> list2
    | (e1::l1, e2::l2) -> match (e1 <= e2) with
                            | true -> e1::merge l1 list2
                            | false -> e2::merge list1 l2;;

(* QCheck test *)
open QCheck;;

let mergeTest = Test.make 
                        ~name:"merge_lists_test" 
                        ~count:10000 
                        (pair (list int) (list int))
                        (fun (l1, l2) -> merge (List.sort compare l1) (List.sort compare l2) = List.sort compare (l1@l2));;

let _ = QCheck_runner.run_tests ~verbose:true [mergeTest];;