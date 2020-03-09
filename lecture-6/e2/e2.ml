open QCheck
(***********

    Exercise 2:

    Part A.
    Consider the following recursive function. 
    Discuss whether it requires |xs| or constant stack space, i.e., is it "tail recursive"?
*)

let rec member xs y = match xs with
  | [] -> false
  | x::xs -> x=y || member xs y
;;    

(*
    Part B. 
    
    Check your answer to (a.) by using
        
       Gen.list_size : int Gen.t -> 'a Gen.t -> 'a list Gen.t
    
    For example, this generates a 1.000.000 element list:

        Gen.(generate1 (list_size (int_bound 1_000_000) small_int));;
*)
let myList = Gen.(generate1 (list_size (int_bound 1_000_000) small_signed_int));;
let _ = member myList 5000;; (* -> false *)


(*
    Part C. 
    
    Consider the following recursive functions below:

        let rec fac n = match n with
          | 0 -> 1
          | _ -> n * fac (n-1)

        let rec reverse xs = match xs with
          | [] -> []
          | x::xs -> (reverse xs) @ [x]        

    Both are non-tail recursive: fac requires n stack frames and reverse requires |xs| stack frames 
    (and even has quadratic time complexity).

    Write equivalent tail-recursive versions using an accumulator, and requiring only constant stack space.

    Test your code for agreement with property-based tests.

    Check that the new versions do not run out of stack space for large input.
*)

let fac n = 
    let rec f n acc = match n with
      | 0 -> acc
      | _ -> f (n-1) (n*acc)
    in f n 1
;;
let t_fac = Test.make ~count:500 ~name:"Factorial test" small_signed_int (fun i -> let _ = fac i in true);;
let _ = QCheck_runner.run_tests ~verbose:true [t_fac];;


let reverse xs = 
    let rec r xs acc= match xs with
      | [] -> acc
      | x::xs -> r xs (x::acc)
    in r xs []
;;
let t_rev = Test.make ~count:500 ~name:"Reverse test" (list small_signed_int) (fun i -> reverse i = List.rev i);;
let t_rev2 = Test.make ~count:500 ~name:"Reverse test2" (list small_signed_int) (fun i -> i = reverse (reverse i));;
let t_rev3 = Test.make ~count:500 ~name:"Reverse test2" (pair (list small_signed_int) int) (fun (l, i) -> reverse (i::l) = (reverse l)@[i]);;
let _ = QCheck_runner.run_tests ~verbose:true [t_rev; t_rev2; t_rev3];;