(* Copyright 2007-2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

exception Invalid_md3_format
type vector = { x : float; y : float; z : float; }
val print_vector : vector -> unit
type triangle = { a : int; b : int; c : int; }
type st = { s : float; t : float; }
type frame = {
  min_bounds : vector;
  max_bounds : vector;
  frame_origin : vector;
  radius : float;
  frame_name : string;
}
type tag = {
  tag_name : string;
  tag_origin : vector;
  axis1 : vector;
  axis2 : vector;
  axis3 : vector;
}
type vertex = {
  vx : float;
  vy : float;
  vz : float;
  nx : float;
  ny : float;
  nz : float;
}
type shader = { shader_name : string; shader_index : int; }
type surface = {
  surface_name : string;
  surface_flags : int32;
  surface_frame_count : int;
  shader_count : int;
  vertex_count : int;
  triangle_count : int;
  triangle_offset : int;
  shader_offset : int;
  st_offset : int;
  vertex_offset : int;
  end_offset : int;
  shaders : shader array;
  triangles : triangle array;
  sts : st array;
  vertexes : vertex array array;
}
type md3 = {
  path : string;
  flags : int32;
  md3_frame_count : int;
  tag_count : int;
  surface_count : int;
  skins : int;
  frame_offset : int;
  tag_offset : int;
  surface_offset : int;
  eof_offset : int;
  frames : frame array;
  tags : tag array array;
  surfaces : surface array;
}

val tag_to_matrix : tag -> GlMat.t
val get_tag : string -> md3 -> int -> tag

val draw_md3 : md3 -> int -> unit
val load_md3_file : string -> md3
val skin_md3 : md3 -> unit
val reskin_md3 : (string * string) list -> md3 -> md3
