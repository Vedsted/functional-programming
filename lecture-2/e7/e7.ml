open QCheck;;

(* Exercise 7 *)

(* 
    Part A.
    Write an implementation of Euclid's algorithm

    Peudo code:
     gcd( n , m ) =
        while m != 0
            if n > m
                n <- n - m
            else
                m <- m − n
        return n
*)
let rec eu_gcd x y = match x, y with
                | _, 0 -> x
                | x, y -> match (x > y) with
                            | true -> eu_gcd (x-y) y
                            | false -> eu_gcd x (y-x)
;;

(* 
    Part B.
    QuickCheck your implementation against Hickey's algorithm
*)
let rec gcd a b =
    let r = a mod b in
        if r = 0 then
            b
        else
            gcd b r
;;


let eu_gcd_test = Test.make
                        ~name:"eu_gcd_test"
                        ~count:10
                        (pair pos_int pos_int)
                        (fun (x, y) -> (eu_gcd x y) != 1)

let gcd_test = Test.make
                        ~name:"gcd_test"
                        ~count:10
                        (pair pos_int pos_int)
                        (fun (x, y) -> (gcd x y) != 1)

let euclid_test = Test.make 
                        ~name:"euclid_test" 
                        ~count:10
                        (pair pos_int pos_int)
                        (fun (x, y) -> (eu_gcd x y) = (gcd x y));;

let _ = QCheck_runner.run_tests ~verbose:true [ gcd_test];;
(*let _ = QCheck_runner.run_tests ~verbose:true [eu_gcd_test; gcd_test; euclid_test];;*)