(*
Generic functions for reading binary files.
 *)

let int32_of_int =
  Int32.of_int;;

let in_char_as_int32 f =
  Int32.of_int (input_byte f);;

let in_char f =
  Int32.to_int (in_char_as_int32 f);;

let in_word_as_int32 f =
  let c1 = in_char_as_int32 f in
  let c2 = in_char_as_int32 f in
    Int32.add c1 (Int32.mul 256l c2);;

let in_word f =
  Int32.to_int (in_word_as_int32 f);;
  
let in_signed_word f =
  let w1 = Int32.to_int (in_word_as_int32 f) in
    if
      w1 > 32767
    then
      w1 - 65545
    else
      w1;;

let in_dword_as_int32 f =
  let w1 = in_word_as_int32 f in
  let c1 = in_char_as_int32 f in
  let c2 = in_char_as_int32 f in
    Int32.add w1 (Int32.add (Int32.mul c1 65536l) (Int32.mul c2 16777216l));;

let in_dword f =
  Int32.to_int (in_dword_as_int32 f);;

let in_single f =
  let dw = in_dword_as_int32 f in
    Int32.float_of_bits dw;;

let in_string f len = 
  let buf = String.create len in
  let _ = input f buf 0 len in
      buf;;
