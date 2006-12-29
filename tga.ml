(* tga parsing *)

open Binfile;;


type rgb = {r:int;g:int;b:int;};;

type color_map_spec = {first_index:int;
                       color_map_length:int;
                       color_map_entry_size:int;};;

type image_spec = {xorg:int;
                   yorg:int;
                   width:int;
                   height:int;
                   px_depth:int;
                   image_descriptor:int;}

type tga = {tga_id:int;
            color_map_type:int;
            image_type:int;
            cms:color_map_spec;
            spec:image_spec;
            rgb_data:rgb array array;
           };;

let in_rgb f =
  let r = in_char f in
  let g = in_char f in
  let b = in_char f in
    {r=r;g=g;b=b;};;

let in_spec f =
  let xorg = in_word f in
  let yorg = in_word f in
  let width = in_word f in
  let height = in_word f in
  let px_depth = in_char f in
  let image_descriptor = in_char f in
    {xorg=xorg;yorg=yorg;width=width;height=height;px_depth=px_depth;
     image_descriptor=image_descriptor};;

let in_cms f =
  let first_index = in_word f in
  let color_map_length = in_word f in
  let color_map_entry_size = in_char f in
    {first_index=first_index;
     color_map_length=color_map_length;
     color_map_entry_size=color_map_entry_size};;

let read_tga_file f =
  let tga_id = in_char f in
  let color_map_type = in_char f in
  let image_type = in_char f in
  let cms = in_cms f in
  let spec = in_spec f in
  let rgb_data = in_array_array f spec.height spec.width in_rgb in
    {tga_id=tga_id;
     color_map_type=color_map_type;
     image_type=image_type;
    cms=cms;spec=spec;rgb_data=rgb_data;};;


let f = open_in_bin("./pak0/models/players/mynx/mynx.tga");;

let x = read_tga_file f;;

let _ = close_in f;;
