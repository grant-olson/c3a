


let pawn = Player.load_player "./pak0/models/players/orbb/";;
let pawn_state = ref (Player.init_player_anim_state (165,185,165,20)
                         (93,93,93,20));;


let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_state = ref (Player.init_player_anim_state (180,193,180,15)
                         (90,139,90,20))

let queen = Player.load_player "./pak0/models/players/mynx/"
let queen_state = ref (Player.init_player_anim_state (195,211,195,15)
                          (95,134,95,20))

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_state = ref (Player.init_player_anim_state (160,174,160,15)
                          (70,116,70,15))

let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_state = ref (Player.init_player_anim_state (194, 194, 194, 15)
                         (92, 131, 92, 19))

let king = Player.load_player "./pak0/models/players/xaero/"
let king_state = ref (Player.init_player_anim_state (193, 193, 193, 15)
                         (117,149, 117, 15))

let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r, g, b, a));
  GlLight.material `front (`ambient (r, g, b, a));;


let square_size = 50.0

let square_center (x,y) =
  let x_f = float_of_int x in
  let y_f = float_of_int y in
  let xc = (square_size *. -4.0) +. (square_size *. x_f) -. (square_size /. 2.0) in
  let yc = (square_size *. 4.0) -. (square_size *. y_f) +. (square_size /. 2.0) in
    (xc, yc)

let draw_squares () =
  for i = 1 to 8  do
    for j = 1 to 8 do
      let i_f = float_of_int i in
      let j_f = float_of_int j in
       let x1 = (-4.0 *. square_size) +. ((i_f -. 1.0) *. square_size) in
      let x2 = x1 +. square_size in
      let y1 = (4.0 *. square_size) -. ((j_f -. 1.0) *. square_size) in
      let y2 = y1 -. square_size in
      let even_row = (i mod 2) = 0 in
      let even_column = (j mod 2) = 0 in
        begin
          (if (even_row == false && even_column == false) or
            (even_row == true && even_column == true) then
              set_material_color 0.8 0.8 0.8 1.0
            else
              set_material_color 0.2 0.2 0.2 1.0);
          GlDraw.begins `quads;       
          GlDraw.vertex3 (x1, y1, 0.0);
          GlDraw.vertex3 (x1, y2, 0.0);
          GlDraw.vertex3 (x2, y2, 0.0);
          GlDraw.vertex3 (x2, y1, 0.0);
          GlDraw.ends ();
        end
        done
    done

let draw_player x y model weapon state dir =
  let x,y = square_center(x,y) in
    GlMat.push();
    set_material_color 1.0 1.0 1.0 1.0;
    GlMat.translate ~x:x ~y:y ~z:(0.0) ();
    (match dir with
        `black -> GlMat.rotate ~angle:270.0 ~z:1.0 ()
      | `white -> GlMat.rotate ~angle:90.0 ~z:1.0 ());
    Player.draw_player model weapon !state;
    GlMat.pop()

          

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

  List.iter Gl.enable [`lighting; `light0; `depth_test; `texture_2d];;

let angle = ref 0.0;;
let xpos = ref 100.0;;
let xdir = ref false;;

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

 
  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(-200.0) ();

  draw_squares ();
  set_material_color 1.0 0.0 0.0 1.0;

  for i = 1 to 8 do
    draw_player i 2 pawn wr pawn_state `black
  done;

  for i = 1 to 8 do
    draw_player i 7 pawn wr pawn_state `white
  done;
  
(* Knights *)

  draw_player 2 1 knight wr knight_state `black;
  draw_player 7 1 knight wr knight_state `black;
  draw_player 2 8 knight wr knight_state `white;
  draw_player 7 8 knight wr knight_state `white;

  (* queens *)
  draw_player 4 1 queen wr queen_state `black;
  draw_player 4 8 queen wr queen_state `white;

  (* bishops *)
  draw_player 3 1 bishop wr bishop_state `black;
  draw_player 6 1 bishop wr bishop_state `black;
  draw_player 3 8 bishop wr bishop_state `white;
  draw_player 6 8 bishop wr bishop_state `white;

  (* rooks *)
  draw_player 1 1 rook wr rook_state `black;
  draw_player 8 1 rook wr rook_state `black;
  draw_player 1 8 rook wr rook_state `white;
  draw_player 8 8 rook wr rook_state `white;


  (* kings *)
  draw_player 5 1 king wr king_state `black;
  draw_player 5 8 king wr king_state `white;

  lighting_init(); 

  Gl.flush ();

  let new_time = Unix.gettimeofday () in
    begin
      pawn_state := Player.update_player_anim_state new_time !pawn_state;
      knight_state := Player.update_player_anim_state new_time !knight_state;
      queen_state := Player.update_player_anim_state new_time !queen_state;
      bishop_state := Player.update_player_anim_state new_time !bishop_state;
      rook_state := Player.update_player_anim_state new_time !rook_state;
      king_state := Player.update_player_anim_state new_time !king_state;
    end;
    

    

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
