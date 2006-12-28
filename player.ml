(*
Player model is build up of 3 md3s.  THis will probably be a class (once I learn how classes work!)
*)

open Md3;;

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r, g, b, a));
  GlLight.material `front (`ambient (r, g, b, a));;


let draw_axes () =
  (*Material to do color? *)
  (* Z - RED *)
  
  GlDraw.begins `lines;
  set_material_color 1.0 0.0 0.0 1.0;
  GlDraw.vertex3 (0.0,0.0,-250.0);
  GlDraw.vertex3 (0.0,0.0,250.0);
  
  (* X GREEN *)

  set_material_color 0.0 1.0 0.0 1.0;
  GlDraw.vertex3 (-250.0,0.0,0.0);
  GlDraw.vertex3 (250.0, 0.0, 0.0);
  
  (* Y BLUE *)
  set_material_color 0.0 0.0 1.0 1.0;
  GlDraw.vertex3 (0.0,-250.0,0.0);
  GlDraw.vertex3 (0.0,250.0,0.0);
 
  GlDraw.ends ();;


let leg_position = ref 0;;



let draw_player frame_no lower upper head =

  set_material_color 1.0 1.0 1.0 1.0;
  draw_md3 lower !leg_position;
  leg_position := !leg_position + 1;
  if !leg_position >= 200 then leg_position := 0;

  draw_md3 upper frame_no;
  draw_md3 head 0;;
 



(* test harness.  We should probably move at least some of this
  stuff to a 'player' module *)
let lower = load_md3_file "./pak0/models/players/sarge/lower.md3" ;;

let upper = load_md3_file "./pak0/models/players/sarge/upper.md3" ;;

let head = load_md3_file "./pak0/models/players/sarge/head.md3" ;;

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
  
  List.iter Gl.enable [`lighting; `light0; `depth_test];;

let angle = ref 0.0;;


let display () =
  Gl.enable `cull_face;
  GlDraw.cull_face `back;
  GlClear.color (0.0, 0.0, 0.0);
  GlClear.clear [`color];
  GlClear.clear [`depth];
  GlDraw.color (1.0, 1.0, 1.0);

  GlMat.mode `projection;
  GlMat.load_identity ();
  
  GlMat.ortho ~x:(-50.0,50.0) ~y:(-50.0,50.0) ~z:(-50.0,50.0);


  GlMat.mode `modelview;

  GlMat.load_identity ();

  GlMat.rotate ~angle:270.0 ~x:(1.0) ();
  GlMat.rotate ~angle:90.0 ~z:1.0 ();
      
  GlMat.rotate ~angle:!angle ~z:1.0 ();     
  angle := !angle +. 1.0;
  if !angle > 359.0 then angle := 0.0;

  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(0.0) ();

  draw_axes ();

 
  draw_player 70 lower upper head;

  lighting_init(); 

  Gl.flush ();
  Unix.select [] [] [] 0.1;
  Glut.postRedisplay () ;;

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.displayFunc ~cb:display;

  Glut.mainLoop();
  ;;

let _ = main ()

