(* abstract the opengl modelview matrix behind an intuitive pencil *)

open Foot

let init () =
  GlMat.mode `modelview;
  GlMat.load_identity ()

let draw_square x1 x2 y1 y2 =
  GlDraw.begins `quads;       
  GlDraw.vertex3 (x1, y1, 0.0);
  GlDraw.vertex3 (x1, y2, 0.0);
  GlDraw.vertex3 (x2, y2, 0.0);
  GlDraw.vertex3 (x2, y1, 0.0);
  GlDraw.ends ()

let ink_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r *. 0.5, g *. 0.5, b *. 0.5, a));
  GlLight.material `front (`ambient (r *. 0.5, g *. 0.5, b *. 0.5, a))      

let save_pos () =
  GlMat.push ()

let restore_pos () =
  GlMat.pop ()

let move_right x =
  let x = float_of_foot x in
    GlMat.translate ~x:x ()

let move_left x =
  let x = float_of_foot x in
    GlMat.translate ~x:(-. x) ()

let move_up y =
  let y = float_of_foot (y) in
    GlMat.translate ~y:y ()

let move_down y =
  let y = float_of_foot y in
    GlMat.translate ~y:(-. y) ()

let spin_paper_clockwise angle =
  GlMat.rotate ~angle:angle ~z:1.0 ()
    
let spin_paper_counterclockwise angle = 
  GlMat.rotate ~angle:(-. angle) ~z:1.0 ()
