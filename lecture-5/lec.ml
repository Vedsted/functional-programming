(* E1 *)

(*
    #require "ppx_deriving.show";;
*)

module H1 =
  struct
    type cmd =
      | Add of string * int
      | Remove of string
      | Find of string
      | Mem of string [@@deriving show]
  end
;;

module H2 =
  struct
    type cmd =
      | Add of string * int
      | Remove of string
      | Find of string
      | Mem of string [@@deriving show { with_path = false }]
  end
;;

H1.show_cmd (Add("Bob", 2));; (* -> string = "(H1.Add (\"Bob\", 2))" *)

H2.show_cmd (Add("Bob", 2));; (* -> string = "(Add (\"Bob\", 2))" *)


(*  
    E2:
    What property are we testing the hashtable for? Phrase it in your own words.

    State of the hashtable.
    State of the ht should change as expected.
*)

