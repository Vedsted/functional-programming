(*********************

    Exercise 5

*********************)

(*
    Part A:
    Clone or download the quickcheck code from here https://github.com/jmid/qc-ptrees

    A:
        'git clone https://github.com/jmid/qc-ptrees'
*)

(*
    Part B:
    Compile (run make old) and run the code (run ./qctest.native) to ensure that you can recreate the issue.

    A:
        'cd qc-ptrees && make old && ./qctest.native'
*)

(*
    Part C:
    Extend the testsuite with tests for the following API operations:

        val is_empty : t -> bool
        val diff     : t -> t -> t
        val equal    : t -> t -> bool
        val subset   : t -> t -> bool
    
    (For which ones is it necessary to extend the generator?)
*)