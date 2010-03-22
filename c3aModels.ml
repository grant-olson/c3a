(* Copyright 2007,2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

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

(* Lets go to work *)


(*
START Q3A MODELS
*)

let orbb = Player.load_player "./pak0/models/players/orbb/"
let orbb_black = Player.reskin_player [
    ("h_head","models/players/orbb/red_h.tga");
    ("u_ratchet","models/players/orbb/red.tga");
    ("u_antenna","models/players/orbb/red.tga");
    ("u_antennaball","models/players/orbb/orbb_light_red.tga");
    ("u_tailight","models/players/orbb/orbb_tail_red.tga");
    ("u_torso","models/players/orbb/red.tga");
    ("l_legs","models/players/orbb/red.tga");] orbb

let orbb_white = Player.reskin_player  [
    ("h_head","models/players/orbb/blue_h.tga");
    ("u_ratchet","models/players/orbb/blue.tga");
    ("u_antenna","models/players/orbb/blue.tga");
    ("u_antennaball","models/players/orbb/orbb_light_blue.tga");
    ("u_tailight","models/players/orbb/orbb_tail_blue.tga");
    ("u_torso","models/players/orbb/blue.tga");
    ("l_legs","models/players/orbb/blue.tga");
  ] orbb

let orbb_anim_death = set_dead_anim (33,30,20)
let orbb_anim_idle = set_anim (188,21,15) (93,1,15) 92 115
let orbb_anim_walk = set_anim (124,12,20) (114,1,15) 92 115


let hunter = Player.load_player "./pak0/models/players/hunter/"
let hunter_anim_death = set_dead_anim (60,30,20)
let hunter_anim_idle = set_anim (243,14,15) (90,40,20) 89 152
let hunter_anim_walk = set_anim (161,17,23) (151,1,15) 89 152

let hunter_black = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/red_h.tga");
    ("u_torso","models/players/hunter/red.tga");
    ("l_legs","models/players/hunter/red.tga"); ] hunter

let hunter_white = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/blue_h.tga");
    ("u_torso","models/players/hunter/blue.tga");
    ("l_legs","models/players/hunter/blue.tga");] hunter

let mynx = Player.load_player "./pak0/models/players/mynx/"

let mynx_anim_death = set_dead_anim (31,31,20)
let mynx_anim_walk = set_anim (174,17,25) (156,1,15) 94 157
let mynx_anim_idle = set_anim (258,17,15) (95,40,15) 94 157

let mynx_black = Player.reskin_player [
    ("h_glasses","models/players/mynx/red_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/red_s.tga");
    ("l_legs","models/players/mynx/red_s.tga"); ] mynx

let mynx_white = Player.reskin_player [
    ("h_glasses","models/players/mynx/blue_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/blue_s.tga");
    ("l_legs","models/players/mynx/blue_s.tga");
    ("tag_torso","")] mynx

let slash = Player.load_player "./pak0/models/players/slash/"
let slash_anim_death = set_dead_anim (0,30,20)
let slash_anim_idle = set_anim (230,15,15) (70,47,15) 69 139
let slash_anim_walk = set_anim (150,11,14) (138,1,15) 69 139

let slash_black = Player.reskin_player [
    ("h_head","models/players/slash/red_h.tga");
    ("u_torso","models/players/slash/red.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/red.tga");
  ] slash

let slash_white = Player.reskin_player [
    ("h_head","models/players/slash/blue_h.tga");
    ("u_torso","models/players/slash/blue.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/blue.tga");] slash
  

let tankjr = Player.load_player "./pak0/models/players/tankjr/"
let tankjr_anim_death = set_dead_anim (0,45,20)
let tankjr_anim_idle = set_anim (257,1,15) (92,40,10) 91 154
let tankjr_anim_walk = set_anim (171,22,28) (153,1,15) 91 154

let tankjr_black = Player.reskin_player [
    ("h_head","models/players/tankjr/red.tga");
    ("u_abdomen","models/players/tankjr/red.tga");
    ("u_arms","models/players/tankjr/red.tga");
    ("u_torso","models/players/tankjr/red.tga");
    ("l_rcalf","models/players/tankjr/red.tga");
    ("l_rfoot","models/players/tankjr/red.tga");
    ("l_lfoot","models/players/tankjr/red.tga");
    ("l_hips","models/players/tankjr/red.tga");
    ("l_rthigh","models/players/tankjr/red.tga");
    ("l_lthigh","models/players/tankjr/red.tga");
    ("l_rtoe","models/players/tankjr/red.tga");
    ("l_ltoe","models/players/tankjr/red.tga");
    ("l_rtoes","models/players/tankjr/red.tga");
    ("l_ltoes","models/players/tankjr/red.tga");
    ("l_lcalf","models/players/tankjr/red.tga");

  ] tankjr

let tankjr_white = Player.reskin_player [
    ("h_head","models/players/tankjr/blue.tga");
    ("u_abdomen","models/players/tankjr/blue.tga");
    ("u_arms","models/players/tankjr/blue.tga");
    ("u_torso","models/players/tankjr/blue.tga");
    ("l_rcalf","models/players/tankjr/blue.tga");
    ("l_rfoot","models/players/tankjr/blue.tga");
    ("l_lfoot","models/players/tankjr/blue.tga");
    ("l_hips","models/players/tankjr/blue.tga");
    ("l_rthigh","models/players/tankjr/blue.tga");
    ("l_lthigh","models/players/tankjr/blue.tga");
    ("l_rtoe","models/players/tankjr/blue.tga");
    ("l_ltoe","models/players/tankjr/blue.tga");
    ("l_rtoes","models/players/tankjr/blue.tga");
    ("l_ltoes","models/players/tankjr/blue.tga");
    ("l_lcalf","models/players/tankjr/blue.tga");] tankjr

let xaero = Player.load_player "./pak0/models/players/xaero/"
let xaero_anim_death = set_dead_anim (0,49,20) 
let xaero_anim_idle = set_anim (245,10,15) (117,33,20) 116 172
let xaero_anim_walk = set_anim (181,12,20) (171,1,15) 116 172

let xaero_black = Player.reskin_player [
    ("h_head","models/players/xaero/red_h.tga");
    ("u_armbase","models/players/xaero/xaero_a.tga");
    ("u_quill01","models/players/xaero/xaero_q.tga");
    ("u_quill02","models/players/xaero/xaero_q.tga");
    ("u_quill03","models/players/xaero/xaero_q.tga");
    ("u_quill04","models/players/xaero/xaero_q.tga");
    ("u_quill05","models/players/xaero/xaero_q.tga");
    ("u_quill06","models/players/xaero/xaero_q.tga");
    ("u_quill07","models/players/xaero/xaero_q.tga");
    ("u_quill08",",models/players/xaero/xaero_q.tga");
    ("u_torso","models/players/xaero/red.tga");
    ("u_arm","models/players/xaero/xaero_a.tga");
    ("l_legs","models/players/xaero/red.tga");
    ("l_sash_back","models/players/xaero/red.tga");
    ("l_sash_front","models/players/xaero/red.tga")
  ] xaero
let xaero_white = Player.reskin_player [
    ("h_head","models/players/xaero/blue_h.tga");
    ("u_armbase","models/players/xaero/xaero_a.tga");
    ("u_quill01","models/players/xaero/xaero_q.tga");
    ("u_quill02","models/players/xaero/xaero_q.tga");
    ("u_quill03","models/players/xaero/xaero_q.tga");
    ("u_quill04","models/players/xaero/xaero_q.tga");
    ("u_quill05","models/players/xaero/xaero_q.tga");
    ("u_quill06","models/players/xaero/xaero_q.tga");
    ("u_quill07","models/players/xaero/xaero_q.tga");
    ("u_quill08",",models/players/xaero/xaero_q.tga");
    ("u_torso","models/players/xaero/blue.tga");
    ("u_arm","models/players/xaero/xaero_a.tga");
    ("l_legs","models/players/xaero/blue.tga");
    ("l_sash_back","models/players/xaero/blue.tga");
    ("l_sash_front","models/players/xaero/blue.tga")] xaero

(* END QUAKE 3 ANIMS *)

let pawn = orbb 
let pawn_anim_death = orbb_anim_death 
let pawn_anim_idle = orbb_anim_idle
let pawn_anim_walk = orbb_anim_walk
let pawn_black = orbb_black
let pawn_white = orbb_white

let rook = tankjr 
let rook_anim_death = tankjr_anim_death 
let rook_anim_idle = tankjr_anim_idle
let rook_anim_walk = tankjr_anim_walk
let rook_black = tankjr_black
let rook_white = tankjr_white

let knight = hunter 
let knight_anim_death = hunter_anim_death 
let knight_anim_idle = hunter_anim_idle
let knight_anim_walk = hunter_anim_walk
let knight_black = hunter_black
let knight_white = hunter_white

let bishop = slash 
let bishop_anim_death = slash_anim_death 
let bishop_anim_idle = slash_anim_idle
let bishop_anim_walk = slash_anim_walk
let bishop_black = slash_black
let bishop_white = slash_white

let queen = mynx 
let queen_anim_death = mynx_anim_death 
let queen_anim_idle = mynx_anim_idle
let queen_anim_walk = mynx_anim_walk
let queen_black = mynx_black
let queen_white = mynx_white

let king = xaero 
let king_anim_death = xaero_anim_death 
let king_anim_idle = xaero_anim_idle
let king_anim_walk = xaero_anim_walk
let king_black = xaero_black
let king_white = xaero_white

let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;
