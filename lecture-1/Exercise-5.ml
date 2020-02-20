let cube = fun x -> x * x * x;;

let isEven = fun a -> (a mod 2) == 0;;

let isEven2 a = 
    match a mod 2 with
        0 -> true
    |   1 -> false
    |   _ -> raise (Invalid_argument "isEven2");;

let quadroot = fun x -> sqrt(sqrt x);;