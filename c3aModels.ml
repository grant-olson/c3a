(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* Utility routines to change info from the quake animation.cfg files
   to the format I use.  Notably, the numbers for legs are off.  They
   must be calculated by subtracting the last frame of the torso
   animation and adding the last frame of the death animations. *)

let quake_to_my_format x =
  let start, len, speed = x in
  let stop = start + len - 1 in
    Printf.printf "OUT %i %i %i %i\n" start stop start speed;
    start, stop, start, speed

let set_anim legs torso last_dead last_torso =
  let fix_leg_anim last_dead last_head leg_anim =
    let offset = last_head - last_dead in
    let a,b,c,d = leg_anim in
      Printf.printf "fixing %i %i %i %i\n" a b c d;
      Printf.printf "fixed %i %i %i %i\n" (a - offset) (b - offset) (c - offset) d;
      flush stdout;
      a - offset, b - offset, c - offset , d
  in
  let legs = quake_to_my_format legs in
  let legs = fix_leg_anim last_dead last_torso legs in
  let torso = quake_to_my_format torso in
    Player.init_player_anim_state legs torso

let set_dead_anim a =
  let fixed = quake_to_my_format a in
    Player.init_player_anim_state fixed fixed

(* Lets go to work *)

let pawn = Player.load_player "./pak0/models/players/orbb/"
let pawn_black = Player.reskin_player [
    ("h_head","./pak0/models/players/orbb/red_h.tga");
    ("u_ratchet","./pak0/models/players/orbb/red.tga");
    ("u_antenna","./pak0/models/players/orbb/red.tga");
    ("u_antennaball","./pak0/models/players/orbb/orbb_light_red.tga");
    ("u_tailight","./pak0/models/players/orbb/orbb_tail_red.tga");
    ("u_torso","./pak0/models/players/orbb/red.tga");
    ("l_legs","./pak0/models/players/orbb/red.tga");] pawn

let pawn_white = Player.reskin_player  [
    ("h_head","./pak0/models/players/orbb/blue_h.tga");
    ("u_ratchet","./pak0/models/players/orbb/blue.tga");
    ("u_antenna","./pak0/models/players/orbb/blue.tga");
    ("u_antennaball","./pak0/models/players/orbb/orbb_light_blue.tga");
    ("u_tailight","./pak0/models/players/orbb/orbb_tail_blue.tga");
    ("u_torso","./pak0/models/players/orbb/blue.tga");
    ("l_legs","./pak0/models/players/orbb/blue.tga");
  ] pawn

let pawn_anim_death = set_dead_anim (33,30,20)
let pawn_anim_idle = set_anim (188,21,15) (93,1,15) 92 115
let pawn_anim_walk = set_anim (124,12,20) (114,1,15) 92 115

let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_anim_death = set_dead_anim (60,30,20)
let knight_anim_idle = set_anim (243,14,15) (90,40,20) 89 152
let knight_anim_walk = set_anim (161,17,23) (151,1,15) 89 152

let knight_black = Player.reskin_player [
    ("h_feathers","./pak0/models/players/hunter/red_f.tga");
    ("h_head","./pak0/models/players/hunter/red_h.tga");
    ("u_torso","./pak0/models/players/hunter/red.tga");
    ("l_legs","./pak0/models/players/hunter/red.tga"); ] knight

let knight_white = Player.reskin_player [
    ("h_feathers","./pak0/models/players/hunter/red_f.tga");
    ("h_head","./pak0/models/players/hunter/blue_h.tga");
    ("u_torso","./pak0/models/players/hunter/blue.tga");
    ("l_legs","./pak0/models/players/hunter/blue.tga");] knight

let queen = Player.load_player "./pak0/models/players/mynx/"

let queen_anim_death = set_dead_anim (31,31,20)
let queen_anim_walk = set_anim (174,17,25) (156,1,15) 94 157
let queen_anim_idle = set_anim (258,17,15) (95,40,15) 94 157

let queen_black = Player.reskin_player [
    ("h_glasses","./pak0/models/players/mynx/red_s.tga");
    ("h_head","./pak0/models/players/mynx/red_h.tga");
    ("u_arms","./pak0/models/players/mynx/mynx.tga");
    ("u_torso","./pak0/models/players/mynx/red_s.tga");
    ("l_legs","./pak0/models/players/mynx/red_s.tga"); ] queen

let queen_white = Player.reskin_player [
    ("h_glasses","./pak0/models/players/mynx/blue_s.tga");
    ("h_head","./pak0/models/players/mynx/red_h.tga");
    ("u_arms","./pak0/models/players/mynx/mynx.tga");
    ("u_torso","./pak0/models/players/mynx/blue_s.tga");
    ("l_legs","./pak0/models/players/mynx/blue_s.tga");
    ("tag_torso","")] queen

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_anim_death = set_dead_anim (0,30,20)
let bishop_anim_idle = set_anim (230,15,15) (70,47,15) 69 139
let bishop_anim_walk = set_anim (150,11,14) (138,1,15) 69 139

let bishop_black = Player.reskin_player [
    ("h_head","./pak0/models/players/slash/red_h.tga");
    ("u_torso","./pak0/models/players/slash/red.tga");
    ("l_skatel","./pak0/models/players/slash/slashskate.TGA");
    ("l_skater","./pak0/models/players/slash/slashskate.TGA");
    ("l_legs","./pak0/models/players/slash/red.tga");
  ] bishop

let bishop_white = Player.reskin_player [
    ("h_head","./pak0/models/players/slash/blue_h.tga");
    ("u_torso","./pak0/models/players/slash/blue.tga");
    ("l_skatel","./pak0/models/players/slash/slashskate.TGA");
    ("l_skater","./pak0/models/players/slash/slashskate.TGA");
    ("l_legs","./pak0/models/players/slash/blue.tga");] bishop
  

let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_anim_death = set_dead_anim (0,45,20)
let rook_anim_idle = set_anim (257,1,15) (92,40,10) 91 154
let rook_anim_walk = set_anim (171,22,28) (153,1,15) 91 154

let rook_black = Player.reskin_player [
    ("h_head","./pak0/models/players/tankjr/red.tga");
    ("u_abdomen","./pak0/models/players/tankjr/red.tga");
    ("u_arms","./pak0/models/players/tankjr/red.tga");
    ("u_torso","./pak0/models/players/tankjr/red.tga");
    ("l_rcalf","./pak0/models/players/tankjr/red.tga");
    ("l_rfoot","./pak0/models/players/tankjr/red.tga");
    ("l_lfoot","./pak0/models/players/tankjr/red.tga");
    ("l_hips","./pak0/models/players/tankjr/red.tga");
    ("l_rthigh","./pak0/models/players/tankjr/red.tga");
    ("l_lthigh","./pak0/models/players/tankjr/red.tga");
    ("l_rtoe","./pak0/models/players/tankjr/red.tga");
    ("l_ltoe","./pak0/models/players/tankjr/red.tga");
    ("l_rtoes","./pak0/models/players/tankjr/red.tga");
    ("l_ltoes","./pak0/models/players/tankjr/red.tga");
    ("l_lcalf","./pak0/models/players/tankjr/red.tga");

  ] rook

let rook_white = Player.reskin_player [
    ("h_head","./pak0/models/players/tankjr/blue.tga");
    ("u_abdomen","./pak0/models/players/tankjr/blue.tga");
    ("u_arms","./pak0/models/players/tankjr/blue.tga");
    ("u_torso","./pak0/models/players/tankjr/blue.tga");
    ("l_rcalf","./pak0/models/players/tankjr/blue.tga");
    ("l_rfoot","./pak0/models/players/tankjr/blue.tga");
    ("l_lfoot","./pak0/models/players/tankjr/blue.tga");
    ("l_hips","./pak0/models/players/tankjr/blue.tga");
    ("l_rthigh","./pak0/models/players/tankjr/blue.tga");
    ("l_lthigh","./pak0/models/players/tankjr/blue.tga");
    ("l_rtoe","./pak0/models/players/tankjr/blue.tga");
    ("l_ltoe","./pak0/models/players/tankjr/blue.tga");
    ("l_rtoes","./pak0/models/players/tankjr/blue.tga");
    ("l_ltoes","./pak0/models/players/tankjr/blue.tga");
    ("l_lcalf","./pak0/models/players/tankjr/blue.tga");] rook

let king = Player.load_player "./pak0/models/players/xaero/"
let king_anim_death = set_dead_anim (0,49,20) 
let king_anim_idle = set_anim (245,10,15) (117,33,20) 116 172
let king_anim_walk = set_anim (181,12,20) (171,1,15) 116 172

let king_black = Player.reskin_player [
    ("h_head","./pak0/models/players/xaero/red_h.tga");
    ("u_armbase","./pak0/models/players/xaero/xaero_a.tga");
    ("u_quill01","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill02","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill03","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill04","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill05","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill06","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill07","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill08",",models/players/xaero/xaero_q.tga");
    ("u_torso","./pak0/models/players/xaero/red.tga");
    ("u_arm","./pak0/models/players/xaero/xaero_a.tga");
    ("l_legs","./pak0/models/players/xaero/red.tga");
    ("l_sash_back","./pak0/models/players/xaero/red.tga");
    ("l_sash_front","./pak0/models/players/xaero/red.tga")
  ] king
let king_white = Player.reskin_player [
    ("h_head","./pak0/models/players/xaero/blue_h.tga");
    ("u_armbase","./pak0/models/players/xaero/xaero_a.tga");
    ("u_quill01","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill02","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill03","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill04","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill05","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill06","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill07","./pak0/models/players/xaero/xaero_q.tga");
    ("u_quill08",",models/players/xaero/xaero_q.tga");
    ("u_torso","./pak0/models/players/xaero/blue.tga");
    ("u_arm","./pak0/models/players/xaero/xaero_a.tga");
    ("l_legs","./pak0/models/players/xaero/blue.tga");
    ("l_sash_back","./pak0/models/players/xaero/blue.tga");
    ("l_sash_front","./pak0/models/players/xaero/blue.tga")] king


let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;
