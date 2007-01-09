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
 

let load_player path = 
  let lower = load_md3_file (path ^ "lower.md3") in
  let upper = load_md3_file (path ^ "upper.md3") in
  let head = load_md3_file (path ^ "head.md3") in
    {lower=lower;upper=upper;head=head;};;

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

