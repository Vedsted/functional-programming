(* 
    Exercise 1 

    Consider the module below implementing (string,int) dictionaries as in Hickey, exercise 3.6.

    Write an interface for the module, such that the dictionary type is abstract (hidden) to outsiders.
*)

let dict = Dict.empty;;
let dict = Dict.add dict "myKey" 42 ;;
Dict.find dict "myKey";;

