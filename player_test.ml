(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

let m = Player.load_player "./pak0/models/players/mynx/"
let m_state = ref (Player.init_player_anim_state (111,128,111,20)
                      (95,134,95,15))
let s = Player.load_player "./pak0/models/players/sarge/"
let s_state =  ref (Player.init_player_anim_state (31,45,31,20)
                       (31,45,31,20))
let b = Player.load_player "./pak0/models/players/orbb/"
let b_state =  ref (Player.init_player_anim_state (141,148,141,10)
                       (99,104,99,20))
let r = Player.load_player "./pak0/models/players/slash/"
let r_state =  ref (Player.init_player_anim_state (97,107,97,20)
                       (134,137,134,20))
let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3"
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3"
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3"
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3"

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r, g, b, a));
  GlLight.material `front (`ambient (r, g, b, a))


let draw_axes () =
  (*Material to do color? *)
  (* Z - RED *)
  
  GlDraw.begins `lines;
  set_material_color 1.0 0.0 0.0 1.0;
  GlDraw.vertex3 (0.0,0.0,-250.0);
  GlDraw.vertex3 (0.0,0.0,250.0);
  
  (* X GREEN *)

  set_material_color 0.0 1.0 0.0 1.0;
  for i = -100 to 100 do
    let ymark = 10.0 *. (float_of_int i) in
      GlDraw.vertex3 (-1000.0,ymark,0.0);GlDraw.vertex3 (1000.0, ymark, 0.0)
  done;
  
  (* Y BLUE *)
  set_material_color 0.0 0.0 1.0 1.0;
  
  for i = 0 to 100 do
    let xmark = 10.0 *. (float_of_int i) in
      GlDraw.vertex3 (xmark,-1000.0,0.0);GlDraw.vertex3 (xmark,1000.0,0.0)
  done;

  GlDraw.ends ()

let lighting_init () =
  let light_ambient = 0.1, 0.1, 0.1, 1.0
  and light_diffuse = 0.2, 0.2, 0.2, 1.0
  and light_specular = 0.25, 0.25, 0.25, 1.0
  (*  light_position is NOT default value	*)
  and light_position = -25.0, 0.0, 50.0, 0.0
  in
  GlDraw.shade_model `smooth;

  GlLight.light ~num:0 (`ambient light_ambient);
  GlLight.light ~num:0 (`diffuse light_diffuse);
  GlLight.light ~num:0 (`specular light_specular);
  GlLight.light ~num:0 (`position light_position);

  List.iter Gl.enable [`lighting; `light0; `depth_test; `texture_2d]

let angle = ref 0.0
let xpos = ref 100.0
let xdir = ref false

let display () =
  Gl.enable `cull_face;
  GlDraw.cull_face `back;
  GlClear.color (0.25, 0.25, 0.25);
  GlClear.clear [`color];
  GlClear.clear [`depth];
  GlDraw.color (1.0, 1.0, 1.0);

  GlMat.mode `projection;
  GlMat.load_identity ();
  
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.mode `modelview;

  GlMat.load_identity ();

  GlMat.rotate ~angle:270.0 ~x:(1.0) ();
  GlMat.rotate ~angle:90.0 ~z:1.0 ();
      
  GlMat.translate ~x:(5.0) ();
  (*GlMat.rotate ~angle:!angle ~z:1.0 ();     
  angle := !angle +. 0.25;
  if !angle > 359.0 then angle := 0.0;*)

  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(-15.0) ();

  draw_axes ();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(-25.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  set_material_color 1.5 1.5 1.5 1.0; 
  Player.draw_player m wr !m_state;
  GlMat.pop();



  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(-25.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player s ws !s_state;
  GlMat.pop();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(-50.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player b wrl !b_state;

  GlMat.pop();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(-75.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player r wg !r_state;
  GlMat.pop();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(25.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player m ws !m_state;
  GlMat.pop();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(50.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player b wg !b_state;
  GlMat.pop();

  GlMat.push();
  GlMat.translate ~x:(!xpos) ~y:(75.0) ~z:(0.0) ();
  if !xdir = true then GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  Player.draw_player s wr !s_state;
  GlMat.pop();

  if !xdir = false then xpos := !xpos +. 0.5 else xpos := !xpos -. 0.5;
  if !xpos > 500.0 then xdir := true;
  if !xpos < 1.0 then xdir := false;

  lighting_init(); 

  Gl.flush ();

  let new_time = Unix.gettimeofday () in
    begin
      m_state := Player.update_player_anim_state new_time !m_state;
      s_state := Player.update_player_anim_state new_time !s_state;
      b_state := Player.update_player_anim_state new_time !b_state;
      r_state := Player.update_player_anim_state new_time !r_state;
    end;
    

    

  Glut.postRedisplay () 

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.displayFunc ~cb:display;

  Glut.mainLoop()
  

let _ = main ()

