(* tga parsing *)

exception Unknown_tga_format;;

open Binfile;;


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
  let color_map_length = in_word f in
  let color_map_entry_size = in_char f in
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

let read_tga_file f =
  let tga_id = in_char f in
  let color_map_type = in_char f in
  let image_type = in_char f in
  let cms = in_cms f in
  let spec = in_spec f in
  let rgb_data = in_array_array f spec.height spec.width (fun x -> in_color_data x spec) in
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

