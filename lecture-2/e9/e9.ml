(*
    Exercise 9
    
    Implement a dictionary 
*)

let empty = [];;

let rec add dict
            key
            value = match dict with
                    | [] -> (key, value)::dict
                    | (k, v)::l -> match (key = k) with
                                | true -> (key, value)::l
                                | false -> (k, v)::add l key value
;;

let rec find dict
            key = match dict with
                | [] -> Error "Key not found in dictionary"
                | (k,v)::l -> match (key = k) with
                            | true -> v
                            | false -> find l key
;;




(* ?????? *)
let empty k = 0;;
let add d k v = fun k' -> if k = k' then v else d k';;
let find d k = d k;;