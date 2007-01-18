(* LOAD GRAPHICS *)

let pawn = Player.load_player "./pak0/models/players/orbb/"
let pawn_anim_idle = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)
let pawn_anim_walk = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)

let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_anim_idle = Player.init_player_anim_state (180,193,180,15) (90,139,90,20)
let knight_anim_walk = Player.init_player_anim_state (98,114,98,23) (130,135,130,15)

let queen = Player.load_player "./pak0/models/players/mynx/"
let queen_anim_idle = Player.init_player_anim_state (195,211,195,15) (95,134,95,20)
let queen_anim_walk = Player.init_player_anim_state (111,117,111,25) (135,140,135,15)

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_anim_idle = Player.init_player_anim_state (160,174,160,15) (70,116,70,15)
let bishop_anim_walk = Player.init_player_anim_state (80,89,80,14) (117,122,117,15)

let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_anim_idle = Player.init_player_anim_state (194, 194, 194, 15) (92, 131, 92, 19)
let rook_anim_walk = Player.init_player_anim_state (108,129,108,28) (132,137,132,15)

let king = Player.load_player "./pak0/models/players/xaero/"
let king_anim_idle = Player.init_player_anim_state (193, 193, 193, 15) (117,149, 117, 15)
let king_anim_walk = Player.init_player_anim_state (125,132,125,20) (150,155,150,15)


let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;

(* TYPES *)

type piece_type = Pawn | Rook | Bishop | Knight | Queen | King

type piece = Black of piece_type | White of piece_type

type location = {x:int;y:int;}
type move = {move_from:location;move_to:location;}


type active_piece = {loc:location;kind:piece;anim_state:Player.player_anim_state;}

let init_board () =
  [{loc={x=1;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=2;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=3;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=4;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=5;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=6;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=7;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};
   {loc={x=8;y=2;};kind=Black Pawn;anim_state=pawn_anim_idle};

   {loc={x=1;y=1};kind=Black Rook;anim_state=pawn_anim_idle};
   {loc={x=8;y=1};kind=Black Rook;anim_state=rook_anim_idle};

   {loc={x=2;y=1};kind=Black Knight;anim_state=knight_anim_idle};
   {loc={x=7;y=1};kind=Black Knight;anim_state=knight_anim_idle};

   {loc={x=3;y=1};kind=Black Bishop;anim_state=bishop_anim_idle};
   {loc={x=6;y=1};kind=Black Bishop;anim_state=bishop_anim_idle};

   {loc={x=4;y=1};kind=Black Queen;anim_state=queen_anim_idle};
   {loc={x=5;y=1};kind=Black King;anim_state=king_anim_idle};

   {loc={x=1;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=2;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=3;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=4;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=5;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=6;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=7;y=7};kind=White Pawn;anim_state=pawn_anim_idle};
   {loc={x=8;y=7};kind=White Pawn;anim_state=pawn_anim_idle};

   {loc={x=1;y=8};kind=White Rook;anim_state=rook_anim_idle};
   {loc={x=8;y=8};kind=White Rook;anim_state=rook_anim_idle};

   {loc={x=2;y=8};kind=White Knight;anim_state=knight_anim_idle};
   {loc={x=7;y=8};kind=White Knight;anim_state=knight_anim_idle};

   {loc={x=3;y=8};kind=White Bishop;anim_state=bishop_anim_idle};
   {loc={x=6;y=8};kind=White Bishop;anim_state=bishop_anim_idle};

   {loc={x=4;y=8};kind=White Queen;anim_state=queen_anim_idle};
   {loc={x=5;y=8};kind=White King;anim_state=king_anim_idle};
  ]


(* INIT GLOBALS *)
let moves = ref [ {move_from={x=4;y=7};move_to={x=4;y=5}};
                  {move_from={x=6;y=2};move_to={x=6;y=4}};
                  {move_from={x=3;y=8};move_to={x=7;y=4}};
                  {move_from={x=7;y=1};move_to={x=6;y=3}};
                  {move_from={x=5;y=7};move_to={x=5;y=6}};
                  {move_from={x=3;y=2};move_to={x=3;y=3}};

                ]

let active_players = ref (init_board ())

let start_anim = ref (Unix.gettimeofday ())

let moving_player_anim = ref pawn_anim_walk

let moving_player = ref None

let moving_player_pos = ref ( {x=4;y=7},{x=4;y=5} )

let hit_dest = ref false

(* TRANSLATE BETWEEN BOARD COORDINATES AND X/Y VALS, COLLISION DETECTION, ETC *)

let square_size = 50.0

let square_center loc =
  let x_f = float_of_int loc.x in
  let y_f = float_of_int loc.y in
  let xc = (square_size *. -4.0) +. (square_size *. x_f) -. (square_size /. 2.0) in
  let yc = (square_size *. 4.0) -. (square_size *. y_f) +. (square_size /. 2.0) in
    (xc, yc)

let calc_current_pos start finish = 
  let start_x, start_y = square_center start in
  let end_x, end_y = square_center finish in
  let dif_x, dif_y = end_x -. start_x, end_y -. start_y in
  let currenttime = Unix.gettimeofday () in
  let delta = (currenttime -. !start_anim) /. 1.0  in
  let cur_x = start_x +. (dif_x *. delta) in
  let cur_y = start_y +. (dif_y *. delta) in
    cur_x, cur_y

let is_at_destination start finish =
  let cur_x,cur_y = calc_current_pos start finish in
  let dest_x,dest_y = square_center finish in
  let diff_x = dest_x -. cur_x in
  let diff_y = cur_y -. dest_y in
  let distance = sqrt ( (diff_x *. diff_x) +. (diff_y *. diff_y) ) in
  let epsilon = square_size /. 1.0 in
    Printf.printf "%f \n" distance;
    if
      distance <= epsilon
    then
      true
    else
      false

(* OPENGL DRAWING FUNCTIONS *)

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r, g, b, a));
  GlLight.material `front (`ambient (r, g, b, a));;      

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

let draw_player loc model weapon state dir =
  let x,y = square_center loc in
    GlMat.push();
    set_material_color 1.0 1.0 1.0 1.0;
    GlMat.translate ~x:x ~y:y ~z:(0.0) ();
    (match dir with
        `black -> GlMat.rotate ~angle:270.0 ~z:1.0 ()
      | `white -> GlMat.rotate ~angle:90.0 ~z:1.0 ());
    Player.draw_player model weapon state;
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

let draw_active_piece ap =
  let really_draw loc k a dir =
    match k with
        Pawn -> draw_player loc pawn wr a dir
      | Bishop -> draw_player loc bishop wr a dir
      | Rook -> draw_player loc rook wr a dir
      | Knight -> draw_player loc knight wr a dir
      | King -> draw_player loc king wr a dir
      | Queen -> draw_player loc queen wr a dir
  in
    match ap with
      {loc=loc;kind=Black k;anim_state=anim_state} ->
        really_draw loc k anim_state `black
      | {loc=loc;kind=White k;anim_state=anim_state} ->
          really_draw loc k anim_state `white

let draw_moving_player player_type start finish =
  let cur_x,cur_y = calc_current_pos start finish in
  let model = match player_type with
      Black Bishop -> bishop
    | White Bishop -> bishop
    | Black Pawn -> pawn
    | White Pawn -> pawn
    | Black Knight -> knight
    | White Knight -> knight
    | Black Rook -> rook
    | White Rook -> rook
    | Black King -> king
    | White King -> king
    | Black Queen -> queen
    | White Queen -> queen
  in

    GlMat.push();
    set_material_color 1.0 1.0 1.0 1.0;
    GlMat.translate ~x:cur_x ~y:cur_y ~z:(0.0) ();
    GlMat.rotate ~angle:90.0 ~z:1.0 ();
    Player.draw_player model wr !moving_player_anim;
    GlMat.pop()


let extract_piece_from_list lst xpos ypos =
  let rec ep lst x y acc =
    match lst with
        [] -> raise Not_found
      | h :: t when h.loc.x = x && h.loc.y=y -> h, t @ acc
      | h :: t -> ep t xpos ypos (h::acc)
  in
    ep lst xpos ypos []

let add_piece_to_list lst piece x y =
  let loc = {x=x;y=y} in
  let anim_state =
    let p = match piece with
        Black x -> x
      | White x -> x in
    match p with
        Pawn -> pawn_anim_idle
      | Knight -> knight_anim_idle
      | Bishop -> bishop_anim_idle
      | Rook -> rook_anim_idle
      | Queen -> queen_anim_idle
      | King -> king_anim_idle
  in
    {loc=loc;kind=piece;anim_state=anim_state} :: lst

let set_next_move () =
  moving_player := None;
  match !moves with
      [] -> ()
    | h::t ->
        let start_x = h.move_from.x in
        let start_y = h.move_from.y in
        let np, ps = extract_piece_from_list !active_players start_x start_y in
        let anim = match np.kind with
            Black Pawn -> pawn_anim_walk
          | White Pawn -> pawn_anim_walk
          | Black Rook -> rook_anim_walk
          | White Rook -> rook_anim_walk
          | Black Bishop -> bishop_anim_walk
          | White Bishop -> bishop_anim_walk
          | Black Knight -> knight_anim_walk
          | White Knight -> knight_anim_walk
          | Black Queen -> queen_anim_walk
          | White Queen -> queen_anim_walk
          | Black King -> king_anim_walk
          | White King -> king_anim_walk
        in
          moves := t;
          moving_player := Some np.kind;
          moving_player_pos := ( h.move_from , h.move_to );
          moving_player_anim := anim;
          start_anim := Unix.gettimeofday ();
          active_players := ps

let is_move_done piece start finish =
  if
    is_at_destination start finish
  then
    begin
      set_next_move ();
      active_players := add_piece_to_list !active_players piece finish.x finish.y;
    end
  else
    ()
          

(* MAIN DISPLAY LOOP *)

let handle_moving_player () =
  match !moving_player with
      Some x ->
          let start,finish =  !moving_player_pos in
            draw_moving_player x start finish;
            is_move_done x start finish
    | None -> set_next_move ()

let update_anim_states () = 
  let new_time = Unix.gettimeofday () in
    active_players := List.map (fun x -> {x with anim_state=(Player.update_player_anim_state new_time x.anim_state)}) !active_players;
    moving_player_anim := Player.update_player_anim_state new_time !moving_player_anim

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

  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(-250.0) ();
  GlMat.rotate ~angle:75.0 ~z:1.0 ~y:1.0 ~x:(-1.0) ();

  draw_squares ();

  set_material_color 1.0 0.0 0.0 1.0;

  List.iter draw_active_piece !active_players;
  handle_moving_player ();
 
  lighting_init(); 

  Gl.flush ();
  Glut.swapBuffers ();

  update_anim_states ();
  Glut.postRedisplay ()

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~double_buffer:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.displayFunc ~cb:display;

  Glut.mainLoop()

let _ = main ()

