(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* LOAD GRAPHICS *)

open C3aModels

(* TYPES *)

type piece_type = Pawn | Rook | Bishop | Knight | Queen | King
type side = Black | White
let repr_side s = match s with
    Black -> "Red"
  | White -> "Blue"

type piece = Piece of side * piece_type
let repr_piece p =
  let color = match p with
      Piece(s,_) -> repr_side s
  in
  let kind = match p with
      Piece(_,Pawn) -> "Pawn"
    | Piece(_,Rook) -> "Rook"
    | Piece(_,Bishop) -> "Bishop"
    | Piece(_,Knight) -> "Knight"
    | Piece(_,Queen) -> "Queen"
    | Piece(_,King) -> "King"
  in
    color ^ " " ^ kind

type location = {x:int;y:int;}
type move = {move_from:location;move_to:location;}

type player_type = Human | Computer
exception UninitializedCompOpponent

type state = Introduction | Waiting | Dying of location * move | Moving | Castling of move | ClickOne of location | ClickTwo of move | PauseUntil of float

type active_piece = {loc:location;kind:piece;anim_state:Player.player_anim_state;}

type notification = Check | Checkmate | Fragged | Intro

type views = IntroView | Overhead | BottomLeft | BottomRight | TopLeft | TopRight | MidLeft | MidRight | TopMid | BottomMid
type view_clip_zone = {top_left:location;bottom_right:location}

let init_board () =
  [{loc={x=1;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=2;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=3;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=4;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=5;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=6;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=7;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};
   {loc={x=8;y=2;};kind=Piece(Black,Pawn);anim_state=pawn.animation.idle};

   {loc={x=1;y=1};kind=Piece(Black,Rook);anim_state=pawn.animation.idle};
   {loc={x=8;y=1};kind=Piece(Black,Rook);anim_state=rook.animation.idle};

   {loc={x=2;y=1};kind=Piece(Black,Knight);anim_state=knight.animation.idle};
   {loc={x=7;y=1};kind=Piece(Black,Knight);anim_state=knight.animation.idle};

   {loc={x=3;y=1};kind=Piece(Black,Bishop);anim_state=bishop.animation.idle};
   {loc={x=6;y=1};kind=Piece(Black,Bishop);anim_state=bishop.animation.idle};

   {loc={x=4;y=1};kind=Piece(Black,Queen);anim_state=queen.animation.idle};
   {loc={x=5;y=1};kind=Piece(Black,King);anim_state=king.animation.idle};

   {loc={x=1;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=2;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=3;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=4;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=5;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=6;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=7;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};
   {loc={x=8;y=7};kind=Piece(White,Pawn);anim_state=pawn.animation.idle};

   {loc={x=1;y=8};kind=Piece(White,Rook);anim_state=rook.animation.idle};
   {loc={x=8;y=8};kind=Piece(White,Rook);anim_state=rook.animation.idle};

   {loc={x=2;y=8};kind=Piece(White,Knight);anim_state=knight.animation.idle};
   {loc={x=7;y=8};kind=Piece(White,Knight);anim_state=knight.animation.idle};

   {loc={x=3;y=8};kind=Piece(White,Bishop);anim_state=bishop.animation.idle};
   {loc={x=6;y=8};kind=Piece(White,Bishop);anim_state=bishop.animation.idle};

   {loc={x=4;y=8};kind=Piece(White,Queen);anim_state=queen.animation.idle};
   {loc={x=5;y=8};kind=Piece(White,King);anim_state=king.animation.idle};
  ]


(* INIT GLOBALS *)

let active_pieces = ref (init_board ())

let moving_piece_start_anim = ref (Unix.gettimeofday ())
let moving_piece_anim = ref pawn.animation.walk
let moving_piece = ref None
let moving_piece_pos = ref ( {x=4;y=7},{x=4;y=5} )

let hit_dest = ref false


let dead_piece = ref None
let dead_piece_pos = ref {x=1;y=1}
let dead_piece_anim = ref pawn.animation.death
let dead_piece_expires = ref 0.0

let current_state = ref Introduction
let current_player = ref White
let current_notification = ref (Some Intro)
let current_view = ref IntroView
let current_view_clip_zone = ref {top_left={x=1;y=1};bottom_right={x=8;y=8}} 

let white_player_type = ref Human
let black_player_type = ref Human

let move_history = ref []

let computerized_opponent = ref None

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
  let distance start_x start_y end_x end_y =
    (* calc distance via pythagorean *)
    let diff_x = end_x -. start_x in
    let diff_y = end_y -. start_y in
      sqrt ( (diff_x *. diff_x) +. (diff_y *. diff_y) ) in
  let start_x,start_y = square_center start in
  let dest_x,dest_y = square_center finish in
  let distance_to_dest = distance start_x start_y dest_x dest_y in
  let cur_x,cur_y = calc_current_pos start finish in
  let distance_travelled = distance start_x start_y cur_x cur_y in
    if distance_travelled > distance_to_dest
    then true (* we've passed the dest *)
    else false (* not there yet *)

let algebraic_of_loc loc =
  (* Turn a location struct into the equivilent Chess Algebraic Notation *)
  let xchar = match loc.x with
      1 -> "a"
    | 2 -> "b"
    | 3 -> "c"
    | 4 -> "d"
    | 5 -> "e"
    | 6 -> "f"
    | 7 -> "g"
    | 8 -> "h"
    | _ -> raise Not_found in
  let ychar = string_of_int (9 - loc.y) in
    xchar ^ ychar

let loc_of_algebraic alg =
  let xcoord = match alg.[0] with
      'a' -> 1
    | 'b' -> 2
    | 'c' -> 3
    | 'd' -> 4
    | 'e' -> 5
    | 'f' -> 6
    | 'g' -> 7
    | 'h' -> 8
    | _ -> raise Not_found in
  let ycoord = match alg.[1] with
      '1' -> 8
    | '2' -> 7
    | '3' -> 6
    | '4' -> 5
    | '5' -> 4
    | '6' -> 3
    | '7' -> 2
    | '8' -> 1
    | _ -> raise Not_found
  in
    {x=xcoord;y=ycoord}

let algebraic_of_move m =
  let move_from = algebraic_of_loc m.move_from in
  let move_to = algebraic_of_loc m.move_to in
    move_from ^ move_to

let move_of_algebraic alg =
  let move_from = loc_of_algebraic (String.sub alg 0 2) in
  let move_to = loc_of_algebraic (String.sub alg 2 2) in
    {move_from=move_from;move_to=move_to}
  

(* Various Predicates and tests *)

let get_player_type p =
  match p with
      Black -> !black_player_type
    | White -> !white_player_type

let get_other_player_type p =
  match p with
      Black -> !white_player_type
    | White -> !black_player_type

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

let remove_piece_from_list lst xpos ypos =
  (* if it is there to begin with *)
  try
    let _, newList = extract_piece_from_list lst xpos ypos in
      newList
  with Not_found ->
    lst

let add_piece_to_list lst piece x y =
  let loc = {x=x;y=y} in
  let anim_state =
    match piece with
        Piece(_,Pawn) -> pawn.animation.idle
      | Piece(_,Knight) -> knight.animation.idle
      | Piece(_,Bishop) -> bishop.animation.idle
      | Piece(_,Rook) -> rook.animation.idle
      | Piece(_,Queen) -> queen.animation.idle
      | Piece(_,King) -> king.animation.idle
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
  let check_pawn_en_passant offset color =
    let mx,my =  (piece.loc.x + offset),(piece.loc.y) in
    let dir = match piece.kind with
        Piece(Black,_) -> 1
      | Piece(White,_) -> -1
    in
    let is_piece_pawn = match check_for_piece pieces mx my with
        Some Piece(x,Pawn) when x != color -> true
      | _ -> false
    in
    let last_move = match !move_history with
        h :: t -> Some h
      | [] -> None
    in
    let was_last_move = match last_move with
        Some {move_from=_;move_to={x=x;y=y}} when x == mx && y == my -> true
      | _ -> false
    in
      if is_piece_pawn && was_last_move then
        [{x=mx;y=my+dir}]
      else
        []
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
  let move5 = check_pawn_en_passant 1 active_piece_color in
  let move6 = check_pawn_en_passant (-1) active_piece_color in
    move1@move2@move3@move4@move5@move6

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
  let move_list = List.filter (fun a ->
    (a.x >= 1 && a.x <= 8 && a.y >= 1 && a.y <= 8)) move_list in
  let test_for_conflict side pieces move =
    match check_for_piece pieces move.x move.y with
        Some Piece(x,_) when x = side -> false
      | _ -> true
  in
    List.filter (fun a-> test_for_conflict side pieces a) move_list
    

let valid_king_moves (piece : active_piece) (pieces : active_piece list) =
  let validate_castle_move (move : move) (pieces : active_piece list) : (location list) =
(*    let king,pieces = extract_piece_from_list pieces move.move_from.x move.move_from.y in *)
    let rec check_move_list piece_pos (moves : move list) =
      match moves with
          h :: t -> (if h.move_from.x == piece_pos.x && h.move_from.y == piece_pos.y
            then true
            else check_move_list piece_pos t)
        | [] -> false
    in 
    let is_home_pos = match piece.kind with
        Piece(Black,King) -> move.move_from.y == 1 && move.move_from.x == 5
      | Piece(White,King) -> move.move_from.y == 8 && move.move_from.x == 5
      | _ -> raise Not_found
    in
    let did_king_move loc =
      check_move_list loc !move_history
    in
    let get_rook_pos move =
      let x_pos = (if move.y == 3 then 1 else 8) in
        {move with x=x_pos}
    in
    let did_rook_move loc =
      check_move_list loc !move_history
    in
      if not is_home_pos then []
      else
        (if did_king_move move.move_from then []
          else
            let rp = get_rook_pos move.move_to in
              if did_rook_move rp then []
                else [move.move_to])
  in      
  let normal_moves : location list = [{x=piece.loc.x+1;y=piece.loc.y};
               {x=piece.loc.x-1;y=piece.loc.y};
               {x=piece.loc.x;y=piece.loc.y-1};
               {x=piece.loc.x;y=piece.loc.y+1};
               {x=piece.loc.x+1;y=piece.loc.y+1};
               {x=piece.loc.x+1;y=piece.loc.y-1};
               {x=piece.loc.x-1;y=piece.loc.y+1};
               {x=piece.loc.x-1;y=piece.loc.y-1}] in
  let castle_moves =
    let m1 = {x=piece.loc.x-2;y=piece.loc.y} in
    let m2 = {x=piece.loc.x+2;y=piece.loc.y} in
      (validate_castle_move {move_from=piece.loc;move_to=m1} pieces) @
        (validate_castle_move {move_from=piece.loc;move_to=m2} pieces) in
  let moves = (castle_moves) @ normal_moves in
  let side = match piece.kind with Piece(x,_) -> x in
    remove_bad_moves moves side pieces

let valid_knight_moves p pieces =
  let moves = [{x=p.loc.x+2;y=p.loc.y+1};{x=p.loc.x+2;y=p.loc.y-1};
               {x=p.loc.x-2;y=p.loc.y+1};{x=p.loc.x-2;y=p.loc.y-1};
               {x=p.loc.x+1;y=p.loc.y+2};{x=p.loc.x-1;y=p.loc.y+2};
               {x=p.loc.x+1;y=p.loc.y-2};{x=p.loc.x-1;y=p.loc.y-2}] in
  let side = match p.kind with Piece(x,_) -> x in
    remove_bad_moves moves side pieces

let valid_move_list piece pieces = match piece with
    {kind=Piece(_,Pawn)} -> valid_pawn_moves piece pieces
  | {kind=Piece(_,Rook)} -> valid_rook_moves piece pieces
  | {kind=Piece(_,Bishop)} -> valid_bishop_moves piece pieces
  | {kind=Piece(_,Queen)} -> valid_queen_moves piece pieces
  | {kind=Piece(_,King)} -> valid_king_moves piece pieces
  | {kind=Piece(_,Knight)} -> valid_knight_moves piece pieces

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

let check_if_checked_self pieces move color =
  let pieces = remove_piece_from_list pieces move.move_to.x move.move_to.y in
  let mp, pieces = extract_piece_from_list pieces move.move_from.x move.move_from.y in
  let new_pos = {mp with loc=move.move_to} in
  let new_list = new_pos :: pieces in
  let other_color = match color with
      Black -> White
    | White -> Black
  in
    check_for_check other_color new_list

let validate_move_start pieces loc =
  try
    let startx,starty = loc.x,loc.y in
    let piece,_ = extract_piece_from_list pieces startx starty in
    let start_color = match piece.kind with
        Piece(x,_) -> x in
      if start_color == !current_player then true else false
  with
      Not_found -> false
        

let validate_move pieces move =
  let validate_end_pos pieces move =
    let startx,starty = move.move_from.x,move.move_from.y in
    let endx,endy = move.move_to.x,move.move_to.y in
    let piece,pieces = extract_piece_from_list pieces startx starty in
    let valid_moves = valid_move_list piece pieces in
        List.mem {x=endx;y=endy} valid_moves
  in
    if validate_move_start pieces move.move_from then
      
        (if validate_end_pos pieces move
          then
            not (check_if_checked_self pieces move !current_player)
          else
            false)
    else
      false
 

let check_for_checkmate pieces current_color =
  let check_piece pieces piece =
    let rec test_moves pieces loc end_poses =
      let other_color = match current_color with
          Black -> White
        | White -> Black in
      match end_poses with
          h :: t ->
            let move = {move_from=loc;move_to=h} in
            let checked_self = check_if_checked_self pieces move other_color
              in
                (if checked_self then test_moves pieces loc t else false)
        | [] -> true
    in
    let end_poses = valid_move_list piece pieces in
      test_moves pieces piece.loc end_poses
  in
  let rec check_pieces pieces other_pieces =
    match other_pieces with
        h :: t ->
          (if check_piece pieces h then check_pieces pieces t else false)
      | [] -> true
  in
  let is_other_color x = match x.kind with
    Piece(x,_) -> x != current_color in
  let other_pieces = List.filter is_other_color pieces in
    check_pieces pieces other_pieces 
  

let set_move move =
  let start_x = move.move_from.x in
  let start_y = move.move_from.y in
  let np, ps = extract_piece_from_list !active_pieces start_x start_y in
  let anim = match np.kind with
      Piece(_,Pawn) -> pawn.animation.walk
    | Piece(_,Rook) -> rook.animation.walk
    | Piece(_,Bishop) -> bishop.animation.walk
    | Piece(_,Knight) -> knight.animation.walk
    | Piece(_,Queen) -> queen.animation.walk
    | Piece(_,King) -> king.animation.walk in
  let is_castle_move = match np.kind with
    | Piece(_,King) ->(if abs (move.move_from.x - move.move_to.x) == 2
      then true
      else false)
    | _ -> false in
  let rook_move p =
    if move.move_to.x == 3
    then
      {move_from={move.move_from with x=1};move_to={move.move_to with x=4}}
    else
      {move_from={move.move_from with x=8};move_to={move.move_to with x=6}}
      
  in
    move_history := move :: !move_history;
    moving_piece := Some np.kind;
    moving_piece_pos := ( move.move_from , move.move_to );
    moving_piece_anim := anim;
    moving_piece_start_anim := Unix.gettimeofday ();
    active_pieces := ps;
    (if is_castle_move then
        current_state := Castling(rook_move np)
      else current_state := Moving)

         

let set_death x m =
  let dp,ps = extract_piece_from_list !active_pieces x.x x.y in
  let kind = dp.kind in
  let anim = match kind with
      Piece(_,Pawn) -> pawn.animation.death
    | Piece(_,Rook) -> rook.animation.death
    | Piece(_,Bishop) -> bishop.animation.death
    | Piece(_,Knight) -> knight.animation.death
    | Piece(_,King) -> king.animation.death
    | Piece(_,Queen) -> queen.animation.death
  in
  let stop_time = 3.0 +. Unix.gettimeofday () in
    dead_piece := Some kind;
    dead_piece_anim := anim;
    dead_piece_pos := m.move_to;
    dead_piece_expires := stop_time;
    active_pieces := ps;
    current_state := Dying(x,m);
    current_notification := Some Fragged

let check_for_kill m =
  let normal_kill = match check_for_piece !active_pieces m.move_to.x m.move_to.y with
      Some x -> Some m.move_to
    | _ -> None
  in
  let is_move_pawn_kill move =
    let pawn = match check_for_piece !active_pieces m.move_from.x m.move_from.y with
        Some Piece(_,Pawn) -> true
      | _ -> false
    in
      (if pawn then
        (* Going diagonal means we're killing something *)
        (if m.move_from.x != m.move_to.x then true else false)
      else false)
  in
  let pawn_en_passant move =
    if is_move_pawn_kill m then
      (Some {x=m.move_to.x;y=m.move_from.y})
    else None
  in
    match normal_kill with
        Some x -> Some x
      | None -> pawn_en_passant m
          

let set_action m =
  let dead_piece = check_for_kill m in
    match dead_piece with
        Some x -> set_death x m
      | None -> set_move m


(* OPENGL DRAWING FUNCTIONS *)

let vect_to_angle x y =
  let pi = 3.1415926535897931 in
  let two_pi = pi *. 2.0 in
  let rads = atan2 x y in
    rads /. two_pi *. 360.0

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r *. 0.5, g *. 0.5, b *. 0.5, a));
  GlLight.material `front (`ambient (r *. 0.5, g *. 0.5, b *. 0.5, a))      

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
  let model = match k with
      Piece(_,Pawn) -> pawn
    | Piece(_,Bishop) -> bishop
    | Piece(_,Rook) -> rook
    | Piece(_,Knight) -> knight
    | Piece(_,King) -> king
    | Piece(_,Queen) -> queen in
  let skin,color = match k with
      Piece(Black,_) -> model.black_skin,Black
    | Piece(White,_) -> model.white_skin,White
  in
    draw_piece loc skin model.weapon a color

let in_clip_zone loc =
  let cv = !current_view_clip_zone in
  let top_left = cv.top_left in
  let bottom_right = cv.bottom_right in
  let in_x_range = (loc.x >= top_left.x) && (loc.x <= bottom_right.x) in
  let in_y_range = (loc.y >= top_left.y) && (loc.y <= bottom_right.y) in
    in_x_range && in_y_range

let draw_active_piece ap =
  match ap with
    {loc=loc;kind=k;anim_state=anim_state} ->
      if
        in_clip_zone loc
      then
        really_draw loc k anim_state
      else
        ()

let draw_dead_piece loc kind anim_state =
  really_draw loc kind anim_state

let draw_moving_piece piece_type start finish =
  let cur_x,cur_y = calc_current_pos start finish in
  let model = match piece_type with
      Piece(_,Bishop) -> bishop
    | Piece(_,Pawn) -> pawn
    | Piece(_,Knight) -> knight
    | Piece(_,Rook) -> rook
    | Piece(_,Queen) -> queen
    | Piece(_,King) -> king
  in
  let skin = match piece_type with
      Piece(Black,_) -> model.black_skin
    | Piece(White,_) -> model.white_skin
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
    (* FIXME *)
    Player.draw_player skin model.weapon !moving_piece_anim;
    GlMat.pop()

let overhead_view () =
  current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=8;y=8}};
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(25.0,1000.0);
  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(-250.0) ()

let intro_view () =
  let seconds = 10.0 in
  let ct = Unix.gettimeofday () in
  let time = mod_float ct seconds in
  let pct = time /. seconds in
  let xdist = (pct *. (-200.0)) +. 150.0 in
  let blueside = (mod_float ct 20.0) > 10.0 in
    GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(200.0,10000.0);
    GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-375.0) ();
    GlMat.rotate ~angle:60.0 ~x:(-1.0) ();
    if blueside
    then
      begin
        (*let xpos = xdist +. 75.0 in
        let xpos = xpos /. 25.0 in
        let xright = int_of_float (xpos +. 3.0) in
        let xleft = int_of_float (xpos -. 2.0) in
        Printf.printf "%f %f %i %i\n" xdist xpos xright xleft;
        flush stdout;*)
        current_view_clip_zone := {top_left={x=1;y=4};bottom_right={x=8;y=8}};
        GlMat.rotate ~angle:180.0 ~z:1.0 ();
        GlMat.translate ~y:(80.0) ~x:(-.xdist) ()
      end
    else
      begin
        current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=8;y=4}};
        GlMat.translate ~y:(-80.0) ~x:(xdist)  ()
      end

let detail_frustum camera_pitch = 
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(200.0,2000.0);
  GlMat.translate ~x:(0.0) ~y:(-75.0) ~z:(-650.0) ();
  GlMat.rotate ~angle:camera_pitch ~x:(-1.0) ()

let top_left_view () =
  detail_frustum 75.0;
  GlMat.translate ~y:(-160.0) ~x:(100.0) ~z:(75.0) ();
  GlMat.rotate ~angle:(-10.0) ~z:(1.0) ();
  current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=4;y=6}}

let top_mid_view () =
  detail_frustum 75.0;
  GlMat.translate ~y:(-120.0) ~x:(0.0) ~z:(75.0) ();
  current_view_clip_zone := {top_left={x=2;y=1};bottom_right={x=7;y=6}}

let top_right_view () =
  detail_frustum 75.0;
  GlMat.translate ~y:(-160.0) ~x:(-100.0) ~z:(75.0) ();
  GlMat.rotate ~angle:10.0 ~z:(1.0) ();
  current_view_clip_zone := {top_left={x=5;y=1};bottom_right={x=8;y=6}}


let mid_right_view () =
  detail_frustum 65.0;
  GlMat.rotate ~angle:(-75.0) ~z:(1.0) ();
  GlMat.translate ~y:(75.0) ~x:(-350.0) ~z:(-75.0) ();
  current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=8;y=7}}


let mid_left_view () =
  detail_frustum 65.0;
  GlMat.rotate ~angle:(75.0) ~z:(1.0) ();
  GlMat.translate ~y:(75.0) ~x:(350.0) ~z:(-100.0) ();
  current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=8;y=7}}


let bottom_right_view () =
  detail_frustum 75.0;
  GlMat.translate ~y:(125.0) ~x:(-150.0) ~z:(0.0) ();
  GlMat.rotate ~angle:25.0 ~z:(1.0) ();
  current_view_clip_zone := {top_left={x=5;y=1};bottom_right={x=8;y=8}}


let bottom_mid_view () =
  detail_frustum 75.0;
(*  GlMat.rotate ~angle:180.0 ~z:(1.0) ();*)
  GlMat.translate ~y:(150.0) ~x:(0.0) ~z:(0.0) ();
  current_view_clip_zone := {top_left={x=2;y=1};bottom_right={x=7;y=8}}


let bottom_left_view () =
  detail_frustum 75.0;
  GlMat.translate ~y:(125.0) ~x:(150.0) ~z:(0.0) ();
  GlMat.rotate ~angle:(-25.0) ~z:(1.0) ();
  current_view_clip_zone := {top_left={x=1;y=1};bottom_right={x=4;y=8}}


let set_current_view () =
  match !current_view with
      IntroView -> intro_view ()
    | Overhead -> overhead_view ()
    | BottomLeft -> bottom_left_view ()
    | BottomRight -> bottom_right_view ()
    | TopLeft -> top_left_view ()
    | TopRight -> top_right_view ()
    | MidLeft -> mid_left_view ()
    | MidRight -> mid_right_view ()
    | TopMid -> top_mid_view ()
    | BottomMid -> bottom_mid_view ()
        
let set_camera m =
  let between x a b =
    (x >= a) && (x <= b)
  in
  let both_between x1 x2 a b =
    (between x1 a b) && (between x2 a b)
  in
  let get_mid_camera end_pos =
    if end_pos.x >= 4 then MidRight else MidLeft
  in
  let get_top_camera start_pos end_pos =
    match start_pos.x,end_pos.x with
        x1,x2 when (both_between x1 x2 4 5) -> TopMid
      | x1,x2 when (both_between x1 x2 1 4) -> TopLeft
      | x1,x2 when (both_between x1 x2 5 8) -> TopRight
      | _ -> Overhead
  in
  let get_bottom_camera start_pos end_pos =
    match start_pos.x,end_pos.x with
        x1,x2 when (both_between x1 x2 4 5) -> BottomMid
      | x1,x2 when (both_between x1 x2 1 3) -> BottomLeft
      | x1,x2 when (both_between x1 x2 4 8) -> BottomRight
      | _ -> Overhead
  in
  let get_camera start_pos end_pos = 
    match start_pos.y, end_pos.y with
        y1,y2 when (both_between y1 y2 3 6) -> get_mid_camera end_pos
      | y1,y2 when (both_between y1 y2 1 4) -> get_top_camera start_pos end_pos
      | y1,y2 when (both_between y1 y2 5 8) -> get_bottom_camera start_pos end_pos
      | _ -> Overhead
  in
    current_view := get_camera m.move_from m.move_to

(* END OPEN GL FUNCTIONS *) 

(* MAIN DISPLAY LOOP *)

let finalize_move () =
  let now = Unix.gettimeofday() in
  current_state := PauseUntil (now +. 2.0) ;

  (if check_for_check !current_player !active_pieces
     then
       (if check_for_checkmate !active_pieces !current_player
        then
            current_notification := Some Checkmate
         else
        current_notification := Some Check));
   current_player := match !current_player with
        Black -> White
      | White -> Black
  

let is_move_done piece start finish =
  if
    is_at_destination start finish
  then
    begin
      moving_piece := None;
      active_pieces := add_piece_to_list !active_pieces piece finish.x finish.y;
      match !current_state with
          Castling(m) -> set_move m
        | _ -> finalize_move ()
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

let set_computer_move_state move =
  match move with
      x ->
	let m = move_of_algebraic x in
	  current_state := ClickTwo(m)

let rec set_current_state new_state =
  current_state := new_state;
  match new_state with
      Waiting ->
        let color = repr_side !current_player in
        let text = color ^ "'s move" in
          Glut.setWindowTitle text
    | ClickOne(loc) ->
        if validate_move_start !active_pieces loc then
           let color = repr_side !current_player in
           let piece , _ = extract_piece_from_list !active_pieces loc.x loc.y in
           let piece_desc = repr_piece piece.kind in
           let text = color ^ " selected " ^ piece_desc in
             Glut.setWindowTitle text
          else
            current_state := Waiting

      
    | _ -> ()

let send_move m =
  match !computerized_opponent with
      None -> ()
    | Some co ->
        let alg = algebraic_of_move m in
          CompOpponent.issue_move co  alg

(* We don't initialize gnuchess if you're not playing the computer,
   so it's an option type.  But this code should only get called when
   we know a computer exists.  It should never raise an error, but
   we don't want a compiler warning either. *)
let unwrap_comp_opponent () =
  match !computerized_opponent with 
      Some x -> x
    | None -> raise (UninitializedCompOpponent)

let update_state () =
  match !current_state with
      Dying(_,m) ->
        let t = Unix.gettimeofday () in
          if t > !dead_piece_expires
          then
            begin
              dead_piece := None;
              current_notification := None;
              set_move m
            end
          else ()
    | ClickTwo m ->
        if validate_move !active_pieces m
        then
          begin
            (if ((get_player_type !current_player) == Human) && ((get_other_player_type !current_player) == Computer) then send_move m);
            set_camera m;
            set_action m
          end
        else
          begin
            Printf.printf "rejected move %s\n" (algebraic_of_move m);
            flush stdout;
            Glut.setWindowTitle "c3a - Invalid Move - Try Again";
            set_current_state Waiting
          end
    | PauseUntil t ->
        let current_time = Unix.gettimeofday () in
          if current_time > t
          then
            begin
              current_notification := None;
              set_current_state Waiting;
              current_view := Overhead
            end
    | Waiting ->
        let player_type = get_player_type !current_player in
          if player_type == Computer
          then
            let move = CompOpponent.get_opponents_move (unwrap_comp_opponent ()) in
              set_computer_move_state move
          else
            ()
        
    | _ -> ()
      

let display_intro_text () =
  Q3Fonts.draw_string (-0.4) 0.9 0.175 "CHESS";
  Q3Fonts.draw_string (-0.125) 0.7 0.175 "III";
  Q3Fonts.draw_string (-0.4) 0.5 0.175 "ARENA"

let display_check_text () =
  Q3Fonts.draw_string (-0.4) 0.9 0.175 "CHECK"

let display_checkmate_text () =
  Q3Fonts.draw_string (-0.8) 0.9 0.175 "CHECKMATE"

let display_fragged_text () =
  Q3Fonts.draw_string (-0.6) 0.9 0.175 "FRAGGED"

let display_text () =

  (* FONTS *)
  let run_display display_func =
    (* For some reason, running this screws up the resolution of clicking
       on a given square, so we only want to run it when a person can't move
       I suppose we could figure out how to push and pop all the matricies,
       but why bother?
    *)
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

    display_func ();
    Gl.flush () in

  match !current_notification with
      Some Intro -> run_display display_intro_text
    | Some Check -> run_display display_check_text
    | Some Checkmate -> run_display display_checkmate_text
    | Some Fragged -> run_display display_fragged_text
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
  
  set_current_view ();
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
    match state with
        Glut.DOWN ->
          begin
            match !current_state with
                Waiting ->
                  let pt = get_player_type !current_player in
                    if pt = Human
                    then
                      set_current_state (ClickOne {x=x;y=y})
                    else
                      ()
              | ClickOne a -> current_state := ClickTwo {move_from=a;move_to={x=x;y=y}}
              | Introduction ->
		  (if (get_player_type !current_player) == Computer
		   then
		     let move = CompOpponent.get_opponents_first_move_if_white (unwrap_comp_opponent ()) in
		       set_computer_move_state move
		   else
		     set_current_state Waiting;
                     current_notification := None;
                     current_view := Overhead)
              | _ -> ()
          end
      | _ -> ()
            
      

let main () =
  current_view := IntroView;
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~double_buffer:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"c3a");
  Glut.mouseFunc ~cb:mouse;
  Glut.displayFunc ~cb:display;
  

  Glut.mainLoop()

(* parse command line args *)

let white_comp cmd =
  white_player_type := Computer;
  computerized_opponent := Some (CompOpponent.init_opponent cmd false)

let black_comp cmd =
  black_player_type := Computer;
  computerized_opponent := Some (CompOpponent.init_opponent cmd true)

let anon x =
  ()


let _ = Arg.parse [
  ("-red",Arg.String (black_comp),
   "Specify computer back-end to play red '-red gnuchess'");
  ("-blue",Arg.String (white_comp),
   "Specify computer back-end to play blue '-blue gnuchess'")] anon "c3a - Chess III Arena v0.6 (Copyright 2007-2010 Grant T Olson)\nOpenArena art Copyright OpenArena Project\nGLUT Copyright 1997 Mark J. Kilgard and Nate Robins\nLablGL bindings Copyright 1997-2001 Jacques Garrigue and Kyoto University\n\nBlue is 'white' and goes first.\n"


(* little bit of black magic for windows users, so they don't need
   the command line.  If gnuchess.exe is in the directory, and
   a computer player hasn't been specified, have computer play white *)

let comp_on_windows () = 
  let is_gnuchess_on_windows () =
    try
      let f = open_in_bin "./gnuchess.exe" in
      close_in f;
      true
    with
      Sys_error a -> false
  in
  let wp = !white_player_type in
  let bp = !black_player_type in
  let is_gnuchess = is_gnuchess_on_windows () in
    match wp,bp,is_gnuchess with
        Human, Human, true -> black_comp "gnuchess"
      | _ -> ()

let _ = comp_on_windows ()

let _ = main ()

