(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

open Tga

let basepath = "./openarena/"

let image_height = 64
and image_width = 64

let make_generic_image () =
  let image =
    GlPix.create `ubyte ~format:`rgba ~width:image_width ~height:image_height in
  for i = 0 to image_width - 1 do
    for j = 0 to image_height - 1 do
      Raw.sets (GlPix.to_raw image) ~pos:(4*(i*image_height+j))
	(if (i land 2 ) lxor (j land 2) = 0
	 then [|255;255;255;255|]
	 else [|0;0;0;255|])
    done
  done;
  image

let make_image_from_tga tga =
  let width = tga.spec.width in
  let height = tga.spec.height in
  let image =
  GlPix.create `ubyte ~format:`rgba ~width:width ~height:height in
  for i = 0 to width - 1 do
    for j = 0 to height - 1 do
      let row = Array.get tga.rgb_data j in
      let rgb_val = Array.get row i in
      let row_start = j * width in
      let col = row_start + i in
        Raw.sets (GlPix.to_raw image) ~pos:(4*col)
          [| rgb_val.r;rgb_val.g;rgb_val.b;rgb_val.a |]
    done
  done;
  image

let make_image_from_tga_file filename =
  let filename = basepath ^ filename in
  let strlen = String.length filename in
  let ext = String.sub filename (strlen - 4) 4 in
  let has_tga_ext = String.compare ext ".tga" in
  let filename = (if has_tga_ext == 0 then filename else filename ^ ".tga") in
  (*Printf.printf "Loading %s with ext %s\n" filename ext;
  flush stdout;*)
  let tga = Tga.load_tga_file filename in
    make_image_from_tga tga;;

let textures : (string,([`rgba],[`ubyte])GlPix.t) Hashtbl.t = Hashtbl.create 100;;

Hashtbl.add textures "unknown" (make_generic_image ());;

let load_texture_from_file filename =
  let is_loaded = Hashtbl.mem textures filename in
    if is_loaded = false then
      try
        let tga_file = make_image_from_tga_file (filename) in
          Hashtbl.add textures filename tga_file
      with
          Sys_error a -> () ;; (* TODO: Better handling *)

      

let activate_texture tex = 
  GlPix.store (`unpack_alignment 1);
  GlTex.image2d tex;
  List.iter (GlTex.parameter ~target:`texture_2d)
      [ `wrap_s `clamp;
        `wrap_t `clamp;
        `mag_filter `linear;
        `min_filter `linear ];
  GlTex.env (`mode `modulate);;

let set_current_texture texname =
  if
    Hashtbl.mem textures texname
  then
    activate_texture (Hashtbl.find textures texname)
  else
    activate_texture (Hashtbl.find textures "unknown");;



