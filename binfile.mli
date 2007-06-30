val int32_of_int : int -> int32
val in_char_as_int32 : in_channel -> int32
val in_char : in_channel -> int
val in_word_as_int32 : in_channel -> int32
val in_word : in_channel -> int
val in_signed_word : in_channel -> int
val in_dword_as_int32 : in_channel -> int32
val in_dword : in_channel -> int
val in_single : in_channel -> float
val in_string : in_channel -> int -> string
val in_array : 'a -> int -> ('a -> 'b) -> 'b array
val in_array_array : 'a -> int -> int -> ('a -> 'b) -> 'b array array
