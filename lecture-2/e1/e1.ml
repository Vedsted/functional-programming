
(* Find most significant bit - Dividing by 2*)
let rec msb i =     
    if i = 0
    then 0
    else 1 + msb (i / 2);; 


(* Find most significant bit - Using lsr *)
let rec msb2 i = 
    if i = 0
    then 0
    else 1 + msb2 (i lsr 1);; 


(* Length of list *)
let rec length l = match l with
    | [] -> 0
    | elem::elems -> 1 + length elems;;
(* Elem is the first element *)
(* Elems is the rest of the list *)


