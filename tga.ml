(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* tga parsing *)

exception Unknown_tga_format;;

open Binfile;;

let debug_print f d =
  Printf.printf f d;
  flush stdout

let debug_print f d = ()

type rgba = {r:int;g:int;b:int;a:int};;

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
            rgb_data:rgba array array;
           };;

let in_rgba f =
  let b = in_char f in
  let g = in_char f in
  let r = in_char f in
  let a = in_char f in (* should we use this later? *)
    {r=r;g=g;b=b;a=a};;

let in_rgb f =
  let b = in_char f in
  let g = in_char f in
  let r = in_char f in
  let a = 255 in
    {r=r;g=g;b=b;a=a};;

let in_color_data f spec =
  match spec.px_depth with
      32 -> in_rgba f
    | 24 -> in_rgb f
    | _ -> raise Unknown_tga_format;;
        

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
  debug_print "color map First index %i\n" first_index;
  let color_map_length = in_word f in
  debug_print "Color Map Length %i\n" color_map_length;
  let color_map_entry_size = in_char f in
    debug_print "Color map entry size %i\n" color_map_entry_size;
    {first_index=first_index;
     color_map_length=color_map_length;
     color_map_entry_size=color_map_entry_size};;

let flip_array a =
  let len = Array.length a in
    for i = 0 to (len / 2) do
      let tmp = a.(i) in
        a.(i) <- a.(len - i - 1);
        a.(len - i - 1) <- tmp
    done

let flip_rows aa =
  flip_array aa

let flip_columns aa =
  Array.iter flip_array aa

let read_run_length_encoded spec f =
  let a = Array.make_matrix spec.height spec.width {r=128;b=128;g=128;a=128} in
  let in_func = match spec.px_depth with
      32 -> in_rgba
    | _ -> in_rgb
  in
  let get_single_value () =
    let run_length = in_char f in
    let is_raw = (if run_length > 128 then false else true) in
    let run_length = (if run_length > 128 then run_length - 128 else run_length) in
    let run_length = run_length + 1 in
    let rgb = in_func f in
      is_raw,run_length,rgb
  in
  let expand_run_length_packet current_index current_row run_length color =
    for i = current_index to (current_index + run_length - 1) do
      a.(current_row).(i) <- color
    done
  in
  let expand_raw_length_packet current_index current_row run_length color =
    a.(current_row).(current_index) <- color;
    for i = (current_index + 1) to (current_index + run_length - 1) do
      let next_color = in_func f in
        a.(current_row).(i) <- next_color
    done
  in
  let rec expand_run_length_encoding row current_index =
    if current_index >= spec.width
    then
      ()
    else
      let is_raw, run_length, color = get_single_value () in
        (if is_raw then
          expand_raw_length_packet current_index row run_length color
        else
          expand_run_length_packet current_index row run_length color);
          (*debug_print "%s\n" "";*)
          expand_run_length_encoding row (current_index + run_length)      
  in
  let set_row row =
    debug_print "Setting row %i\n" row;
    expand_run_length_encoding row 0
  in
    debug_print "width %i\n" spec.width;
    debug_print "height %i\n" spec.height;
    for row = 0 to (spec.height - 1) do
      set_row row
    done;
    a

let read_rgb_data image_type spec f =
  match image_type with
      2 ->  in_array_array f spec.height spec.width (fun x -> in_color_data x spec)
    | 10 -> read_run_length_encoded spec f
    | _ -> raise Unknown_tga_format

let read_tga_file f =
  let tga_id = in_char f in
  debug_print "TGA ID %i\n" tga_id;
  let color_map_type = in_char f in
  debug_print "COLOR MAP %i\n" color_map_type;
  let image_type = in_char f in
  debug_print "IMAGE TYPE %i\n" image_type;
  let cms = in_cms f in
  let spec = in_spec f in
  let rgb_data = read_rgb_data image_type spec f in
    (if (spec.image_descriptor land 32) != 0 then flip_rows rgb_data);
    flip_rows rgb_data;
    (if (spec.image_descriptor land 16) != 0 then flip_columns rgb_data);
    {tga_id=tga_id;
     color_map_type=color_map_type;
     image_type=image_type;
    cms=cms;spec=spec;rgb_data=rgb_data;};;


let load_tga_file filename =
  let f = open_in_bin(filename) in
  let tga = read_tga_file f in
  let _ = close_in f in
    tga;;

