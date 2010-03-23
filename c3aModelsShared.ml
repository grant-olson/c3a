(* Copyright 2007,2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* Shared code for the Quake 3 and open arena models *)

(* Utility routines to change info from the quake animation.cfg files
   to the format I use.  Notably, the numbers for legs are off.  They
   must be calculated by subtracting the last frame of the torso
   animation and adding the last frame of the death animations. *)

let quake_to_my_format x =
  (* I probably should write a parser, but the animation.cfg files
     are a little weird.  For now, I've just coded the values in. *)
  let start, len, speed = x in
  let stop = start + len - 1 in
    start, stop, start, speed

let set_anim legs torso last_dead last_torso =
  let fix_leg_anim last_dead last_head leg_anim =
    let offset = last_head - last_dead in
    let a,b,c,d = leg_anim in
      a - offset, b - offset, c - offset , d
  in
  let legs = quake_to_my_format legs in
  let legs = fix_leg_anim last_dead last_torso legs in
  let torso = quake_to_my_format torso in
    Player.init_player_anim_state legs torso

let set_dead_anim a =
  let fixed = quake_to_my_format a in
    Player.init_player_anim_state fixed fixed
