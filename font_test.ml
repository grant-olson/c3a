
let display () =
  (* Gl.enable `cull_face; *)
  Gl.enable `texture_2d;
  Gl.enable `blend;
  GlFunc.blend_func ~src:`src_alpha ~dst:`one_minus_src_alpha;
  (* GlDraw.cull_face `back; *)
  GlClear.color (0.25, 0.25, 0.25);
  GlClear.clear [`color];
  GlClear.clear [`depth];
  GlDraw.color (1.0, 1.0, 1.0);

  GlDraw.begins `line_strip;
  GlDraw.vertex2 (0.0,0.0);
  GlDraw.vertex2 (1.0,0.0);
  GlDraw.vertex2 (1.0,1.0);
  GlDraw.vertex2 (0.0,1.0);
  GlDraw.vertex2 (0.0,0.0);
  GlDraw.ends ();

  Gl.enable `texture_2d;
  Texture.set_current_texture "menu/art/font2_prop.tga";
  GlDraw.begins `quads;
  GlTex.coord2 (0.0,0.0);
  GlDraw.vertex2 ( (-0.5),(0.5));
  GlTex.coord2 (0.0,1.0);
  GlDraw.vertex2 ( (-0.5),(-0.5));
  GlTex.coord2(1.0,1.0);
  GlDraw.vertex2 (0.5,(-0.5));
  GlTex.coord2(1.0,0.0);
  GlDraw.vertex2 (0.5,0.5);
  GlDraw.ends ();
  
  Q3Fonts.draw_string (-1.0) 1.0 0.1 "THIS IS A TEST THIS IS only a test";

  (*Q3Fonts.draw_char (-1.0) 1.0 1.0 'A';
  Q3Fonts.draw_char 0.0 1.0 1.0 'K';
  Q3Fonts.draw_char (-1.0) 0.0 1.0 'B';
  Q3Fonts.draw_char (0.0) 0.0 1.0 'Z';*)


  GlMat.mode `projection;
  GlMat.load_identity ();
  

  Gl.flush ();

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

