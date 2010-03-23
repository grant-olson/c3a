(* Copyright 2007,2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

type anims = {idle:Player.player_anim_state;
              walk:Player.player_anim_state;
              death:Player.player_anim_state}

type player_models = {white_skin:Player.player;
                      black_skin:Player.player;
                      weapon:Md3.md3;
                      animation:anims}


open C3aModelsShared

(* Lets go to work *)


(*
START Q3A MODELS
*)

let wbfg = load_weapon "./pak0/models/weapons2/bfg/bfg.md3"
let wg = load_weapon "./pak0/models/weapons2/gauntlet/gauntlet.md3"
let wgrenadel = load_weapon "./pak0/models/weapons2/grenadel/grenadel.md3"
let wl = load_weapon "./pak0/models/weapons2/lightning/lightning.md3"
let wmg = load_weapon "./pak0/models/weapons2/machinegun/machinegun.md3"
let wp = load_weapon "./pak0/models/weapons2/plasma/plasma.md3"
let wr = load_weapon "./pak0/models/weapons2/railgun/railgun.md3"
let wrl = load_weapon "./pak0/models/weapons2/rocketl/rocketl.md3"
let ws = load_weapon "./pak0/models/weapons2/shotgun/shotgun.md3"

let wl = wr

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

let orbb_models = {white_skin=orbb_white;
                      black_skin=orbb_black;
                      weapon=wl;
                      animation={idle=orbb_anim_idle;
                                 walk=orbb_anim_walk;
                                 death=orbb_anim_death;}}


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

let hunter_models = {white_skin=hunter_white;
                      black_skin=hunter_black;
                      weapon=wl;
                      animation={idle=hunter_anim_idle;
                                 walk=hunter_anim_walk;
                                 death=hunter_anim_death;}}


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

let mynx_models = {white_skin=mynx_white;
                      black_skin=mynx_black;
                      weapon=wl;
                      animation={idle=mynx_anim_idle;
                                 walk=mynx_anim_walk;
                                 death=mynx_anim_death;}}


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
  
let slash_models = {white_skin=slash_white;
                      black_skin=slash_black;
                      weapon=wl;
                      animation={idle=slash_anim_idle;
                                 walk=slash_anim_walk;
                                 death=slash_anim_death;}}


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

let tankjr_models = {white_skin=tankjr_white;
                      black_skin=tankjr_black;
                      weapon=wl;
                      animation={idle=tankjr_anim_idle;
                                 walk=tankjr_anim_walk;
                                 death=tankjr_anim_death;}}


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

let xaero_models = {white_skin=xaero_white;
                      black_skin=xaero_black;
                      weapon=wl;
                      animation={idle=xaero_anim_idle;
                                 walk=xaero_anim_walk;
                                 death=xaero_anim_death;}}

(* END QUAKE 3 ANIMS *)

let pawn = orbb_models
let rook = tankjr_models
let knight = hunter_models
let bishop = slash_models
let queen = mynx_models
let king = xaero_models
