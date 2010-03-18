type computer_opponent = {in_chan:in_channel;out_chan:out_channel;mutable text_acc:string}
    
let send_output_text opp text =
  let s_with_linefeed = text ^ "\r\n" in
    Printf.printf "%s\n" text;
    output_string opp.out_chan s_with_linefeed;
    flush opp.out_chan

let get_white_move s =
  Scanf.sscanf s
    "%i. %s"
    (fun _ white_move -> white_move)

let get_black_move s =
  Scanf.sscanf s
    "%i. ... %s"
    (fun _ black_move -> black_move)

let issue_move opp move =
  send_output_text opp move

let get_opponents_move opp =
  let l1 = input_line opp.in_chan in
  let l2 = input_line opp.in_chan in
  let l3 = input_line opp.in_chan in
  let white_move = get_white_move l1 in
  let black_move = get_black_move l2 in
      Printf.printf "White: %s\nBlack: %s\n" white_move black_move;
      flush stdout;
      black_move
    
let create_opponent cmd =
  let in_chan,out_chan = Unix.open_process cmd in
    {in_chan=in_chan;out_chan=out_chan;text_acc=""}

let strip_headers in_chan =
  let tmpStr = String.create 2048 in
    ignore(input in_chan tmpStr 0 2048)

let init_opponent cmd =
  let opp = create_opponent cmd in
    strip_headers opp.in_chan;
    send_output_text opp "xboard";
    send_output_text opp "new";
    opp
