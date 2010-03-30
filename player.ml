(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(*
Player model is build up of 3 md3s.  THis will probably be a class (once I learn how classes work!)
*)

open Md3;;

type player = {lower:md3;upper:md3;head:md3;}

type anim_state = {time_to_advance:float;
                   start_pos:int;
                   end_pos:int;
                   loop_pos:int;
                   current_pos:int;
                   frame_rate:float;
                  }

               

type player_anim_state = {leg:anim_state;torso:anim_state;}


let draw_player p weapon state =
  let lower_tag = Md3.get_tag "tag_torso" p.lower state.leg.current_pos in
  let lower_matrix = tag_to_matrix lower_tag in
  let lower_frame = Array.get p.lower.frames state.leg.current_pos in
  let upper_head_tag = Md3.get_tag "tag_head" p.upper state.torso.current_pos in
  let head_matrix = tag_to_matrix upper_head_tag in
  let weapon_tag = Md3.get_tag "tag_weapon" p.upper state.torso.current_pos in
  let weapon_matrix = tag_to_matrix weapon_tag in
    GlMat.push();
    GlMat.translate ~z:(-. lower_frame.min_bounds.z) ();
    draw_md3 p.lower state.leg.current_pos;
    GlMat.mult lower_matrix;

    draw_md3 p.upper state.torso.current_pos;

    GlMat.push();
    GlMat.mult weapon_matrix;
    draw_md3 weapon 0;
    GlMat.pop();

    GlMat.mult head_matrix;
    draw_md3 p.head 0;
   
    GlMat.pop();;
 

(*
  Quake Models may have alternate version of lower resolution,
  if a full res model is "upper.md3" there may be "upper_1.md3" and 
  "upper_2.md3" which become progressively less detailed.

  For chess, level one seems to be good.  We're using way more players
  than a normal quake level.
*)
let load_player preferred_detail_level path =
  let preferred_detail_ext =
    match preferred_detail_level with
        1 -> "_1"
      | 2 -> "_2"
      | _ -> ""
  in
  let file_exists fname =
    try
      let f = open_in_bin fname in
      close_in f;
      true
    with
      Sys_error a -> false
  in
  let load path part =
    let default_file = path ^ part ^ ".md3" in
    let preferred_file = path ^ part ^ preferred_detail_ext ^ ".md3" in
    let filename =
      if file_exists preferred_file then preferred_file else default_file
    in
    Printf.printf "Loading %s\n" filename;
    flush stdout;
    load_md3_file filename
  in
  let lower = load path "lower" in
  let upper = load path "upper" in
  let head = load path "head" in
    {lower=lower;upper=upper;head=head;};;

let load_player = load_player 1

(* animation operations *)

let init_anim_state start stop loop fps =
  let frame_rate = 1.0 /. (float_of_int fps) in
  let update_time = frame_rate +. (Unix.gettimeofday ()) in
    {time_to_advance=update_time;start_pos=start;end_pos=stop;
     loop_pos=loop;current_pos=start;frame_rate=frame_rate};;

let init_player_anim_state (lstart,lstop,lloop,lfps)
                           (tstart,tstop,tloop,tfps) =
  let leg_state = init_anim_state lstart lstop lloop lfps in
  let torso_state = init_anim_state tstart tstop tloop tfps in
    {leg=leg_state;torso=torso_state;};;

let rec update_anim_state cur_time cur_state =
  if
    cur_time > cur_state.time_to_advance
  then
    let tta = cur_state.time_to_advance +. cur_state.frame_rate in
    let next_frame = (if cur_state.current_pos = cur_state.end_pos
      then cur_state.loop_pos else cur_state.current_pos + 1) in
      update_anim_state cur_time {time_to_advance=tta;
                                  start_pos=cur_state.start_pos;
                                  end_pos=cur_state.end_pos;
                                  loop_pos=cur_state.loop_pos;
                                  current_pos=next_frame;
                                  frame_rate=cur_state.frame_rate;}
  else
    cur_state;;

let update_player_anim_state cur_time cur_state =
  let leg_state = update_anim_state cur_time cur_state.leg in
  let torso_state = update_anim_state cur_time cur_state.torso in
    {leg=leg_state;torso=torso_state;};;

let skin_player player =
  Md3.skin_md3 player.lower;
  Md3.skin_md3 player.upper;
  Md3.skin_md3 player.head

let reskin_player assoc_list player =
  let new_lower = Md3.reskin_md3 assoc_list player.lower in
  let new_upper = Md3.reskin_md3 assoc_list player.upper in
  let new_head = Md3.reskin_md3 assoc_list player.head in
    {lower=new_lower;upper=new_upper;head=new_head}
