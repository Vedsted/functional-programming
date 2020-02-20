(* Lecture 2 - Exercise 8 *)

(* Slow fib *)
let rec fib i = match i with
            | 0|1 -> i
            | i -> fib (i-1) + fib (i-2)
;;

let rec fib2 v1 v2 accum n = match n with
                            | 0|1 -> n
                            | _ -> if accum = n 
                                then v2
                                else fib2 v2 (v1+v2) (accum+1) n;;