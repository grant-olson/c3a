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

(* OpenArena models.  GPL'ed.  These are a little more resource intensive
   than the original Quake models, so I can't have them taunt while waiting.
   They simply stand. *)

(* angelyss - HUGE *)

let arachna = Player.load_player "./openarena/models/players/arachna/"
let arachna_black = Player.reskin_player [
    ("h_head","models/players/arachna/torsored.tga");
    ("h_ears","models/players/arachna/torsored.tga");
    ("h_hair","models/players/arachna/hairred.tga");
    ("u_body","models/players/arachna/torsored.tga");
    ("u_body1","models/players/arachna/torsored.tga");
    ("u_ears","models/players/arachna/torsored.tga");
    ("u_jewelry","models/players/arachna/jewelry3.tga");
    ("u_hair","models/players/arachna/hairred.tga");
    ("l_spider","models/players/arachna/redspider.tga");
] arachna

let arachna_white = Player.reskin_player [
    ("h_head","models/players/arachna/torsoblue.tga");
    ("h_ears","models/players/arachna/torsoblue.tga");
    ("h_hair","models/players/arachna/hair.tga");
    ("u_body","models/players/arachna/torsoblue.tga");
    ("u_body1","models/players/arachna/torsoblue.tga");
    ("u_ears","models/players/arachna/torsoblue.tga");
    ("u_jewelry","models/players/arachna/jewelry3.tga");
    ("u_hair","models/players/arachna/hair.tga");
    ("l_spider","models/players/arachna/bluespider.tga");
] arachna

let arachna_anim_death = set_dead_anim (0,29,30)
let arachna_anim_idle = set_anim (181,15,12) (95,37,13) 84 154
let arachna_anim_idle = set_anim (181,15,12) (154,1,6) 84 154
let arachna_anim_walk = set_anim (124,10,10) (154,1,6) 84 154

let ayumi = Player.load_player "./openarena/models/players/ayumi/"
let ayumi_black = Player.reskin_player [
    ("h_face","models/players/ayumi/head.tga");
    ("h_eyes","models/players/ayumi/eyes.tga");
    ("h_hair","models/players/ayumi/redhair.tga");
    ("u_torso","models/players/ayumi/redshirt.tga");
    ("u_shirt","models/players/ayumi/redshirt.tga");
    ("l_legs","models/players/ayumi/body.tga");
    ("l_skirt","models/players/ayumi/redskirt.tga");
    ("l_boots","models/players/ayumi/boots.tga");
    ("l_jet","models/players/ayumi/jettest");
] ayumi
let ayumi_white = Player.reskin_player [
    ("h_face","models/players/ayumi/head.tga");
    ("h_eyes","models/players/ayumi/eyes.tga");
    ("h_hair","models/players/ayumi/bluehair.tga");
    ("u_torso","models/players/ayumi/blueshirt.tga");
    ("u_shirt","models/players/ayumi/blueshirt.tga");
    ("l_legs","models/players/ayumi/body.tga");
    ("l_skirt","models/players/ayumi/skirt.tga");
    ("l_boots","models/players/ayumi/boots.tga");
    ("l_jet","models/players/ayumi/jettest");
] ayumi

let ayumi_anim_death = set_dead_anim (0,29,15)
let ayumi_anim_idle = set_anim (181,1,12) (95,37,13) 89 154
let ayumi_anim_idle = set_anim (181,1,12) (154,1,6) 89 154
let ayumi_anim_walk = set_anim (124,10,15) (154,1,6) 89 154

let assassin = Player.load_player "./openarena/models/players/assassin/"
let assassin_black = Player.reskin_player [
    ("h_head","models/players/assassin/upper-red.tga");
    ("u_torso","models/players/assassin/upper-red.tga");
    ("l_legs","models/players/assassin/lower-red.tga");
] assassin

let assassin_white = Player.reskin_player [
    ("h_head","models/players/assassin/upper-blue.tga");
    ("u_torso","models/players/assassin/upper-blue.tga");
    ("l_legs","models/players/assassin/lower-blue.tga");
] assassin

let assassin_anim_death = set_dead_anim (51,30,30)
let assassin_anim_idle = set_anim (166,8,8) (82,29,20) 80 155 
let assassin_anim_idle = set_anim (166,8,8) (155,16,16) 80 155 
let assassin_anim_walk = set_anim (92,10,15) (155,16,16) 80 155

(* Beret - isn't scaling correctly *)

let gargoyle = Player.load_player "./openarena/models/players/gargoyle/"
let gargoyle_black = Player.reskin_player [
    ("h_head","models/players/gargoyle/red.tga");
    ("h_headold","models/players/gargoyle/red.tga");
    ("u_torso","models/players/gargoyle/red.tga");
    ("u_wings","models/players/gargoyle/red.tga");
    ("u_membrane","models/players/gargoyle/wings.tga");
    ("l_legs","models/players/gargoyle/red.tga");
] gargoyle

let gargoyle_white = Player.reskin_player [
    ("h_head","models/players/gargoyle/blue.tga");
    ("h_headold","models/players/gargoyle/blue.tga");
    ("u_torso","models/players/gargoyle/blue.tga");
    ("u_wings","models/players/gargoyle/blue.tga");
    ("u_membrane","models/players/gargoyle/wings.tga");
    ("l_legs","models/players/gargoyle/blue.tga");
] gargoyle

let gargoyle_anim_death = set_dead_anim (30,32,30)
let gargoyle_anim_idle = set_anim (235,9,9) (95,37,13) 93 154
let gargoyle_anim_idle = set_anim (184,9,19) (95,37,13) 93 154
let gargoyle_anim_walk = set_anim (184,9,19) (154,10,6) 93 154

let kyonshi = Player.load_player "./openarena/models/players/kyonshi/"
let kyonshi_black = Player.reskin_player [
    ("h_face","models/players/kyonshi/skinred.tga");
    ("h_hat","models/players/kyonshi/torsored.tga");
    ("h_hair","models/players/kyonshi/hairred.tga");
    ("h_hair2","models/players/kyonshi/hairred.tga");
    ("h_eyes","models/players/kyonshi/eyesred.tga");
    ("u_torso","models/players/kyonshi/torsored.tga");
    ("u_hands","models/players/kyonshi/skinred.tga");
    ("u_sleeve","models/players/kyonshi/sleevered.tga");
    ("l_legs","models/players/kyonshi/skinred.tga");
    ("l_dress","models/players/kyonshi/dressred.tga");
    ("l_lower","models/players/kyonshi/lowerred.tga");
] kyonshi

let kyonshi_white = Player.reskin_player [
    ("h_face","models/players/kyonshi/skinblue.tga");
    ("h_hat","models/players/kyonshi/torsoblue.tga");
    ("h_hair","models/players/kyonshi/hairblue.tga");
    ("h_hair2","models/players/kyonshi/hairblue.tga");
    ("h_eyes","models/players/kyonshi/eyesblue.tga");
    ("u_torso","models/players/kyonshi/torsoblue.tga");
    ("u_hands","models/players/kyonshi/skinblue.tga");
    ("u_sleeve","models/players/kyonshi/sleeveblue.tga");
    ("l_legs","models/players/kyonshi/skinblue.tga");
    ("l_dress","models/players/kyonshi/dressblue.tga");
    ("l_lower","models/players/kyonshi/lowerblue.tga");
] kyonshi

let kyonshi_anim_death = set_dead_anim (64,30,30)
let kyonshi_anim_idle = set_anim (240,1,8) (95,37,13) 93 154 
let kyonshi_anim_idle = set_anim (240,1,8) (154,10,6) 93 154 
let kyonshi_anim_walk = set_anim (260,7,15) (154,10,6) 93 154

(* LIZ - HUGE *)

let major = Player.load_player "./openarena/models/players/major/"
let major_black = Player.reskin_player [
    ("h_head","models/players/major/head.tga");
    ("u_torso","models/players/major/torsored.tga");
    ("l_lower","models/players/major/lowerred.tga");
] major

let major_white = Player.reskin_player [
    ("h_head","models/players/major/head.tga");
    ("u_torso","models/players/major/torsoblue.tga");
    ("l_lower","models/players/major/lowerblue.tga");
] major

let major_anim_death = set_dead_anim (0,29,15)
let major_anim_idle = set_anim (240,9,8) (95,37,13) 93 154
let major_anim_idle = set_anim (240,9,8) (154,1,6) 93 154
let major_anim_walk = set_anim (184,10,15) (154,1,6) 93 154

(* try crouch since she's a pawn *)
let major_anim_idle = set_anim (251,8,8) (154,1,6) 93 154
let major_anim_walk = set_anim (155,6,24) (154,1,6) 93 154


(* MERMAN - weird stuff on blue 
let merman = Player.load_player "./openarena/models/players/merman/"
let merman_black = Player.reskin_player [
    ("h_head","models/players/merman/skinred.tga");
    ("h_fins","models/players/merman/finsred.tga");
    ("u_torso","models/players/merman/skinred.tga");
    ("u_fins","models/players/merman/finsred.tga");
    ("u_brac","models/players/merman/bracred.tga");
    ("l_legs","models/players/merman/skinred.tga");
    ("l_fins","models/players/merman/finsred.tga");
] merman

let merman_white = Player.reskin_player [
    ("h_head","models/players/merman/skinblue.tga");
    ("h_fins","models/players/merman/finsblue.tga");
    ("u_torso","models/players/merman/skinblue.tga");
    ("u_fins","models/players/merman/finsblue.tga");
    ("u_brac","models/players/merman/bracblue.tga");
    ("l_legs","models/players/merman/skinblue.tga");
    ("l_fins","models/players/merman/finsblue.tga");
] merman

let merman_anim_death = set_dead_anim (1,1,1)
let merman_anim_idle = set_anim (1,1,1) (1,1,1) 0 0 
let merman_anim_walk = set_anim (1,1,1) (1,1,1) 0 0
*)

let penguin = Player.load_player "./openarena/models/players/penguin/"
let penguin_black = Player.reskin_player [
    ("h_head","models/players/penguin/skinred.tga");
    ("u_torso","models/players/penguin/skinred.tga");
    ("l_legs","models/players/penguin/skinred.tga");
] penguin

let penguin_white = Player.reskin_player [
    ("h_head","models/players/penguin/skinblue.tga");
    ("u_torso","models/players/penguin/skinblue.tga");
    ("l_legs","models/players/penguin/skinblue.tga");
] penguin

let penguin_anim_death = set_dead_anim (30,30,25)
let penguin_anim_idle = set_anim (234,10,10) (90,40,30) 89 152
let penguin_anim_idle = set_anim (234,10,10) (151,1,15) 89 152
let penguin_anim_walk = set_anim (161,12,20) (151,1,15) 89 152

let sarge = Player.load_player "./openarena/models/players/sarge/"
let sarge_black = Player.reskin_player [
    ("h_head","models/players/grism/redskin.tga");
    ("u_torso","models/players/grism/redskin.tga");
    ("l_legs","models/players/grism/redskin.tga");
] sarge

let sarge_white = Player.reskin_player [
    ("h_head","models/players/grism/blueskin.tga");
    ("u_torso","models/players/grism/blueskin.tga");
    ("l_legs","models/players/grism/blueskin.tga");
] sarge

let sarge_anim_death = set_dead_anim (60,30,25)
let sarge_anim_idle = set_anim (234,10,10) (90,40,13) 89 152
let sarge_anim_walk = set_anim (161,12,20) (151,1,15) 89 152

(* SERGEI - HUGE *)

(* SKELEBOT - HUGE *)

(* SMARINE - GOOFY ANIMATION NUMBERS

let smarine = Player.load_player "./openarena/models/players/smarine/"
let smarine_black = Player.reskin_player [
    ("h_head","models/players/smarine/h_headr.tga");
    ("u_torso","models/players/smarine/u_torsor.tga");
    ("l_legs","models/players/smarine/l_legsr.tga");
] smarine

let smarine_white = Player.reskin_player [
    ("h_head","models/players/smarine/h_headb.tga");
    ("u_torso","models/players/smarine/u_torsob.tga");
    ("l_legs","models/players/smarine/l_legsb.tga");
] smarine

let smarine_anim_death = set_dead_anim (15,11,25)
let smarine_anim_idle = set_anim (174,10,10) (36,14,15) 35 149
let smarine_anim_walk = set_anim (56,10,20) (83,1,15) 35 149
*)

(* sorceress - HUGE *)

(* tony - HUGE *)

(*
END OPEN ARENA MODELS
*)

(*
START Q3A MODELS
*)

(*
let orbb = Player.load_player "./pak0/models/players/orbb/"
let orbb_black = Player.reskin_player [
    ("h_head","./pak0/models/players/orbb/red_h.tga");
    ("u_ratchet","./pak0/models/players/orbb/red.tga");
    ("u_antenna","./pak0/models/players/orbb/red.tga");
    ("u_antennaball","./pak0/models/players/orbb/orbb_light_red.tga");
    ("u_tailight","./pak0/models/players/orbb/orbb_tail_red.tga");
    ("u_torso","./pak0/models/players/orbb/red.tga");
    ("l_legs","./pak0/models/players/orbb/red.tga");] orbb

let orbb_white = Player.reskin_player  [
    ("h_head","./pak0/models/players/orbb/blue_h.tga");
    ("u_ratchet","./pak0/models/players/orbb/blue.tga");
    ("u_antenna","./pak0/models/players/orbb/blue.tga");
    ("u_antennaball","./pak0/models/players/orbb/orbb_light_blue.tga");
    ("u_tailight","./pak0/models/players/orbb/orbb_tail_blue.tga");
    ("u_torso","./pak0/models/players/orbb/blue.tga");
    ("l_legs","./pak0/models/players/orbb/blue.tga");
  ] orbb

let orbb_anim_death = set_dead_anim (33,30,20)
let orbb_anim_idle = set_anim (188,21,15) (93,1,15) 92 115
let orbb_anim_walk = set_anim (124,12,20) (114,1,15) 92 115


let hunter = Player.load_player "./pak0/models/players/hunter/"
let hunter_anim_death = set_dead_anim (60,30,20)
let hunter_anim_idle = set_anim (243,14,15) (90,40,20) 89 152
let hunter_anim_walk = set_anim (161,17,23) (151,1,15) 89 152

let hunter_black = Player.reskin_player [
    ("h_feathers","./pak0/models/players/hunter/red_f.tga");
    ("h_head","./pak0/models/players/hunter/red_h.tga");
    ("u_torso","./pak0/models/players/hunter/red.tga");
    ("l_legs","./pak0/models/players/hunter/red.tga"); ] hunter

let hunter_white = Player.reskin_player [
    ("h_feathers","./pak0/models/players/hunter/red_f.tga");
    ("h_head","./pak0/models/players/hunter/blue_h.tga");
    ("u_torso","./pak0/models/players/hunter/blue.tga");
    ("l_legs","./pak0/models/players/hunter/blue.tga");] hunter

let mynx = Player.load_player "./pak0/models/players/mynx/"

let mynx_anim_death = set_dead_anim (31,31,20)
let mynx_anim_walk = set_anim (174,17,25) (156,1,15) 94 157
let mynx_anim_idle = set_anim (258,17,15) (95,40,15) 94 157

let mynx_black = Player.reskin_player [
    ("h_glasses","./pak0/models/players/mynx/red_s.tga");
    ("h_head","./pak0/models/players/mynx/red_h.tga");
    ("u_arms","./pak0/models/players/mynx/mynx.tga");
    ("u_torso","./pak0/models/players/mynx/red_s.tga");
    ("l_legs","./pak0/models/players/mynx/red_s.tga"); ] mynx

let mynx_white = Player.reskin_player [
    ("h_glasses","./pak0/models/players/mynx/blue_s.tga");
    ("h_head","./pak0/models/players/mynx/red_h.tga");
    ("u_arms","./pak0/models/players/mynx/mynx.tga");
    ("u_torso","./pak0/models/players/mynx/blue_s.tga");
    ("l_legs","./pak0/models/players/mynx/blue_s.tga");
    ("tag_torso","")] mynx

let slash = Player.load_player "./pak0/models/players/slash/"
let slash_anim_death = set_dead_anim (0,30,20)
let slash_anim_idle = set_anim (230,15,15) (70,47,15) 69 139
let slash_anim_walk = set_anim (150,11,14) (138,1,15) 69 139

let slash_black = Player.reskin_player [
    ("h_head","./pak0/models/players/slash/red_h.tga");
    ("u_torso","./pak0/models/players/slash/red.tga");
    ("l_skatel","./pak0/models/players/slash/slashskate.TGA");
    ("l_skater","./pak0/models/players/slash/slashskate.TGA");
    ("l_legs","./pak0/models/players/slash/red.tga");
  ] slash

let slash_white = Player.reskin_player [
    ("h_head","./pak0/models/players/slash/blue_h.tga");
    ("u_torso","./pak0/models/players/slash/blue.tga");
    ("l_skatel","./pak0/models/players/slash/slashskate.TGA");
    ("l_skater","./pak0/models/players/slash/slashskate.TGA");
    ("l_legs","./pak0/models/players/slash/blue.tga");] slash
  

let tankjr = Player.load_player "./pak0/models/players/tankjr/"
let tankjr_anim_death = set_dead_anim (0,45,20)
let tankjr_anim_idle = set_anim (257,1,15) (92,40,10) 91 154
let tankjr_anim_walk = set_anim (171,22,28) (153,1,15) 91 154

let tankjr_black = Player.reskin_player [
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

  ] tankjr

let tankjr_white = Player.reskin_player [
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
    ("l_lcalf","./pak0/models/players/tankjr/blue.tga");] tankjr

let xaero = Player.load_player "./pak0/models/players/xaero/"
let xaero_anim_death = set_dead_anim (0,49,20) 
let xaero_anim_idle = set_anim (245,10,15) (117,33,20) 116 172
let xaero_anim_walk = set_anim (181,12,20) (171,1,15) 116 172

let xaero_black = Player.reskin_player [
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
  ] xaero
let xaero_white = Player.reskin_player [
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
    ("l_sash_front","./pak0/models/players/xaero/blue.tga")] xaero
*)
(* END QUAKE 3 ANIMS *)

(*
Queen -> ayumi
Bishop -> assassin
King -> kyonshi
Knight -> penguin
Rook -> sarge
Pawn -> Major

merman?

too slow!

gargoyle
arachna
*)

let pawn = major 
let pawn_anim_death = major_anim_death 
let pawn_anim_idle = major_anim_idle
let pawn_anim_walk = major_anim_walk
let pawn_black = major_black
let pawn_white = major_white

let rook = sarge 
let rook_anim_death = sarge_anim_death 
let rook_anim_idle = sarge_anim_idle
let rook_anim_walk = sarge_anim_walk
let rook_black = sarge_black
let rook_white = sarge_white

let knight = arachna 
let knight_anim_death = arachna_anim_death 
let knight_anim_idle = arachna_anim_idle
let knight_anim_walk = arachna_anim_walk
let knight_black = arachna_black
let knight_white = arachna_white

let bishop = penguin 
let bishop_anim_death = penguin_anim_death 
let bishop_anim_idle = penguin_anim_idle
let bishop_anim_walk = penguin_anim_walk
let bishop_black = penguin_black
let bishop_white = penguin_white

let queen = ayumi 
let queen_anim_death = ayumi_anim_death 
let queen_anim_idle = ayumi_anim_idle
let queen_anim_walk = ayumi_anim_walk
let queen_black = ayumi_black
let queen_white = ayumi_white

let king = kyonshi 
let king_anim_death = kyonshi_anim_death 
let king_anim_idle = kyonshi_anim_idle
let king_anim_walk = kyonshi_anim_walk
let king_black = kyonshi_black
let king_white = kyonshi_white


(* Quake3 weapons
let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;
*)

let wrl = Md3.load_md3_file "./openarena/models/weapons2/rocketl/rocketl.md3"
let ws = Md3.load_md3_file "./openarena/models/weapons2/shotgun/shotgun.md3"
let wr = Md3.load_md3_file "./openarena/models/weapons2/gauntlet/gauntlet.md3"
let wg = Md3.load_md3_file "./openarena/models/weapons2/railgun/railgun.md3"
