(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

let axes () = 
(* Draw the axes:
       X -> red
       Y -> green
       Z -> blue
*)
  GlDraw.begins `lines;

  (*X-AXIS- RED*)
  GlDraw.color (1.0,0.0,0.0);
  GlDraw.vertex3 (-50.0, 0.0, 0.0);
  GlDraw.vertex3 (50.0, 0.0, 0.0);

  (* Y-Axis - Green *)
  GlDraw.color (0.0,1.0,0.0);
  GlDraw.vertex3(0.0, -50.0, 0.0);
  GlDraw.vertex3(0.0, 50.0, 0.0);

  (* Z-Axis - Blue *)
  GlDraw.color (0.0,0.0,1.0);
  GlDraw.vertex3(0.0,0.0,-50.0);
  GlDraw.vertex3(0.0,0.0,50.0);

  GlDraw.ends ()

let diamond () =
  (* Draw a diamond with different colors on the sides so we
     have a frame of reference while testing rotations and transformations. *)

  GlDraw.begins `triangles;

  (* top-front - GREEN *)
  GlDraw.color (0.0, 1.0, 0.0);
  GlDraw.vertex3 (0.0,  25.0, 0.0);
  GlDraw.vertex3 ( -25.0,  0.0, -25.0);
  GlDraw.vertex3 ( 25.0, 0.0, -25.0);

  (* top-right - BLUE *)
  GlDraw.color (0.0, 0.0, 1.0);
  GlDraw.vertex3 (0.0,  25.0, 0.0);
  GlDraw.vertex3 (25.0,  0.0,-25.0);
  GlDraw.vertex3 (25.0, 0.0,  25.0);

  (*top-back - RED*)
  GlDraw.color (1.0, 0.0, 0.0);
  GlDraw.vertex3 (0.0,  25.0, 0.0);
  GlDraw.vertex3 ( 25.0,  0.0, 25.0);
  GlDraw.vertex3 ( -25.0, 0.0, 25.0);
       
  (*top-left - YELLOW*)
  GlDraw.color (1.0, 1.0, 0.0);
  GlDraw.vertex3 (0.0,  25.0, 0.0);
  GlDraw.vertex3 (-25.0, 0.0, 25.0);
  GlDraw.vertex3 (-25.0, 0.0, -25.0);

  (* bottom-front - WHITE *)
  GlDraw.color (1.0, 1.0, 1.0);
  GlDraw.vertex3 ( 25.0, 0.0, -25.0); 
  GlDraw.vertex3 ( -25.0,  0.0, -25.0);
  GlDraw.vertex3 (0.0,  -25.0, 0.0);


  (* bottom-right - MAGENTA *)
  GlDraw.color (1.0, 0.0, 1.0);
  GlDraw.vertex3 (25.0, 0.0,  25.0);
  GlDraw.vertex3 (25.0,  0.0,-25.0);
  GlDraw.vertex3 (0.0,  -25.0, 0.0);

  (*bottom-back - GRAY*)
  GlDraw.color (0.5, 0.5, 0.5);
  GlDraw.vertex3 ( -25.0, 0.0, 25.0);
  GlDraw.vertex3 ( 25.0,  0.0, 25.0);
  GlDraw.vertex3 (0.0,  -25.0, 0.0);
 
  (*bottom-left - cyan*)
  GlDraw.color (0.0, 1.0, 1.0);
  GlDraw.vertex3 (-25.0, 0.0, -25.0);      
  GlDraw.vertex3 (-25.0, 0.0, 25.0);
  GlDraw.vertex3 (0.0,  -25.0, 0.0);

  GlDraw.ends ()

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.displayFunc ~cb:
    begin fun () -> (* display callback *)
      Gl.enable `cull_face;
      GlDraw.cull_face `back;
      GlClear.color (0.0, 0.0, 0.0);
      GlClear.clear [`color];
      GlClear.clear [`depth];

      GlDraw.color (1.0, 1.0, 1.0);
      GlMat.mode `projection;
      GlMat.load_identity ();
      (*GlMat.ortho ~x:(-50.0,50.0) ~y:(-50.0,50.0) ~z:(-50.0,50.0);*)
      GlMat.frustum (-50.0,50.0) (-50.0,50.0) (-50.0,50.0);

      GlMat.mode `modelview;
      GlMat.load_identity ();
      GluMat.look_at (0.0,0.0,50.0) (0.0,0.0,0.0) (0.0,1.0,0.0);
      GlMat.scale ~x:0.5 ~y:0.5 ~z:0.5;
      axes ();
      diamond ();




      Gl.flush ()
    end;
  (* ignore (Timer.add ~ms:10000 ~callback:(fun () -> exit 0));  *)
  Glut.mainLoop();
  

let _ = main ()

