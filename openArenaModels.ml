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

let wbfg = load_weapon "./openarena/models/weapons2/bfg/bfg.md3"
let wg = load_weapon "./openarena/models/weapons2/gauntlet/gauntlet.md3"
(*let wgrenadel = load_weapon "./openarena/models/weapons2/grenadel/grenadel.md3"*)
let wl = load_weapon "./openarena/models/weapons2/lightning/lightning.md3"
(*let wmg = load_weapon "./openarena/models/weapons2/machinegun/machinegun.md3"*)

(* 
let wp = load_weapon "./openarena/models/weapons2/plasma/plasma.md3"
TGA reader doesn't like skin.tga
*)
let wr = load_weapon "./openarena/models/weapons2/railgun/railgun.md3"
let wrl = load_weapon "./openarena/models/weapons2/rocketl/rocketl.md3"
let ws = load_weapon "./openarena/models/weapons2/shotgun/shotgun.md3"

(* OpenArena models.  GPL'ed.  These are a little more resource intensive
   than the original Quake models, so I can't have them taunt while waiting.
   They simply stand. *)

(* angelyss - HUGE *)

let arachna = Player.load_player "./openarena/models/players/arachna/"
let arachna_black = Player.reskin_player [
    ("h_head","models/players/arachna/TorsoRed.tga");
    ("h_ears","models/players/arachna/TorsoRed.tga");
    ("h_hair","models/players/arachna/hairred.tga");
    ("u_body","models/players/arachna/TorsoRed.tga");
    ("u_body1","models/players/arachna/TorsoRed.tga");
    ("u_ears","models/players/arachna/TorsoRed.tga");
    ("u_jewelry","models/players/arachna/jewelry3.tga");
    ("u_hair","models/players/arachna/hairred.tga");
    ("l_spider","models/players/arachna/redspider.tga");
] arachna

let arachna_white = Player.reskin_player [
    ("h_head","models/players/arachna/TorsoBlue.tga");
    ("h_ears","models/players/arachna/TorsoBlue.tga");
    ("h_hair","models/players/arachna/hair.tga");
    ("u_body","models/players/arachna/TorsoBlue.tga");
    ("u_body1","models/players/arachna/TorsoBlue.tga");
    ("u_ears","models/players/arachna/TorsoBlue.tga");
    ("u_jewelry","models/players/arachna/jewelry3.tga");
    ("u_hair","models/players/arachna/hair.tga");
    ("l_spider","models/players/arachna/bluespider.tga");
] arachna

let arachna_anim_death = set_dead_anim (0,29,30)
let arachna_anim_idle = set_anim (181,15,12) (95,37,13) 84 154
let arachna_anim_idle = set_anim (181,15,12) (154,1,6) 84 154
let arachna_anim_walk = set_anim (124,10,10) (154,1,6) 84 154

let arachna_models = {white_skin=arachna_white;
                      black_skin=arachna_black;
                      weapon=wl;
                      animation={idle=arachna_anim_idle;
                                 walk=arachna_anim_walk;
                                 death=arachna_anim_death;}}

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
    ("l_jet","models/players/ayumi/jet/jet3e.tga");
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
    ("l_jet","models/players/ayumi/jet/jet3e.tga");
] ayumi

let ayumi_anim_death = set_dead_anim (0,29,15)
let ayumi_anim_idle = set_anim (181,1,12) (95,37,13) 89 154
let ayumi_anim_idle = set_anim (181,1,12) (154,1,6) 89 154
let ayumi_anim_walk = set_anim (124,10,15) (154,1,6) 89 154

let ayumi_models = {white_skin=ayumi_white;
                      black_skin=ayumi_black;
                      weapon=wrl;
                      animation={idle=ayumi_anim_idle;
                                 walk=ayumi_anim_walk;
                                 death=ayumi_anim_death;}}



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

let assassin_models = {white_skin=assassin_white;
                      black_skin=assassin_black;
                      weapon=wl;
                      animation={idle=assassin_anim_idle;
                                 walk=assassin_anim_walk;
                                 death=assassin_anim_death;}}


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

let gargoyle_models = {white_skin=gargoyle_white;
                      black_skin=gargoyle_black;
                      weapon=wl;
                      animation={idle=gargoyle_anim_idle;
                                 walk=gargoyle_anim_walk;
                                 death=gargoyle_anim_death;}}

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

let kyonshi_models = {white_skin=kyonshi_white;
                      black_skin=kyonshi_black;
                      weapon=wr;
                      animation={idle=kyonshi_anim_idle;
                                 walk=kyonshi_anim_walk;
                                 death=kyonshi_anim_death;}}


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

let major_models = {white_skin=major_white;
                      black_skin=major_black;
                      weapon=wg;
                      animation={idle=major_anim_idle;
                                 walk=major_anim_walk;
                                 death=major_anim_death;}}


(* MERMAN - weird stuff on blue  *)
(*
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

let merman_models = {white_skin=merman_white;
                      black_skin=merman_black;
                      weapon=wl;
                      animation={idle=merman_anim_idle;
                                 walk=merman_anim_walk;
                                 death=merman_anim_death;}}

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

let penguin_models = {white_skin=penguin_white;
                      black_skin=penguin_black;
                      weapon=ws;
                      animation={idle=penguin_anim_idle;
                                 walk=penguin_anim_walk;
                                 death=penguin_anim_death;}}


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

let sarge_models = {white_skin=sarge_white;
                      black_skin=sarge_black;
                      weapon=wbfg;
                      animation={idle=sarge_anim_idle;
                                 walk=sarge_anim_walk;
                                 death=sarge_anim_death;}}


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


let pawn = major_models
let rook = sarge_models
let knight = gargoyle_models (*arachna_models*)
let bishop = assassin_models
let queen = ayumi_models
let king = penguin_models

