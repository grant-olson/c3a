(*
Player model is build up of 3 md3s.  THis will probably be a class (once I learn how classes work!)
*)

open Md3;;

type player = {lower:md3;upper:md3;head:md3;}

type animation_state = {time_to_advance:float;
                   leg_start:int;
                   leg_stop:int;
                   leg_position:int;
                   torso_start:int;
                   torso_stop:int;
                   torso_position:int;
                   frame_rate:float; }


let draw_player p weapon state =
  let lower_tag_set = Array.get p.lower.tags state.leg_position in
  let lower_tag = Array.get lower_tag_set 0 in
  let lower_matrix = tag_to_matrix lower_tag in
  let upper_tag_set = Array.get p.upper.tags state.torso_position in
  let upper_head_tag = Array.get upper_tag_set 1 in
  let head_matrix = tag_to_matrix upper_head_tag in
  let weapon_tag = Array.get upper_tag_set 0 in
  let weapon_matrix = tag_to_matrix weapon_tag in
    GlMat.push();
    draw_md3 p.lower state.leg_position;
    GlMat.mult lower_matrix;

    draw_md3 p.upper state.torso_position;

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

let init_animation_state leg_start leg_stop torso_start torso_stop fps =
  let frame_rate = 1.0 /. (float_of_int fps) in
  let update_time = frame_rate +. (Unix.gettimeofday ()) in
    {time_to_advance=update_time;leg_start=leg_start;leg_stop=leg_stop;
     leg_position=leg_start;torso_start=torso_start;torso_stop=torso_stop;
     torso_position=torso_start;frame_rate=frame_rate};;

let update_animation_state cur_time cur_state =
  if
    cur_time > cur_state.time_to_advance
  then
    let tta = cur_state.time_to_advance +. cur_state.frame_rate in
    let next_leg = (if cur_state.leg_position = cur_state.leg_stop
      then cur_state.leg_start else cur_state.leg_position + 1) in
    let next_torso = (if cur_state.torso_position = cur_state.torso_stop
      then cur_state.torso_start else cur_state.torso_position + 1) in
      {time_to_advance=tta;leg_start=cur_state.leg_start;
       leg_stop=cur_state.leg_stop;leg_position=next_leg;
       torso_start=cur_state.torso_start;torso_stop=cur_state.torso_stop;
       torso_position=next_torso;frame_rate=cur_state.frame_rate;}
  else
    cur_state;;
