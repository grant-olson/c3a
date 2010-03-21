(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

let prop_map_b  = [|(11, 12, 33);
                  (49, 12, 31);
                  (85, 12, 31);
                  (120, 12, 30);
                  (156, 12, 21);
                  (183, 12, 21);
                  (207, 12, 32);

                  (13, 55, 30);
                  (49, 55, 13);
                  (66, 55, 29);
                  (101, 55, 31);
                  (135, 55, 21);
                  (158, 55, 40);
                  (204, 55, 32);

                  (12, 97, 31);
                  (48, 97, 31);
                  (82, 97, 30);
                  (118, 97, 30);
                  (153, 97, 30);
                  (185, 97, 25);
                  (213, 97, 30);

                  (11, 139, 32);
                  (42, 139, 51);
                  (93, 139, 32);
                  (126, 139, 31);
                  (158, 139, 25) |]

let propb_gap_width = 4.0
let propb_space_width = 12.0
let propb_height = 36.0

type tex_point = {x:float;y:float}
type tex_box = {top_left:tex_point;bottom_right:tex_point;width:float}

let ascii x = int_of_char x

let char_index char =
  match char with
      'a' .. 'z' -> (ascii char) - 97
    | 'A' .. 'Z' -> (ascii char) - 65
    | _ -> raise Not_found

let char_coords char =
  let idx = char_index char in
  let (col,row,width) = prop_map_b.(idx) in
  let col = (float_of_int col) in
  let row = 256.0 -. (float_of_int row) in
  let width = float_of_int width in
  let topleft = {x=(col /. 256.0);y=(row /. 256.0)} in
  let right =(col +. width) /. 256.0 in
  let bottom = (row -. propb_height) /. 256.0 in
  let bottomright = {x=right;y=bottom} in
    {top_left=topleft;bottom_right=bottomright;width=width}
    
                      
let tex = Texture.load_texture_from_file "menu/art/font2_prop.tga" 

let draw_char startx starty screen_height char =
  let tex_coords = char_coords char in
  let top_left = tex_coords.top_left in
  let bottom_right = tex_coords.bottom_right in
  let starts = top_left.x in
  let startt = top_left.y in
  let ends =  bottom_right.x in
  let endt = bottom_right.y in
  let conversion_factor = screen_height /. propb_height in
  let endy = starty -. screen_height in
  let endx = startx +. (conversion_factor *. tex_coords.width) in
    Texture.set_current_texture "menu/art/font2_prop.tga";


    GlDraw.begins `quads;
    
    GlTex.coord2 (starts,startt);
    GlDraw.vertex2 ( startx,starty);
    

    GlTex.coord2 (ends,startt);
    GlDraw.vertex2 (endx,starty);


    GlTex.coord2 (ends,endt);
    GlDraw.vertex2 (endx,endy);
    

    GlTex.coord2(starts,endt);
    GlDraw.vertex2 (startx,endy);

    GlDraw.ends ();
    endx +. (propb_gap_width *. conversion_factor)

let rec draw_string startx starty height str =
  let strlen = String.length str in
    if strlen == 0
    then
      ()
    else
      begin
        let first = str.[0] in
        let rest = String.sub str 1 (strlen - 1) in
        if first == ' '
        then
          let conversion_factor = height /. propb_height in
          let newx = startx +. (propb_space_width *. conversion_factor) in
            draw_string newx starty height rest
        else
          let newx = draw_char startx starty height first in
            draw_string newx starty height rest
      end
      
