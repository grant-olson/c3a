type computer_opponent = {in_chan:in_channel;out_chan:out_channel;mutable text_acc:string}

let accumulate_input_text opp =
  let in_chan = opp.in_chan in
  let len = in_channel_length in_chan in
  let tmpStr = String.create len in
  let _ = really_input in_chan tmpStr 0 len in
  let combined_text = opp.text_acc ^ tmpStr in
    opp.text_acc <- combined_text
    
let send_output_text opp text =
  let s_with_linefeed = text ^ "\r\n" in
    Printf.printf "%s\n" text;
    output_string opp.out_chan s_with_linefeed;
    flush opp.out_chan

let get_move s =
  flush stdout;
  Scanf.sscanf s
    "%i. %s\r\n%i. ... %s\r\nMy move is: %s\r\n"
    (fun _ white_move _ black_move _ -> white_move,black_move)

let issue_move opp move =
  send_output_text opp move

let get_opponents_move opp =
  let _ = accumulate_input_text opp in
  try
    let white_move,black_move = get_move opp.text_acc in
      opp.text_acc <- "";
      Printf.printf "... %s\n" black_move;
      flush stdout;
      Some black_move
  with
    End_of_file -> None
      

let create_opponent cmd =
  let in_chan,out_chan = Unix.open_process cmd in
    {in_chan=in_chan;out_chan=out_chan;text_acc=""}

let init_opponent cmd =
  let opp = create_opponent cmd in
    ignore(input_line opp.in_chan);
    ignore(input_line opp.in_chan);
    send_output_text opp "xboard";
    send_output_text opp "new";
    opp
