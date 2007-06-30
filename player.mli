type player = { lower : Md3.md3; upper : Md3.md3; head : Md3.md3; }
type anim_state = {
  time_to_advance : float;
  start_pos : int;
  end_pos : int;
  loop_pos : int;
  current_pos : int;
  frame_rate : float;
}
type player_anim_state = { leg : anim_state; torso : anim_state; }
val draw_player : player -> Md3.md3 -> player_anim_state -> unit
val load_player : string -> player

val init_player_anim_state :
  int * int * int * int -> int * int * int * int -> player_anim_state

val update_player_anim_state :
  float -> player_anim_state -> player_anim_state
val reskin_player : (string * string) list -> player -> player
