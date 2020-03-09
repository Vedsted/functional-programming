type key = string
type value = int
type dictionary = key -> value
let empty key = 0
let add dict key value = fun key' -> if key=key' then value else dict key'
let find dict key = dict key
