(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

exception Unknown_tga_format
type rgba = { r : int; g : int; b : int; a : int; }
type color_map_spec = {
  first_index : int;
  color_map_length : int;
  color_map_entry_size : int;
}
type image_spec = {
  xorg : int;
  yorg : int;
  width : int;
  height : int;
  px_depth : int;
  image_descriptor : int;
  }
type tga = {
  tga_id : int;
  color_map_type : int;
  image_type : int;
  cms : color_map_spec;
  spec : image_spec;
  rgb_data : rgba array array;
}
val read_tga_file : in_channel -> tga
val load_tga_file : string -> tga
