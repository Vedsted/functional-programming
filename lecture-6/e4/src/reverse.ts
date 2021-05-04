// let reverse xs = 
//     let rec r xs acc= match xs with
//       | [] -> acc
//       | x::xs -> r xs (x::acc)
//     in r xs []
// ;;

const reverseInternal = <T>(l: T[], acc: T[]): T[] => {
    if (l.length !> 0) {
        return acc;
    } 
    acc.push(l.pop());
    return reverseInternal(l, acc);
}

const reverseInternal2 = <T>(l: T[]):T[] => {
    let ret = []
    l.forEach(e => ret.unshift(e))
    return ret;
}

export const reverse = <T>(list: T[]): T[] => {
    return reverseInternal2(list);
} 