(* 
    Exercise 2 

    a. Fix myshr so that it doesn't make QCheck loop (Ctrl-C stops it):

        let myshr i = Iter.return (i/2);;
        let t = Test.make (set_shrink myshr int) (fun i -> false);;
        QCheck_runner.run_tests [t];;
*)

open QCheck;;

let myshr i = match i with
    | 0 -> Iter.empty
    | _ -> Iter.return (i/2);;

let t = Test.make (set_shrink myshr int) (fun i -> false);;
QCheck_runner.run_tests [t];;

(* 
    Part B:
    Try the above on other false properties, e.g., (fun i -> i < 432) 
    How does it behave on different runs? Can you improve the shrinking strategy?
*)

let myshr i = match i, (i<(432*2)) with
    | 0,_ -> Iter.empty
    | _,false -> Iter.return (i/2)
    | _,true -> Iter.return (i-10);;

let myshr2 i = match i with
    | 0 -> Iter.empty
    | i when i>10000 -> Iter.return (i/10)
    | i when i>864 -> Iter.return (i/2)
    | i when i>864 -> Iter.return (i/2)
    | _ -> Iter.empty;;

let myshr3 i = Iter.append (myshr i) (Shrink.int i) ;;

let t = Test.make (set_shrink myshr int) (fun i -> i < 432);;
QCheck_runner.run_tests [t];;
