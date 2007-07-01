(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

let pawn = Player.load_player "./pak0/models/players/orbb/"
let pawn_black = Player.reskin_player [
    ("h_head","models/players/orbb/red_h.tga");
    ("u_ratchet","models/players/orbb/red.tga");
    ("u_antenna","models/players/orbb/red.tga");
    ("u_antennaball","models/players/orbb/orbb_light_red.tga");
    ("u_tailight","models/players/orbb/orbb_tail_red.tga");
    ("u_torso","models/players/orbb/red.tga");
    ("l_legs","models/players/orbb/red.tga");] pawn

let pawn_white = Player.reskin_player  [
    ("h_head","models/players/orbb/blue_h.tga");
    ("u_ratchet","models/players/orbb/blue.tga");
    ("u_antenna","models/players/orbb/blue.tga");
    ("u_antennaball","models/players/orbb/orbb_light_blue.tga");
    ("u_tailight","models/players/orbb/orbb_tail_blue.tga");
    ("u_torso","models/players/orbb/blue.tga");
    ("l_legs","models/players/orbb/blue.tga");
  ] pawn

let pawn_anim_idle = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)
let pawn_anim_walk = Player.init_player_anim_state (100,111,100,20) (93,93,93,20)
let pawn_anim_death = Player.init_player_anim_state (0,32,32,20) (0,32,32,20)

let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_anim_idle = Player.init_player_anim_state (180,193,180,15) (90,139,90,20)
let knight_anim_walk = Player.init_player_anim_state (98,114,98,23) (130,135,130,15)
let knight_anim_death = Player.init_player_anim_state (30,59,59,20) (30,59,59,20)
let knight_black = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/red_h.tga");
    ("u_torso","models/players/hunter/red.tga");
    ("l_legs","models/players/hunter/red.tga"); ] knight

let knight_white = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/blue_h.tga");
    ("u_torso","models/players/hunter/blue.tga");
    ("l_legs","models/players/hunter/blue.tga");] knight

let queen = Player.load_player "./pak0/models/players/mynx/"
let queen_anim_idle = Player.init_player_anim_state (195,211,195,15) (95,134,95,20)
let queen_anim_walk = Player.init_player_anim_state (111,117,111,25) (111,127,11,25)
let queen_anim_death = Player.init_player_anim_state (62,94,94,20) (62,94,94,20)
let queen_black = Player.reskin_player [
    ("h_glasses","models/players/mynx/red_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/red_s.tga");
    ("l_legs","models/players/mynx/red_s.tga"); ] queen

let queen_white = Player.reskin_player [
    ("h_glasses","models/players/mynx/blue_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/blue_s.tga");
    ("l_legs","models/players/mynx/blue_s.tga");
    ("tag_torso","")] queen

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_anim_idle = Player.init_player_anim_state (160,174,160,15) (70,116,70,15)
let bishop_anim_walk = Player.init_player_anim_state (80,89,80,14) (117,122,117,15)
let bishop_anim_death = Player.init_player_anim_state (0,29,29,20) (0,29,29,20)
let bishop_black = Player.reskin_player [
    ("h_head","models/players/slash/red_h.tga");
    ("u_torso","models/players/slash/red.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/red.tga");
  ] bishop

let bishop_white = Player.reskin_player [
    ("h_head","models/players/slash/blue_h.tga");
    ("u_torso","models/players/slash/blue.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/blue.tga");] bishop
  

let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_anim_idle = Player.init_player_anim_state (194, 194, 194, 15) (92, 131, 92, 19)
let rook_anim_walk = Player.init_player_anim_state (108,129,108,28) (132,137,132,15)
let rook_anim_death = Player.init_player_anim_state (45,64,64,20) (45,64,64,20)
let rook_black = Player.reskin_player [
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

  ] rook

let rook_white = Player.reskin_player [
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
    ("l_lcalf","models/players/tankjr/blue.tga");] rook

let king = Player.load_player "./pak0/models/players/xaero/"
let king_anim_idle = Player.init_player_anim_state (193, 193, 193, 15) (117,149, 117, 15)
let king_anim_walk = Player.init_player_anim_state (125,132,125,20) (150,155,150,15)
let king_anim_death = Player.init_player_anim_state (81,116,116,20) (81,116,116,20)
let king_black = Player.reskin_player [
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
  ] king
let king_white = Player.reskin_player [
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
    ("l_sash_front","models/players/xaero/blue.tga")] king


let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;
