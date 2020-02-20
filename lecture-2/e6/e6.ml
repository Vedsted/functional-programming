open QCheck;;

(* Exercise 6 *)


let int64_test = Test.make 
                        ~name:"int64_test" 
                        ~count:100 
                        int
                        (fun i -> i = Int64.to_int (Int64.of_int i));;
(* Test Pass*)

let int32_test = Test.make 
                        ~name:"int32_test" 
                        ~count:100 
                        int
                        (fun i -> i = Int32.to_int (Int32.of_int i));;
(* Test fail due to overflow*)

let intString_test = Test.make 
                        ~name:"intString_test" 
                        ~count:100 
                        int
                        (fun i -> i = int_of_string (string_of_int i));;
(* Test Pass*)

let _ = QCheck_runner.run_tests ~verbose:true [int64_test; int32_test; intString_test];;