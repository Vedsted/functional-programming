(* Lecture - 3 *)

(*#reqire "qcheck"*)
open QCheck;;

(* type needed for lecture 3 exercises *)
type aexp =
  | X
  | Lit of int
  | Plus of aexp * aexp
  | Times of aexp * aexp
;;

(* Example of aexp *)
let mytree = Plus (Lit 1, Times (X, Lit 3));;



(***************

    Exercise 1 

****************)

(* 
    Part A:
    Write a function size : aexp -> int that computes the size of an arithmetic expression.
*)

(* Count number of leafs in the tree *)
let rec size aexp = match aexp with
            | X | Lit _ -> 1
            | Plus (ae1, ae2) | Times (ae1, ae2) -> (size ae1) + (size ae2)
 
(* Count number of nodes in the tree *)
let rec size aexp = match aexp with
            | X | Lit _ -> 0
            | Plus (ae1, ae2) | Times (ae1, ae2) -> 1 + (size ae1) + (size ae2)

(* Count number of nodes and leafs in the tree *)
let rec size aexp = match aexp with
            | X | Lit _ -> 1
            | Plus (ae1, ae2) | Times (ae1, ae2) -> 1 + (size ae1) + (size ae2)


(* 
    Part B:
    Using size compute size statistics for the distribution of our generator of arithmetic expressions.
*)





(***************

    Exercise 2:

    The abstract machine from the slides operates over a list of instructions and a stack of integers.

****************)

let stack = []

type inst = 
    | Load
    | Push of int
    | Add 
    | Mult
;;


let rec compile aexp = match aexp with
    | X -> [Load]
    | Lit i -> [Push i]
    | Plus (e1, e2) -> (compile e1)@(compile e2)@[Add]
    | Times (e1, e2) -> (compile e1)@(compile e2)@[Mult]
;;


(* 
    Part A:
    Write an interpreter for the abstract machine, e.g., with signature  run : int -> inst list -> int list -> int 
    accepting an initial value for the x register, an instruction list, and an initial stack.

    Declare and throw a suitable exception in error cases.
*)
exception Stack_Empty;;

let rec run reg instList stack = 
    match instList with
    | [] -> stack
    | (inst::remainingInstructions) -> match inst with
                                    | Load -> reg::stack
                                    | Push i -> i::stack
                                    | Add -> (match stack with
                                            | [] -> raise Stack_Empty
                                            | e1::l1 -> match l1 with
                                                    | [] -> raise Stack_Empty
                                                    | e2::l2 -> run reg remainingInstructions ((e1+e2)::l2))
                                    | Mult -> (match stack with
                                            | [] -> raise Stack_Empty
                                            | e1::l1 -> match l1 with
                                                    | [] -> raise Stack_Empty
                                                    | e2::l2 -> run reg remainingInstructions ((e1*e2)::l2))
;;

exception Stack_missing_ints;;

let rec run2 reg instList stack = 
    match instList with
    | [] -> stack
    | (inst::remainingInstructions) -> match inst with
                                    | Load -> reg::stack
                                    | Push i -> i::stack
                                    | Add -> (match stack with
                                            | e1::e2::l -> run reg remainingInstructions ((e1+e2)::l)
                                            | _ -> raise Stack_missing_ints)
                                    | Mult -> (match stack with
                                            | e1::e2::l -> run reg remainingInstructions ((e1*e2)::l)
                                            | _ -> raise Stack_missing_ints)
;;

let rec run3 reg instList stack = 
    match instList, stack with
    | [], _ -> stack
    | Load::instLeft, _ -> reg::stack
    | Push i::instLeft, _ -> i::stack
    | Add::instLeft, e1::e2::l -> run reg instLeft ((e1+e2)::l)
    | Mult::instLeft, e1::e2::l -> run reg instLeft ((e1*e2)::l)
    | _, _ -> raise Stack_missing_ints 
;;



(*
    Part B:
    QuickCheck that evaluating and compiling+running agrees 
*)

(*
    Part C:
     Extend the previous exercise with subtraction
*)

(*
    Part D:
    QuickCheck your extension
*)




(***************

    Exercise 3:

    The default integer generator int primarily generates large integers.
    The small_signed_int generator on the other hand favors small numbers.

****************)


(*
    Part A:
    Program an alternative integer generator by combining different generators
    such that the result has a reasonable chance of generating both, 
    as well as corner cases such as -1, 0, 1, min_int, and max_int.
*)

let myIntGen = 
    let edgeCases = Gen.oneofl [1;0;-1;max_int;min_int] in
    Gen.frequency [
        (1, edgeCases);
        (3, small_signed_int.gen);
        (5, int.gen);
    ]
;;


(*
    Part B:
    Compute statistics for your generator's distribution and compare them
*)

let int_dist =
    let int_gen = set_stats [("myIntGen", (fun i -> i))] (make myIntGen) in
    Test.make ~count:10000 ~name:"true" int_gen (fun _ -> true)

let _ = QCheck_runner.run_tests ~verbose:true [int_dist];;



(***************

    Exercise 4:

    Use Gen.int_bound to write a generator representing a pair 
    of dices and compute statistics for their sum.

****************)

let dice_gen= 
    let g = Gen.map (fun i -> i+1) (Gen.int_bound 5) in 
    Gen.map2 (fun a b -> (a, b)) g g
;;

let dice_gen2 = Gen.map2 (fun a b -> (a+1, b+1)) (int_bound(5)).gen (int_bound(5)).gen;;


let die_roll_dist =
    let g = set_stats [("Dice Gen", (fun (a,b) -> a+b))] (make dice_gen) in
    Test.make ~count:10000 ~name:"true" g (fun _ -> true)
;;

let _ = QCheck_runner.run_tests ~verbose:true [die_roll_dist];;


(***************

    Exercise 5:

    int_of_string : string -> int attempts to parse an string as a number, 
    and throws an exception Failure "int_of_string" when it can't:

    # int_of_string "123";;
        - : int = 123
    # int_of_string "abc";;
        Exception: Failure "int_of_string".

    Write a wrapper my_int_of_string : string -> int option that calls int_of_string 
    and instead returns an option type representing whether the call went well.

****************)

exception No_int_in_string;;

type int_of_string_result =
    | ERROR
    | RESULT of int
;;

let my_int_of_string s = 
    try RESULT (int_of_string s)
    with No_int_in_string -> ERROR
;;


(***************

    Exercise 6:

    List.find_opt : ('a -> bool) -> 'a list -> 'a option returns an option type 
    representing whether a list contains an element satisfying a given property:
    
    # List.find_opt (fun e -> e>4) [2;3;5;0];;
    - : int option = Some 5
    # List.find_opt (fun e -> e>4) [2;3;0];;
    - : int option = None
    
    Write a wrapper my_list_find : ('a -> bool) -> 'a list -> 'a that calls 
    List.find_opt and instead returns the found element or throws exception Not_found.

****************)

let my_list_find exp list = match (List.find_opt exp list) with 
    | None -> raise Not_found 
    | Some i -> i 
;;



(***************

    Exercise 7:

    Red-Black Trees

****************)












(*
    Other stuff from lecture
*)

(* Gen one *)
Gen.generate1 Gen.int;;

(* Gen multiple *)
Gen.generate ~n:20 Gen.int;;

(* Create own gen *)
let mygen = Gen.oneofl ([
    1;
    0;
    -1;
    max_int;
    min_int;
    Gen.generate1 Gen.int
]);;




Gen.generate1 mygen;

