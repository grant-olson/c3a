(*

A matrix type so we can see if we should draw characters or not.

The matrix will use OpenGL style column-major notation.  So the matrix is

      C0    C1   C2   C3
      ---  ---  ---  ---
R0 | [i00, i10, i20, i30] 
R1 | [i01, i11, i21, i31]
R2 | [i02, i12, i22, i32]
R3 | [i03, i13, i23, i33]

And a vector is in a column:

[x]
[y]
[z]
[w]

And then we can do opengl style math, instead of row based math for 
the vectors followed by a transpose op, like some 3d apps...

[i00, i10, i20, i30]   [x]   [i00 * x + i01 * y + i02 * z + i03 * w]
[i01, i11, i21, i31]   [y]   [i10 * x + i11 * y + i12 * z + i13 * w]
[i02, i12, i22, i32] * [z] = [i20 * x + i21 * y + i22 * z + i23 * w] 
[i03, i13, i23, i33]   [w]   [i30 * x + i31 * y + i32 * z + i33 * w]

We won't actually store these as ocaml arrays though.

And, of course, after figuring all this out and getting the math working,
it turns out theres a GLU function that does exactly what I wanted to:

GluMat.project (x,y,z) will return the screen coordinates.

*)

exception MatrixError of string

type matrix = {i00:float;i10:float;i20:float;i30:float;
               i01:float;i11:float;i21:float;i31:float;
               i02:float;i12:float;i22:float;i32:float;
               i03:float;i13:float;i23:float;i33:float;}

type row = R0 | R1 | R2 | R3
type column = C0 | C1 | C2 |C3

type vector = {x:float;y:float;z:float;w:float}

let create_matrix i00 i10 i20 i30
    i01 i11 i21 i31
    i02 i12 i22 i32
    i03 i13 i23 i33 =
  {i00=i00;i01=i01;i02=i02;i03=i03;i10=i10;i11=i11;i12=i12;i13=i13;
   i20=i20;i21=i21;i22=i22;i23=i23;i30=i30;i31=i31;i32=i32;i33=i33;}

let create_vector x y z = {x=x;y=y;z=z;w=1.0}

let print_vector v =
  Printf.printf "x=%f y=%f z=%f a=%f\n" v.x v.y v.z v.w

let identity () = create_matrix 1.0 0.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 0.0 1.0

let print_matrix m =
  Printf.printf "[%f %f %f %f]\n" m.i00 m.i10 m.i20 m.i30;
  Printf.printf "[%f %f %f %f]\n" m.i01 m.i11 m.i21 m.i31;
  Printf.printf "[%f %f %f %f]\n" m.i02 m.i12 m.i22 m.i32;
  Printf.printf "[%f %f %f %f]\n" m.i03 m.i13 m.i23 m.i33

let get_row m row =
  match row with
      R0 -> m.i00, m.i10, m.i20, m.i30
    | R1 -> m.i01, m.i11, m.i21, m.i31
    | R2 -> m.i02, m.i12, m.i22, m.i32
    | R3 -> m.i03, m.i13, m.i23, m.i33

let get_column m column =
  match column with
      C0 -> m.i00, m.i01, m.i02, m.i03
    | C1 -> m.i10, m.i11, m.i12, m.i13
    | C2 -> m.i20, m.i21, m.i22, m.i23
    | C3 -> m.i30, m.i31, m.i32, m.i33

let row_times_column row column =
  let a,b,c,d = row in
  let x,y,z,w = column in
    (a *. x) +. (b *. y) +. (c *. z) +. (d *. w)

let row_times_columns m1 m2 row =
  let row = get_row m1 row in
  let a = row_times_column row (get_column m2 C0) in
  let b = row_times_column row (get_column m2 C1) in
  let c = row_times_column row (get_column m2 C2) in
  let d = row_times_column row (get_column m2 C3) in
    a,b,c,d

let mult_matrix m1 m2 =
  let i00,i10,i20,i30 = row_times_columns m1 m2 R0 in
  let i01,i11,i21,i31 = row_times_columns m1 m2 R1 in
  let i02,i12,i22,i32 = row_times_columns m1 m2 R2 in
  let i03,i13,i23,i33 = row_times_columns m1 m2 R3 in
    create_matrix i00 i10 i20 i30 i01 i11 i21 i32 i02 i12 i22 i32 i03 i13 i23 i33

let translate m x y z =
  let translate_matrix = identity () in
  let translate_matrix = {translate_matrix with i30=x;i31=y;i32=z} in
    mult_matrix m translate_matrix

let rotate m degrees x y z =
  let radians = degrees *. 0.0174532925 in
  let c = cos radians in
  let s = sin radians in
  let one_minus_c = 1.0 -. c in
  let x2 = x *. x in
  let xy = x *. y in
  let xz = x *. z in
  let xs = x *. s in
  let ys = y *. s in
  let zs = z *. s in
  let yx = y *. x in
  let y2 = y *. y in
  let yz = y *. z in
  let z2 = z *. z in
  let i00 = (x2 *. one_minus_c) +. c in
  let i01 = (xy *. one_minus_c) -. zs in
  let i02 = (xz *. one_minus_c) +. ys in
  let i03 = 0.0 in
  let i10 = (yx *. one_minus_c) +. zs in
  let i11 = (y2 *. one_minus_c) +. c in
  let i12 = (yz *. one_minus_c) -. xs in
  let i13 = 0.0 in
  let i20 = (xz *. one_minus_c) -. ys in
  let i21 = (yz *. one_minus_c) +. xs in
  let i22 = (z2 *. one_minus_c) +. c in
  let i23 = 0.0 in
  let i30, i31, i32, i33 = 0.0, 0.0, 0.0, 1.0 in
  let rotate_matrix = create_matrix i00 i01 i02 i03 i10 i11 i12 i13 i20 i21 i22 i23 i30 i31 i32 i33 in
    mult_matrix m rotate_matrix

let vector_times_matrix v m =
  let column = v.x, v.y, v.z, v.w in
  let x = row_times_column (get_row m R0) column in
  let y = row_times_column (get_row m R1) column in
  let z = row_times_column (get_row m R2) column in
  let w = row_times_column (get_row m R3) column in
    {x=x;y=y;z=z;w=w}
    
let i = identity ()

let j = rotate i 90.0 0.0 0.0 1.0

let _ = print_matrix j

let pt = create_vector 1.0 0.0 0.0

let _ = print_vector (vector_times_matrix pt j)

let k = translate i 1.0 1.0 1.0

let _ = print_matrix k

let pt2 = create_vector 1.0 0.0 0.0

let _ = print_vector (vector_times_matrix pt2 k)
