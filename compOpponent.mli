type computer_opponent = {
  in_chan : in_channel;
  out_chan : out_channel;
  mutable text_acc : string;
}
val issue_move : computer_opponent -> string -> unit
val get_opponents_move : computer_opponent -> string option
val init_opponent : string -> computer_opponent
