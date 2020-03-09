(*********************

    Exercise 6

    (for the brave)

*********************)


(*
    Part A:
    Formulate in words a shrinking strategy for lists. (How would you combine it with the element shrinker?)
*)

(*
    Part B:
    Implement the strategy and test how well it works (how much it simplifies, 
    how many steps it uses) compared to the builtin list shrinker, 
    for some false properties over lists, e.g., 
    
        (fun es -> List.reverse es = es) and (fun es -> List.length es < 42)
*)