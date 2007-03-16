(* LOAD GRAPHICS *)

let pawn = Player.load_player "./pak0/models/players/orbb/"
let pawn_black = Player.reskin_player [
    ("h_head","models/players/orbb/red_h.tga");
    ("u_ratchet","models/players/orbb/red.tga");
    ("u_antenna","models/players/orbb/red.tga");
    ("u_antennaball","models/players/orbb/orbb_light_red.tga");
    ("u_tailight","models/players/orbb/orbb_tail_red.tga");
    ("u_torso","models/players/orbb/red.tga");
    ("l_legs","models/players/orbb/red.tga");] pawn

let pawn_white = Player.reskin_player  [
    ("h_head","models/players/orbb/blue_h.tga");
    ("u_ratchet","models/players/orbb/blue.tga");
    ("u_antenna","models/players/orbb/blue.tga");
    ("u_antennaball","models/players/orbb/orbb_light_blue.tga");
    ("u_tailight","models/players/orbb/orbb_tail_blue.tga");
    ("u_torso","models/players/orbb/blue.tga");
    ("l_legs","models/players/orbb/blue.tga");
  ] pawn

let pawn_anim_idle = Player.init_player_anim_state (165,185,165,20) (93,93,93,20)
let pawn_anim_walk = Player.init_player_anim_state (100,111,100,20) (93,93,93,20)
let pawn_anim_death = Player.init_player_anim_state (0,32,32,20) (0,32,32,20)

let knight = Player.load_player "./pak0/models/players/hunter/"
let knight_anim_idle = Player.init_player_anim_state (180,193,180,15) (90,139,90,20)
let knight_anim_walk = Player.init_player_anim_state (98,114,98,23) (130,135,130,15)
let knight_anim_death = Player.init_player_anim_state (30,59,59,20) (30,59,59,20)
let knight_black = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/red_h.tga");
    ("u_torso","models/players/hunter/red.tga");
    ("l_legs","models/players/hunter/red.tga"); ] knight

let knight_white = Player.reskin_player [
    ("h_feathers","models/players/hunter/red_f.tga");
    ("h_head","models/players/hunter/blue_h.tga");
    ("u_torso","models/players/hunter/blue.tga");
    ("l_legs","models/players/hunter/blue.tga");] knight

let queen = Player.load_player "./pak0/models/players/mynx/"
let queen_anim_idle = Player.init_player_anim_state (195,211,195,15) (95,134,95,20)
let queen_anim_walk = Player.init_player_anim_state (111,117,111,25) (111,127,11,25)
let queen_anim_death = Player.init_player_anim_state (62,94,94,20) (62,94,94,20)
let queen_black = Player.reskin_player [
    ("h_glasses","models/players/mynx/red_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/red_s.tga");
    ("l_legs","models/players/mynx/red_s.tga"); ] queen

let queen_white = Player.reskin_player [
    ("h_glasses","models/players/mynx/blue_s.tga");
    ("h_head","models/players/mynx/red_h.tga");
    ("u_arms","models/players/mynx/mynx.tga");
    ("u_torso","models/players/mynx/blue_s.tga");
    ("l_legs","models/players/mynx/blue_s.tga");
    ("tag_torso","")] queen

let bishop = Player.load_player "./pak0/models/players/slash/"
let bishop_anim_idle = Player.init_player_anim_state (160,174,160,15) (70,116,70,15)
let bishop_anim_walk = Player.init_player_anim_state (80,89,80,14) (117,122,117,15)
let bishop_anim_death = Player.init_player_anim_state (0,29,29,20) (0,29,29,20)
let bishop_black = Player.reskin_player [
    ("h_head","models/players/slash/red_h.tga");
    ("u_torso","models/players/slash/red.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/red.tga");
  ] bishop

let bishop_white = Player.reskin_player [
    ("h_head","models/players/slash/blue_h.tga");
    ("u_torso","models/players/slash/blue.tga");
    ("l_skatel","models/players/slash/slashskate.TGA");
    ("l_skater","models/players/slash/slashskate.TGA");
    ("l_legs","models/players/slash/blue.tga");] bishop
  

let rook = Player.load_player "./pak0/models/players/tankjr/"
let rook_anim_idle = Player.init_player_anim_state (194, 194, 194, 15) (92, 131, 92, 19)
let rook_anim_walk = Player.init_player_anim_state (108,129,108,28) (132,137,132,15)
let rook_anim_death = Player.init_player_anim_state (45,64,64,20) (45,64,64,20)
let rook_black = Player.reskin_player [
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

  ] rook

let rook_white = Player.reskin_player [
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
    ("l_lcalf","models/players/tankjr/blue.tga");] rook

let king = Player.load_player "./pak0/models/players/xaero/"
let king_anim_idle = Player.init_player_anim_state (193, 193, 193, 15) (117,149, 117, 15)
let king_anim_walk = Player.init_player_anim_state (125,132,125,20) (150,155,150,15)
let king_anim_death = Player.init_player_anim_state (81,116,116,20) (81,116,116,20)
let king_black = Player.reskin_player [
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
  ] king
let king_white = Player.reskin_player [
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
    ("l_sash_front","models/players/xaero/blue.tga")] king


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

type state = Introduction | Waiting |Dying of move | Moving | ClickOne of location | ClickTwo of move | PauseUntil of float

type active_piece = {loc:location;kind:piece;anim_state:Player.player_anim_state;}


type quadrants = TopLeft | TopRight | BottomLeft | BottomRight

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


let active_pieces = ref (init_board ())

let moving_piece_start_anim = ref (Unix.gettimeofday ())
let moving_piece_anim = ref pawn_anim_walk
let moving_piece = ref None
let moving_piece_pos = ref ( {x=4;y=7},{x=4;y=5} )

let hit_dest = ref false


let dead_piece = ref None
let dead_piece_pos = ref {x=1;y=1}
let dead_piece_anim = ref pawn_anim_death
let dead_piece_expires = ref 0.0

let current_state = ref Introduction
let current_player = ref White

let current_view = ref (fun () -> ())

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
  let delta = (currenttime -. !moving_piece_start_anim) /. 2.5 in
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
  let epsilon = square_size /. 5.0 in
    Printf.printf "%f \n" distance;
    if
      distance <= epsilon
    then
      true
    else
      false

(* Various Predicates and tests *)

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

let get_players_pieces color pieces =
  let right_side piece =
    match piece.kind with
        Piece(x,_) when x == color -> true
      | _ -> false
  in
    List.filter right_side pieces



(* CALCULATE VALID MOVES FOR A GIVEN PIECE *)

let valid_pawn_moves piece pieces =
  let check_normal_move offset =
    let mx,my = match piece.kind with
        Piece(Black,_) -> piece.loc.x,(piece.loc.y + offset)
      | Piece(White,_) -> piece.loc.x,(piece.loc.y - offset) in
    let pos = check_for_piece pieces mx my in
      if pos = None then [{x=mx;y=my}] else []
  in
  let check_kill_move offset color =
    let mx,my = match piece.kind with
        Piece(Black,_) -> (piece.loc.x + offset),(piece.loc.y + 1)
      | Piece(White,_) -> (piece.loc.x + offset),(piece.loc.y - 1) in
    let pos = check_for_piece pieces mx my in
      match pos with
          Some Piece(x,_) when x != color -> [{x=mx;y=my}]
        | _ -> []
  in
  let move1 = check_normal_move 1 in
  let starting_pos = match piece.kind with
      Piece(Black,_) -> piece.loc.y == 2
    | Piece(White,_) -> piece.loc.y == 7 in
  let move2 =
    if (move1 != []) && starting_pos
    then check_normal_move 2 else [] in
  let active_piece_color = match piece.kind with Piece(x,_) -> x in
  let move3 = check_kill_move 1 active_piece_color in
  let move4 = check_kill_move (-1) active_piece_color in
    move1@move2@move3@move4

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

let valid_move_list piece pieces = match piece with
    {kind=Piece(_,Pawn)} -> valid_pawn_moves piece pieces
  | {kind=Piece(_,Rook)} -> valid_rook_moves piece pieces
  | {kind=Piece(_,Bishop)} -> valid_bishop_moves piece pieces
  | {kind=Piece(_,Queen)} -> valid_queen_moves piece pieces
  | {kind=Piece(_,King)} -> valid_king_moves piece pieces
  | {kind=Piece(_,Knight)} -> valid_knight_moves piece pieces

let validate_move pieces move =
  let validate_start_and_end_pos pieces move =
    let startx,starty = move.move_from.x,move.move_from.y in
    let endx,endy = move.move_to.x,move.move_to.y in
    let piece,pieces = extract_piece_from_list pieces startx starty in
    let start_color = match piece.kind with
        Piece(x,_) -> x in
    let valid_moves = valid_move_list piece pieces in
      if
        start_color == !current_player
      then
        List.mem {x=endx;y=endy} valid_moves
      else
        false
  in
    try
      validate_start_and_end_pos pieces move
    with
        Not_found -> false (* bad starting pos *)

let check_for_check color pieces =
  let rec test_individual_piece my_pieces all_pieces =
    match my_pieces with
        [] -> false
      | h::t ->
          let hmoves = valid_move_list h all_pieces in
          let dest = List.map (fun a -> check_for_piece all_pieces a.x a.y) hmoves in
          let check_king = List.exists (fun a ->
            match a with
                Some Piece(_,King) -> true
              | _ -> false)
          in
            if check_king dest
            then true
            else test_individual_piece t all_pieces
            
  in
  let my_pieces = get_players_pieces color pieces in
    test_individual_piece my_pieces pieces

let set_move move =
  let start_x = move.move_from.x in
  let start_y = move.move_from.y in
  let np, ps = extract_piece_from_list !active_pieces start_x start_y in
  let anim = match np.kind with
      Piece(_,Pawn) -> pawn_anim_walk
    | Piece(_,Rook) -> rook_anim_walk
    | Piece(_,Bishop) -> bishop_anim_walk
    | Piece(_,Knight) -> knight_anim_walk
    | Piece(_,Queen) -> queen_anim_walk
    | Piece(_,King) -> king_anim_walk
  in
    moving_piece := Some np.kind;
    moving_piece_pos := ( move.move_from , move.move_to );
    moving_piece_anim := anim;
    moving_piece_start_anim := Unix.gettimeofday ();
    active_pieces := ps;
    current_state := Moving

         

let set_death m =
  let dp,ps = extract_piece_from_list !active_pieces m.move_to.x m.move_to.y in
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
    active_pieces := ps;
    current_state := Dying(m)


let set_action m =
  let piece = check_for_piece !active_pieces m.move_to.x m.move_to.y in
    match piece with
        Some x -> set_death m
      | None -> set_move m


let vect_to_angle x y =
  let pi = 3.1415926535897931 in
  let two_pi = pi *. 2.0 in
  let rads = atan2 x y in
    rads /. two_pi *. 360.0

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
              set_material_color 1.0 0.2 0.2 1.0
            else
              set_material_color 0.95 0.95 1.2 1.0);
          GlDraw.begins `quads;       
          GlDraw.vertex3 (x1, y1, 0.0);
          GlDraw.vertex3 (x1, y2, 0.0);
          GlDraw.vertex3 (x2, y2, 0.0);
          GlDraw.vertex3 (x2, y1, 0.0);
          GlDraw.ends ();
        end
        done
    done

let draw_piece loc model weapon state dir =
  let x,y = square_center loc in
    GlMat.push();
    set_material_color 1.5 1.5 1.5 1.0;
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

  List.iter Gl.enable [`lighting; `light0; `depth_test; `texture_2d]

let really_draw loc k a =
  match k with
      Piece(Black,Pawn) -> draw_piece loc pawn_black wr a Black
    | Piece(White,Pawn) -> draw_piece loc pawn_white wr a White
    | Piece(Black,Bishop) -> draw_piece loc bishop_black wr a Black
    | Piece(White,Bishop) -> draw_piece loc bishop_white wr a White
    | Piece(Black,Rook) -> draw_piece loc rook_black wr a Black
    | Piece(White,Rook) -> draw_piece loc rook_white wr a White
    | Piece(White,Knight) -> draw_piece loc knight_white wr a White
    | Piece(Black,Knight) -> draw_piece loc knight_black wr a Black
    | Piece(Black,King) -> draw_piece loc king_black wr a Black
    | Piece(White,King) -> draw_piece loc king_white wr a White
    | Piece(Black,Queen) -> draw_piece loc queen_black wr a Black
    | Piece(White,Queen) -> draw_piece loc queen_white wr a White

let draw_active_piece ap =
  match ap with
    {loc=loc;kind=k;anim_state=anim_state} ->
      really_draw loc k anim_state

let draw_dead_piece loc kind anim_state =
  really_draw loc kind anim_state

let draw_moving_piece piece_type start finish =
  let cur_x,cur_y = calc_current_pos start finish in
  let model = match piece_type with
      Piece(Black,Bishop) -> bishop_black
    | Piece(White,Bishop) -> bishop_white
    | Piece(Black,Pawn) -> pawn_black
    | Piece(White,Pawn) -> pawn_white
    | Piece(Black,Knight) -> knight_black
    | Piece(White,Knight) -> knight_white
    | Piece(Black,Rook) -> rook_black
    | Piece(White,Rook) -> rook_white
    | Piece(Black,King) -> king_black
    | Piece(White,King) -> king_white
    | Piece(Black,Queen) -> queen_black
    | Piece(White,Queen) -> queen_white
  in
  let x = float_of_int (finish.x - start.x) in
  let y = float_of_int (finish.y - start.y) in
  let orig_angle = vect_to_angle x y in
  let angle = orig_angle -. 90.0 
  in
    GlMat.push();
    set_material_color 1.5 1.5 1.5 1.0;
    GlMat.translate ~x:cur_x ~y:cur_y ~z:(0.0) ();
    GlMat.rotate ~angle:angle ~z:1.0 ();
    Player.draw_player model wr !moving_piece_anim;
    GlMat.pop()

let overhead_view () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
    GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(-250.0) ()

let intro_view () =
  let seconds = 10.0 in
  let ct = Unix.gettimeofday () in
  let time = mod_float ct seconds in
  let pct = time /. seconds in
  let xdist = (pct *. (-200.0)) +. 150.0 in
  let blueside = (mod_float ct 20.0) > 10.0 in
    GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
    GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-75.0) ();
    GlMat.rotate ~angle:60.0 ~x:(-1.0) ();
    if blueside
    then
      begin
        GlMat.rotate ~angle:180.0 ~z:1.0 ();
        GlMat.translate ~y:(80.0) ~x:(-.xdist) ()
      end
    else
        GlMat.translate ~y:(-80.0) ~x:(xdist)  ()

let top_left_view () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-75.0) ();
  GlMat.rotate ~angle:45.0 ~x:(-1.0) ();
  GlMat.translate ~y:(40.0) ~x:(100.0) ()

let top_right_view () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-75.0) ();
  GlMat.rotate ~angle:45.0 ~x:(-1.0) ();
  GlMat.translate ~y:(40.0) ~x:(-100.0) ()

let bottom_right_view () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-75.0) ();
  GlMat.rotate ~angle:45.0 ~x:(-1.0) ();
  GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  GlMat.translate ~y:(-40.0) ~x:(-100.0) ()

let bottom_left_view () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-75.0) ();
  GlMat.rotate ~angle:45.0 ~x:(-1.0) ();
  GlMat.rotate ~angle:180.0 ~z:(1.0) ();
  GlMat.translate ~y:(-40.0) ~x:(100.0) ()



let set_camera m =
  let calc_quad pos =
    match pos with
        {x=x;y=y} when (x <= 4) && (y <= 4) -> TopLeft
      | {x=x;y=y} when (x > 4) && (y <= 4) -> TopRight
      | {x=x;y=y} when (x <= 4) && (y > 4) -> BottomLeft
      | _ -> BottomRight
  in
  let start_pos = calc_quad m.move_from in
  let end_pos = calc_quad m.move_to in
    current_view := match start_pos, end_pos with
        TopLeft,TopLeft -> top_left_view
      | TopRight,TopRight -> top_right_view
      | BottomLeft,BottomLeft -> bottom_left_view
      | BottomRight,BottomRight -> bottom_right_view
      | _,_ -> overhead_view

(* END OPEN GL FUNCTIONS *) 

(* MAIN DISPLAY LOOP *)

let is_move_done piece start finish =
  if
    is_at_destination start finish
  then
    begin
      let now = Unix.gettimeofday() in
        current_state := PauseUntil (now +. 2.0) ;
        moving_piece := None;
        active_pieces := add_piece_to_list !active_pieces piece finish.x finish.y;
        current_player := match !current_player with
            Black -> White
          | White -> Black
    end
  else
    ()

let handle_moving_piece () =
  match !moving_piece with
      Some x ->
          let start,finish =  !moving_piece_pos in
            draw_moving_piece x start finish;
            is_move_done x start finish
    | None -> ()

let handle_dead_piece () =
  match !dead_piece with
      Some x ->
        draw_dead_piece !dead_piece_pos x !dead_piece_anim
    | None -> ()

let update_anim_states () = 
  let new_time = Unix.gettimeofday () in
    active_pieces := List.map (fun x -> {x with anim_state=(Player.update_player_anim_state new_time x.anim_state)}) !active_pieces;
    moving_piece_anim := Player.update_player_anim_state new_time !moving_piece_anim;
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
        if validate_move !active_pieces m
        then
          begin
            set_camera m;
            set_action m
          end
        else
          begin
            Glut.setWindowTitle "BAD MOVE";
            current_state := Waiting
          end
    | PauseUntil t ->
        let current_time = Unix.gettimeofday () in
          if current_time > t
          then
            begin
              current_state := Waiting;
              current_view := overhead_view
            end
    | _ -> ()

let display_title_text () =
  (* FONTS *)

  GlMat.mode `projection;
  GlMat.load_identity ();

  GlMat.mode `modelview;
  GlMat.load_identity ();

  Gl.enable `texture_2d;
  Gl.enable `blend;
  GlFunc.blend_func ~src:`src_alpha ~dst:`one_minus_src_alpha;
  GlDraw.cull_face `front;
  GlClear.color (0.25, 0.25, 0.25);
  GlClear.clear [`depth];
  GlDraw.color (1.5, 1.5, 1.5);

  Gl.enable `texture_2d;
  Texture.set_current_texture "menu/art/font2_prop.tga";
  
  Q3Fonts.draw_string (-0.4) 0.9 0.175 "CHESS";
  Q3Fonts.draw_string (-0.15) 0.7 0.175 "III";
  Q3Fonts.draw_string (-0.4) 0.5 0.175 "ARENA";

  Gl.flush ()

let display_text () =
  match !current_state with
      Introduction -> display_title_text ()
    | _ -> ()

let display () =
  update_state ();

  Gl.enable `cull_face;
  GlDraw.cull_face `back;
  GlClear.color (0.25, 0.25, 0.25);
  GlClear.clear [`color];
  GlClear.clear [`depth];
  GlDraw.color (1.0, 1.0, 1.0);

  GlMat.mode `projection;
  GlMat.load_identity ();
  
  
  !current_view ();
  GlMat.mode `modelview;

  GlMat.load_identity ();


  draw_squares ();

  Gl.enable `texture_2d;
  List.iter draw_active_piece !active_pieces;
  handle_moving_piece ();
  handle_dead_piece ();

  lighting_init(); 

  Gl.flush ();

  display_text ();


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
              | Introduction -> current_state := Waiting;
                  current_view := overhead_view
              | _ -> ()
          end
      | _ -> ()
            
      

let main () =
  current_view := intro_view;
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~double_buffer:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.mouseFunc ~cb:mouse;
  Glut.displayFunc ~cb:display;
  

  Glut.mainLoop()

let _ = main ()

