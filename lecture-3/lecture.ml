(* Lecture - 3 *)


(* 1.a *)
type aexp =
  | X
  | Lit of int
  | Plus of aexp * aexp
  | Times of aexp * aexp
;;


let mytree = Plus (Lit 1, Times (X, Lit 3));;

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




(* 2 *)
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





open QCheck;;

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


let mygen2 = Gen.oneofl (
    [1;0;-1;max_int;min_int]@
    Gen.generate ~n:10 Gen.small_signed_int@
    Gen.generate ~n:10 Gen.int
);;

Gen.generate1 mygen;