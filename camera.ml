(* Copyright 2007-2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* Abstract GlMat projection matrix behind an intuitive 'camera' *)

open Foot

let move_up feet =
  let z = -. (float_of_foot feet) in
    GlMat.translate ~z:(z) ()

let move_down feet =
  let z = float_of_foot feet in
    GlMat.translate ~z:(z) ()

let move_left feet =
  let x = float_of_foot feet in
    GlMat.translate ~x:(x) ()
  
let move_right feet =
  let x = -. (float_of_foot feet) in
    GlMat.translate ~x:(x) ()

let move_back feet =
  let y = (float_of_foot feet) in
    GlMat.translate ~y:(y) ()

let move_forward feet =
  let y = -. (float_of_foot feet) in
    GlMat.translate ~y:(y) ()

let rotate_left angle =
  GlMat.rotate ~angle:(-. angle) ~z:(1.0) ()

let rotate_right angle =
  GlMat.rotate ~angle:angle ~z:(1.0) ()

let rotate_up angle =
  GlMat.rotate ~angle:angle ~x:(1.0) ()

let rotate_down angle =
  GlMat.rotate ~angle:(-. angle) ~x:(1.0) ()
  
let normal_lens () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(200.0,2000.0)
  
let init () =
  GlMat.mode `projection;
  GlMat.load_identity ()
