(*********************

    Exercise 4

*********************)


(*
    Part A:
    Formulate in words a more aggressive shrinking strategy for arithmetic expressions. 
    (If you were to simplify such test-input by hand how would you proceed?)

    Answer:
        for nodes = plus or times cut them and replace by Lit i
*)

(*
    Part B:
    Implement the strategy and test how well it works 
    (how much it simplifies, how many steps it uses, how consistent it is) 
    compared to the one I proposed for different false properties such as the following three:

        (fun (xval,e) -> interpret xval e = xval)
        (fun (xval,e) -> interpret xval (Plus(e,e)) = interpret xval e)
        (fun (xval,xval',e) -> interpret xval e = interpret xval' e)

    To make sure you are comparing the shrinkers over identical runs, use, e.g., QCheck_runner.set_seed : int -> unit
*)

open QCheck;;

type aexp =
  | X
  | Lit of int
  | Plus of aexp * aexp
  | Times of aexp * aexp

let rec interpret xval ae = match ae with
  | X -> xval
  | Lit i -> i
  | Plus (ae0, ae1) ->
    let v0 = interpret xval ae0 in
    let v1 = interpret xval ae1 in
    v0 + v1
  | Times (ae0, ae1) ->
    let v0 = interpret xval ae0 in
    let v1 = interpret xval ae1 in
    v0 * v1

let rec exp_to_string ae = match ae with
  | X -> "x"
  | Lit i -> string_of_int i
  | Plus (ae0, ae1) ->
    let s0 = exp_to_string ae0 in
    let s1 = exp_to_string ae1 in
    "(" ^ s0 ^ "+" ^ s1 ^ ")"
  | Times (ae0, ae1) ->
    let s0 = exp_to_string ae0 in
    let s1 = exp_to_string ae1 in
    "(" ^ s0 ^ "*" ^ s1 ^ ")"

let leafgen = Gen.oneof
                [Gen.return X;
                 Gen.map (fun i -> Lit i) Gen.int]

let mygen =
    let g = Gen.sized (Gen.fix (fun recgen n -> match n with
        | 0 -> leafgen
        | n ->
          Gen.oneof
	          [leafgen;
	           Gen.map2 (fun l r -> Plus(l,r)) (recgen(n/2)) (recgen(n/2));
	           Gen.map2 (fun l r -> Times(l,r)) (recgen(n/2)) (recgen(n/2)); ]))in 
    make ~print:exp_to_string g
;;



let t1 = Test.make (pair small_signed_int mygen) (fun (xval,e) -> interpret xval e = xval);;
let t2 = Test.make (pair small_signed_int mygen) (fun (xval,e) -> interpret xval (Plus(e,e)) = interpret xval e);;
let t3 = Test.make (triple small_signed_int small_signed_int mygen) (fun (xval,xval',e) -> interpret xval e = interpret xval' e);;

QCheck_runner.run_tests [t1; t2; t3];;