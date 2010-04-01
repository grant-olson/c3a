type foot = Foot of float

let foot_scale = 12.5

let float_of_foot feet =
  match feet with
      Foot(x) -> x *. foot_scale

let foot_of_float flt =
  Foot( flt /. foot_scale)

let foot_times_float foot flt =
  match foot with
      Foot(x) -> Foot(x *. flt)

let foot_times_int foot i =
  match foot with
      Foot(x) -> Foot(x *. (float_of_int i))

let foot_minus_foot f1 f2 =
  match f1,f2 with
      Foot(x),Foot(y) -> Foot(x -. y)

let foot_plus_foot f1 f2 =
  match f1,f2 with
      Foot(x),Foot(y) -> Foot(x +. y)
