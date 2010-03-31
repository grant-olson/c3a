(* Abstract GlMat movement behind an intuitive 'camera' *)

type foot = Foot of float

let foot_scale = 12.5

let float_of_foot feet =
  match feet with
      Foot(x) -> x *. foot_scale

let foot_of_float flt =
  Foot( flt /. foot_scale)

let move_camera_up feet =
  let z = -. (float_of_foot feet) in
    GlMat.translate ~z:(z) ()

let move_camera_down feet =
  let z = float_of_foot feet in
    GlMat.translate ~z:(z) ()

let move_camera_left feet =
  let x = float_of_foot feet in
    GlMat.translate ~x:(x) ()
  
let move_camera_right feet =
  let x = -. (float_of_foot feet) in
    GlMat.translate ~x:(x) ()

let move_camera_back feet =
  let y = (float_of_foot feet) in
    GlMat.translate ~y:(y) ()

let move_camera_forward feet =
  let y = -. (float_of_foot feet) in
    GlMat.translate ~y:(y) ()

let rotate_camera_left angle =
  GlMat.rotate ~angle:(-. angle) ~z:(1.0) ()

let rotate_camera_right angle =
  GlMat.rotate ~angle:angle ~z:(1.0) ()

let rotate_camera_up angle =
  GlMat.rotate ~angle:angle ~x:(1.0) ()

let rotate_camera_down angle =
  GlMat.rotate ~angle:(-. angle) ~x:(1.0) ()
  
let camera_normal_lens () =
  GlMat.frustum ~x:(-30.0,30.0) ~y:(-30.0,30.0) ~z:(200.0,2000.0)
  
