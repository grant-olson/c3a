(* LOAD GRAPHICS *)

let pawn = Player.load_player "./pak0/models/players/orbb/"
let pawn_anim_idle = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)
let pawn_anim_walk = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)
let pawn_anim_death = Player.init_player_anim_state (0,32,32,20) (0,32,32,20)

let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_anim_idle = Player.init_player_anim_state (180,193,180,15) (90,139,90,20)
let knight_anim_walk = Player.init_player_anim_state (98,114,98,23) (130,135,130,15)
let knight_anim_death = Player.init_player_anim_state (30,59,59,20) (30,59,59,20)

let queen = Player.load_player "./pak0/models/players/mynx/"
let queen_anim_idle = Player.init_player_anim_state (195,211,195,15) (95,134,95,20)
let queen_anim_walk = Player.init_player_anim_state (111,117,111,25) (135,140,135,15)
let queen_anim_death = Player.init_player_anim_state (62,94,94,20) (62,94,94,20)

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_anim_idle = Player.init_player_anim_state (160,174,160,15) (70,116,70,15)
let bishop_anim_walk = Player.init_player_anim_state (80,89,80,14) (117,122,117,15)
let bishop_anim_death = Player.init_player_anim_state (0,29,29,20) (0,29,29,20)
  
let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_anim_idle = Player.init_player_anim_state (194, 194, 194, 15) (92, 131, 92, 19)
let rook_anim_walk = Player.init_player_anim_state (108,129,108,28) (132,137,132,15)
let rook_anim_death = Player.init_player_anim_state (45,64,64,20) (45,64,64,20)

let king = Player.load_player "./pak0/models/players/xaero/"
let king_anim_idle = Player.init_player_anim_state (193, 193, 193, 15) (117,149, 117, 15)
let king_anim_walk = Player.init_player_anim_state (125,132,125,20) (150,155,150,15)
let king_anim_death = Player.init_player_anim_state (81,116,116,20) (81,116,116,20)


let wrl = Md3.load_md3_file "./pak0/models/weapons2/rocketl/rocketl_1.md3";;
let ws = Md3.load_md3_file "./pak0/models/weapons2/shotgun/shotgun.md3";;
let wr = Md3.load_md3_file "./pak0/models/weapons2/gauntlet/gauntlet.md3";;
let wg = Md3.load_md3_file "./pak0/models/weapons2/railgun/railgun.md3";;

(* TYPES *)

type piece_type = Pawn | Rook | Bishop | Knight | Queen | King
type side = Black | White

type piece = Piece of side * piece_type

type location = {x:int;y:int;}
type move = {move_from:location;move_to:location;}

type state = Waiting |Dying of move | Moving | ClickOne of location | ClickTwo of move

type active_piece = {loc:location;kind:piece;anim_state:Player.player_anim_state;}

let init_board () =
  [{loc={x=1;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=2;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=3;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=4;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=5;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=6;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=7;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};
   {loc={x=8;y=2;};kind=Piece(Black,Pawn);anim_state=pawn_anim_idle};

   {loc={x=1;y=1};kind=Piece(Black,Rook);anim_state=pawn_anim_idle};
   {loc={x=8;y=1};kind=Piece(Black,Rook);anim_state=rook_anim_idle};

   {loc={x=2;y=1};kind=Piece(Black,Knight);anim_state=knight_anim_idle};
   {loc={x=7;y=1};kind=Piece(Black,Knight);anim_state=knight_anim_idle};

   {loc={x=3;y=1};kind=Piece(Black,Bishop);anim_state=bishop_anim_idle};
   {loc={x=6;y=1};kind=Piece(Black,Bishop);anim_state=bishop_anim_idle};

   {loc={x=4;y=1};kind=Piece(Black,Queen);anim_state=queen_anim_idle};
   {loc={x=5;y=1};kind=Piece(Black,King);anim_state=king_anim_idle};

   {loc={x=1;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=2;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=3;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=4;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=5;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=6;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=7;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};
   {loc={x=8;y=7};kind=Piece(White,Pawn);anim_state=pawn_anim_idle};

   {loc={x=1;y=8};kind=Piece(White,Rook);anim_state=rook_anim_idle};
   {loc={x=8;y=8};kind=Piece(White,Rook);anim_state=rook_anim_idle};

   {loc={x=2;y=8};kind=Piece(White,Knight);anim_state=knight_anim_idle};
   {loc={x=7;y=8};kind=Piece(White,Knight);anim_state=knight_anim_idle};

   {loc={x=3;y=8};kind=Piece(White,Bishop);anim_state=bishop_anim_idle};
   {loc={x=6;y=8};kind=Piece(White,Bishop);anim_state=bishop_anim_idle};

   {loc={x=4;y=8};kind=Piece(White,Queen);anim_state=queen_anim_idle};
   {loc={x=5;y=8};kind=Piece(White,King);anim_state=king_anim_idle};
  ]


(* INIT GLOBALS *)
let moves = ref [ {move_from={x=4;y=7};move_to={x=4;y=5}};
                  {move_from={x=6;y=2};move_to={x=6;y=4}};
                  {move_from={x=3;y=8};move_to={x=7;y=4}};
                  {move_from={x=7;y=1};move_to={x=6;y=3}};
                  {move_from={x=5;y=7};move_to={x=5;y=6}};
                  {move_from={x=3;y=2};move_to={x=3;y=3}};
                  {move_from={x=4;y=8};move_to={x=8;y=4}};
                  {move_from={x=6;y=3};move_to={x=8;y=4}};
                ]

let active_players = ref (init_board ())

let start_anim = ref (Unix.gettimeofday ())
let moving_player_anim = ref pawn_anim_walk
let moving_player = ref None
let moving_player_pos = ref ( {x=4;y=7},{x=4;y=5} )

let hit_dest = ref false


let dead_piece = ref None
let dead_piece_pos = ref {x=1;y=1}
let dead_piece_anim = ref pawn_anim_death
let dead_piece_expires = ref 0.0

let current_state = ref Waiting

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

let calc_grid_pos x y =
  let x = (x /. square_size) +. 5.0  in
  let y = (y /. square_size) +. 5.0 in
   (int_of_float x), (int_of_float y)

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
  GlLight.material `front (`diffuse (r *. 0.5, g *. 0.5, b *. 0.5, a));
  GlLight.material `front (`ambient (r *. 0.5, g *. 0.5, b *. 0.5, a));;      

let draw_squares () =
  Gl.disable `texture_2d;
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
        Black -> GlMat.rotate ~angle:270.0 ~z:1.0 ()
      | White -> GlMat.rotate ~angle:90.0 ~z:1.0 ());
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

let really_draw loc k a =
  match k with
      Piece(x,Pawn) -> draw_player loc pawn wr a x
    | Piece(x,Bishop) -> draw_player loc bishop wr a x
    | Piece(x,Rook) -> draw_player loc rook wr a x
    | Piece(x,Knight) -> draw_player loc knight wr a x
    | Piece(x,King) -> draw_player loc king wr a x
    | Piece(x,Queen) -> draw_player loc queen wr a x

let draw_active_piece ap =
  match ap with
    {loc=loc;kind=k;anim_state=anim_state} ->
      really_draw loc k anim_state

let draw_dead_piece loc kind anim_state =
  really_draw loc kind anim_state

let draw_moving_player player_type start finish =
  let cur_x,cur_y = calc_current_pos start finish in
  let model = match player_type with
      Piece(_,Bishop) -> bishop
    | Piece(_,Pawn) -> pawn
    | Piece(_,Knight) -> knight
    | Piece(_,Rook) -> rook
    | Piece(_,King) -> king
    | Piece(_,Queen) -> queen
  in
    GlMat.push();
    set_material_color 1.0 1.0 1.0 1.0;
    GlMat.translate ~x:cur_x ~y:cur_y ~z:(0.0) ();
    GlMat.rotate ~angle:90.0 ~z:1.0 ();
    Player.draw_player model wr !moving_player_anim;
    GlMat.pop()
 

let rec check_for_piece lst x y =
  match lst with
      [] -> None
    | h :: t when h.loc.x = x && h.loc.y=y -> Some h.kind
    | h :: t -> check_for_piece t x y 


      

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
    match piece with
        Piece(_,Pawn) -> pawn_anim_idle
      | Piece(_,Knight) -> knight_anim_idle
      | Piece(_,Bishop) -> bishop_anim_idle
      | Piece(_,Rook) -> rook_anim_idle
      | Piece(_,Queen) -> queen_anim_idle
      | Piece(_,King) -> king_anim_idle
  in
    {loc=loc;kind=piece;anim_state=anim_state} :: lst

let valid_pawn_moves piece pieces =
  let m1x,m1y = match piece.kind with
      Piece(Black,_) -> piece.loc.x,(piece.loc.y + 1)
    | Piece(White,_) -> piece.loc.x,(piece.loc.y - 1) in
  let move1 = check_for_piece pieces m1x m1y in
    if move1 = None then [{x=m1x;y=m1y}] else []

let rec expand_move piece current_pos movex movey pieces acc =
  (* Generic expand move.  Move in given direction until
     we hit end of board, can't move becuase one of our pieces is there
     or can't move any further because we killed an apponent *)
  let my_color = match piece.kind with Piece(x,_) -> x in
  let new_pos = {x=current_pos.x + movex;y=current_pos.y + movey} in
    match new_pos with
        location when new_pos.x < 1 -> acc
      | location when new_pos.x > 8 -> acc
      | location when new_pos.y < 1 -> acc
      | location when new_pos.y > 8 -> acc
      | _ ->
          match check_for_piece pieces new_pos.x new_pos.y with
              Some Piece(x,_) when x = my_color -> acc
            | Some Piece(x,_) -> new_pos :: acc
            | None -> expand_move piece new_pos movex movey pieces (new_pos::acc)

let valid_rook_moves piece pieces =
  let left_moves = expand_move piece piece.loc (-1) 0 pieces [] in
  let up_moves = expand_move piece piece.loc 0 (-1) pieces [] in
  let right_moves = expand_move piece piece.loc 1 0 pieces [] in
  let down_moves = expand_move piece piece.loc 0 1 pieces [] in
    left_moves@up_moves@right_moves@down_moves

let valid_bishop_moves piece pieces =
  let up_left_moves = expand_move piece piece.loc (-1) 1 pieces [] in
  let up_right_moves = expand_move piece piece.loc (-1) (-1) pieces [] in
  let down_left_moves = expand_move piece piece.loc 1 1 pieces [] in
  let down_right_moves = expand_move piece piece.loc 1 (-1) pieces [] in
    up_left_moves@up_right_moves@down_right_moves@down_left_moves

let valid_queen_moves piece pieces =
  let rm = valid_rook_moves piece pieces in
  let bm = valid_bishop_moves piece pieces in
    rm@bm

let remove_bad_moves move_list side pieces =
  let minus_invalid = List.filter (fun a ->
    (a.x >= 1 && a.x <= 8 && a.y >= 1 && a.y <= 8)) move_list in
  let test_for_conflict side pieces move =
    match check_for_piece pieces move.x move.y with
        Some Piece(x,_) when x = side -> false
      | _ -> true
  in
    List.filter (fun a-> test_for_conflict side pieces a) move_list
    

let valid_king_moves piece pieces =
  let moves = [{x=piece.loc.x+1;y=piece.loc.y};
               {x=piece.loc.x-1;y=piece.loc.y};
               {x=piece.loc.x;y=piece.loc.y-1};
               {x=piece.loc.x;y=piece.loc.y+1};
               {x=piece.loc.x+1;y=piece.loc.y+1};
               {x=piece.loc.x+1;y=piece.loc.y-1};
               {x=piece.loc.x-1;y=piece.loc.y+1};
               {x=piece.loc.x-1;y=piece.loc.y-1}] in
  let side = match piece.kind with Piece(x,_) -> x in
    remove_bad_moves moves side pieces

let valid_knight_moves p pieces =
  let moves = [{x=p.loc.x+2;y=p.loc.y+1};{x=p.loc.x+2;y=p.loc.y-1};
               {x=p.loc.x-2;y=p.loc.y+1};{x=p.loc.x-2;y=p.loc.y-1};
               {x=p.loc.x+1;y=p.loc.y+2};{x=p.loc.x-1;y=p.loc.y+2};
               {x=p.loc.x+1;y=p.loc.y-2};{x=p.loc.x-1;y=p.loc.x-2}] in
  let side = match p.kind with Piece(x,_) -> x in
    remove_bad_moves moves side pieces

let validate_move pieces move =
  let startx,starty = move.move_from.x,move.move_from.y in
  let endx,endy = move.move_to.x,move.move_to.y in
  let piece,pieces = extract_piece_from_list pieces startx starty in
  let valid_moves = match piece with
      {kind=Piece(_,Pawn)} -> valid_pawn_moves piece pieces
    | {kind=Piece(_,Rook)} -> valid_rook_moves piece pieces
    | {kind=Piece(_,Bishop)} -> valid_bishop_moves piece pieces
    | {kind=Piece(_,Queen)} -> valid_queen_moves piece pieces
    | {kind=Piece(_,King)} -> valid_king_moves piece pieces
    | {kind=Piece(_,Knight)} -> valid_knight_moves piece pieces
  in
    List.mem {x=endx;y=endy} valid_moves

let set_move move =
  let start_x = move.move_from.x in
  let start_y = move.move_from.y in
  let np, ps = extract_piece_from_list !active_players start_x start_y in
  let anim = match np.kind with
      Piece(_,Pawn) -> pawn_anim_walk
    | Piece(_,Rook) -> rook_anim_walk
    | Piece(_,Bishop) -> bishop_anim_walk
    | Piece(_,Knight) -> knight_anim_walk
    | Piece(_,Queen) -> queen_anim_walk
    | Piece(_,King) -> king_anim_walk
  in
    moving_player := Some np.kind;
    moving_player_pos := ( move.move_from , move.move_to );
    moving_player_anim := anim;
    start_anim := Unix.gettimeofday ();
    active_players := ps;
    current_state := Moving

let is_move_done piece start finish =
  if
    is_at_destination start finish
  then
    begin
      current_state := Waiting;
      moving_player := None;
      active_players := add_piece_to_list !active_players piece finish.x finish.y;
    end
  else
    ()
          

let set_death m =
  let dp,ps = extract_piece_from_list !active_players m.move_to.x m.move_to.y in
  let kind = dp.kind in
  let anim = match kind with
      Piece(_,Pawn) -> pawn_anim_death
    | Piece(_,Rook) -> rook_anim_death
    | Piece(_,Bishop) -> bishop_anim_death
    | Piece(_,Knight) -> knight_anim_death
    | Piece(_,King) -> king_anim_death
    | Piece(_,Queen) -> queen_anim_death
  in
  let stop_time = 3.0 +. Unix.gettimeofday () in
    dead_piece := Some kind;
    dead_piece_anim := anim;
    dead_piece_pos := m.move_to;
    dead_piece_expires := stop_time;
    active_players := ps;
    current_state := Dying(m)


let set_action m =
  let piece = check_for_piece !active_players m.move_to.x m.move_to.y in
    match piece with
        Some x -> set_death m
      | None -> set_move m


(* MAIN DISPLAY LOOP *)

let handle_moving_player () =
  match !moving_player with
      Some x ->
          let start,finish =  !moving_player_pos in
            draw_moving_player x start finish;
            is_move_done x start finish
    | None -> ()

let handle_dead_piece () =
  match !dead_piece with
      Some x ->
        draw_dead_piece !dead_piece_pos x !dead_piece_anim
    | None -> ()

let update_anim_states () = 
  let new_time = Unix.gettimeofday () in
    active_players := List.map (fun x -> {x with anim_state=(Player.update_player_anim_state new_time x.anim_state)}) !active_players;
    moving_player_anim := Player.update_player_anim_state new_time !moving_player_anim;
    dead_piece_anim := Player.update_player_anim_state new_time !dead_piece_anim

let update_state () =
  match !current_state with
      Dying m ->
        let t = Unix.gettimeofday () in
          if t > !dead_piece_expires
          then
            begin
              dead_piece := None;
              set_move m
            end
          else ()
    | ClickTwo m ->
        let move_from, move_to = m.move_from, m.move_to in
        let from = (string_of_int move_from.x)^" "^(string_of_int move_from.y) in
        let moveto = (string_of_int move_to.x)^" "^(string_of_int move_to.y) in
        let text = from^ " => "^moveto in
          if validate_move !active_players m
          then
            set_action m
          else
            begin
              Glut.setWindowTitle "BAD MOVE";
              current_state := Waiting
            end
    | _ -> ()

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
  (*GlMat.rotate ~angle:75.0 ~z:1.0 ~y:1.0 ~x:(-1.0) ();*)

  draw_squares ();

  set_material_color 1.0 0.0 0.0 1.0;

  update_state ();

  Gl.enable `texture_2d;
  List.iter draw_active_piece !active_players;
  handle_moving_player ();
  handle_dead_piece ();

  lighting_init(); 

  Gl.flush ();
  Glut.swapBuffers ();

  update_anim_states ();
  Glut.postRedisplay ()

exception Mouse_click of (float * float * float)

let mouse ~button ~state ~x ~y =
  let z_in = 0.92 in
  let x,y,z = GluMat.unproject ((float_of_int x), (float_of_int y), z_in) in
  let x,y = calc_grid_pos x y in
  let text = (string_of_int x)^" "^(string_of_int y)^" " in
    match state with
        Glut.DOWN ->
          begin
            Glut.setWindowTitle text;
            match !current_state with
                Waiting -> current_state := ClickOne {x=x;y=y}
              | ClickOne a -> current_state := ClickTwo {move_from=a;move_to={x=x;y=y}}
              | _ -> ()
          end
      | _ -> ()
            
      

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~double_buffer:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.mouseFunc ~cb:mouse;
  Glut.displayFunc ~cb:display;

  Glut.mainLoop()

let _ = main ()

