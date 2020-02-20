
(* Sum of list *)
let rec sumList l = match l with 
    | [] -> 0
    | elem::elems -> elem + sumList elems;;

sumList [2; 2; 1];; (* -> 5 *)
sumList [2; 2; 2; 2; 2];; (* -> 10 *)



(* Check is value is member of list -> using labels for function*)
let rec isMember ~number:a ~list:l = match l with 
    | [] -> false
    | elem::elems -> (elem = a) || isMember ~list:elems ~number:a
;;


let l = [2; 3; 5; 8];;

isMember 3 l;; (* -> true *)
isMember 4 l;; (* -> false *)
