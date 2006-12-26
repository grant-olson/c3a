(* Load a Quake 3 .md3 format file into a structure and provide
   render it in openGl *)

exception Invalid_md3_format;;

type vector = {x:float;y:float;z:float};;

let print_vector vect =
  Printf.printf " vector = {x = %.2f; y = %.2f; z = %.2f;}" vect.x vect.y vect.z;;

(*#install_printer print_vector;;*)

type triangle = {a:int32;b:int32;c:int32};;

type st = {s:float;t:float};;

type frame = {min_bounds:vector;
              max_bounds:vector;
              frame_origin:vector;
              radius:float;
              frame_name:string};;


type tag = {tag_name:string;
            tag_origin:vector;
            axis1:vector;
            axis2:vector;
            axis3:vector;};;

type vertex = {vx:float;vy:float;vz:float;nx:float;ny:float;nz:float};;

type shader = {shader_name:string;
               shader_index:int32;}

type surface = {surface_name:string;
                surface_flags:int32;
                surface_frame_count:int32;
                shader_count:int32;
                vertex_count:int32;
                triangle_count:int32;
                triangle_offset:int32;
                shader_offset:int32;
                st_offset:int32;
                vertex_offset:int32;
                end_offset:int32;
                shaders:shader array;
                triangles:triangle array;
                sts:st array;
                vertexes:vertex array array;
               };;

type md3 = {path:string;
            flags:int32;
            md3_frame_count:int32;
            tag_count:int32;
            surface_count:int32;
            skins:int32;
            frame_offset:int32;
            tag_offset:int32;
            surface_offset:int32;
            eof_offset:int32;
           frames:frame array;
           tags:tag array;
           surfaces:surface array;
};;
          


let int32_of_int =
  Int32.of_int;;

let in_char f =
  Int32.of_int (input_byte f);;

let in_word f =
  let c1 = in_char f in
  let c2 = in_char f in
    Int32.add c1 (Int32.mul 256l c2);;
  
let in_signed_word f =
  let w1 = Int32.to_int (in_word f) in
    if
      w1 > 32767
    then
      w1 - 65545
    else
      w1;;

let in_packed_float f =
  (* I guess to save space, md3 files pack floats
     as a signed 16 bit int.  You devide by 64.0
     to get the float *)
  let sw1 = float_of_int (in_signed_word f) in
    sw1 /. 64.0;;

let in_dword f =
  let w1 = in_word f in
  let c1 = in_char f in
  let c2 = in_char f in
    Int32.add w1 (Int32.add (Int32.mul c1 65536l) (Int32.mul c2 16777216l));;

let in_single f =
  let dw = in_dword f in
    Int32.float_of_bits dw;;


let in_vector f =
  let x = in_single f in
  let y = in_single f in
  let z = in_single f in
    {x=x;y=y;z=y};;

let in_triangle f =
  let a = in_dword f in
  let b = in_dword f in
  let c = in_dword f in
    {a=a;b=b;c=c};;

let in_st f =
  let s = in_single f in
  let t = in_single f in
    {s=s;t=t};;

let in_vertex f =
  let vx = in_packed_float f in
  let vy = in_packed_float f in
  let vz = in_packed_float f in
  let a = float_of_int (Int32.to_int (in_char f)) in
  let b = float_of_int (Int32.to_int (in_char f)) in
  let lat = a /. 255.0 in
  let lng = b /. 255.0 in
  let nx = (cos lat) *. (sin lng) in
  let ny = (sin lat) *. (sin lng) in
  let nz = (cos lng) in    
    {vx=vx;vy=vy;vz=vz;nx=nx;ny=ny;nz=nz};;

let in_string f len = 
  let buf = String.create len in
  let i = input f buf 0 len in
      buf;;
 
let read_path f =
  let buf = in_string f 64 in
      buf;;

let in_frame f =
  let min_bounds = in_vector f in
  let max_bounds = in_vector f in
  let local_origin = in_vector f in
  let radius = in_single f in
  let name = in_string f 16 in
    {min_bounds=min_bounds;max_bounds=max_bounds;frame_origin=local_origin;
    radius=radius;frame_name=name};;


let in_tag f =
  let name = read_path f in
  let origin = in_vector f in
  let axis1 = in_vector f in
  let axis2 = in_vector f in
  let axis3 = in_vector f in
    {tag_name=name;tag_origin=origin;axis1=axis1;axis2=axis2;axis3=axis3};;



let tag_to_matrix t =
  let o = t.tag_origin in
  let a1 = t.axis1 in
  let a2 = t.axis2 in
  let a3 = t.axis3 in
  let matrix = [| [| a1.x;a1.y;a1.z;o.x |];
                  [| a2.x;a2.y;a2.z;o.y |] ;
                  [| a3.x;a3.y;a3.z;o.z |];
                  [| 0.0; 0.0;0.0;1.0;|] |] in
    GlMat.of_array matrix;;

let tag_to_matrix t =
  let o = t.tag_origin in
  let a1 = t.axis1 in
  let a2 = t.axis2 in
  let a3 = t.axis3 in
  let matrix = [| [| a1.x;a2.x;a3.x;o.x |];
                  [| a1.y;a2.y;a3.y;o.y |];
                  [| a1.z;a2.z;a3.z;o.z |];
                  [| 0.0;0.0;0.0;1.0 |] |] in
    GlMat.of_array matrix;;

let tag_to_matrix t =
  let o = t.tag_origin in
  let a1 = t.axis1 in
  let a2 = t.axis2 in
  let a3 = t.axis3 in
  let matrix = [| [| a1.x;a2.x;a3.x;0.0 |];
                  [| a1.y;a2.y;a3.y;0.0 |];
                  [| a1.z;a2.z;a3.z;0.0 |];
                  [| o.z;o.y;o.z;1.0;|] |] in
    GlMat.of_array matrix;;

let in_shader f =
  let shader_name = read_path f in
  let shader_index = in_dword f in
    {shader_name=shader_name;shader_index=shader_index};;

let in_array f offset count constructor =
  seek_in f (Int32.to_int offset);
  Array.init (Int32.to_int count) (fun x -> constructor f);;

let in_frame_vertexes f surface_offset vertex_offset vertex_count frame_no =
  let begin_frame = (Int32.add surface_offset (Int32.add vertex_offset (Int32.mul (Int32.mul vertex_count frame_no) (Int32.of_int 8)))) in (* 8 is sizeof(vertex) *)
  let _ = seek_in f (Int32.to_int begin_frame) in
    Array.init (Int32.to_int vertex_count) (fun x -> in_vertex f);; 

let in_vertexes f surface_offset vertex_offset vertex_count frame_count =
  Array.init (Int32.to_int frame_count) (fun x -> in_frame_vertexes f surface_offset vertex_offset vertex_count (Int32.of_int x));;


let in_surface surface_offset f =
  match input_char f, input_char f,
    input_char f, input_char f with
        'I','D','P','3' ->
          let surface_name = in_string f 64 in
          let surface_flags = in_dword f in
          let frame_count = in_dword f in
          let shader_count = in_dword f in
          let vertex_count = in_dword f in
          let triangle_count = in_dword f in
          let triangle_offset = in_dword f in
          let shader_offset = in_dword f in
          let st_offset = in_dword f in
          let vertex_offset = in_dword f in
          let end_offset = in_dword f in
          let shaders = in_array f (Int32.add surface_offset shader_offset) shader_count in_shader in
          let triangles = in_array f (Int32.add surface_offset triangle_offset) triangle_count in_triangle in
          let sts = in_array f (Int32.add surface_offset st_offset) triangle_count in_st in
          let vertexes = in_vertexes f surface_offset vertex_offset vertex_count frame_count in
          let _ = seek_in f (Int32.to_int (Int32.add surface_offset end_offset)) in
            {surface_name=surface_name;surface_flags=surface_flags;surface_frame_count=frame_count;
             shader_count=shader_count;vertex_count=vertex_count;triangle_count=triangle_count;
             triangle_offset=triangle_offset;shader_offset=shader_offset;
             st_offset=st_offset;vertex_offset=vertex_offset;end_offset=end_offset;shaders=shaders;triangles=triangles;
            sts=sts;vertexes=vertexes};
      | _ -> raise Invalid_md3_format;;

let in_surface_array f offset count  =
  seek_in f (Int32.to_int offset);
  Array.init (Int32.to_int count) (fun x -> in_surface (Int32.of_int (pos_in f)) f);;

let read_version f =
  match in_dword f with
      15l ->
        let path = read_path f in
        let flags = in_dword f in
        let frame_count = in_dword f in
        let tag_count = in_dword f in
        let surface_count = in_dword f in
        let skins = in_dword f in
        let frame_offset = in_dword f in
        let tag_offset = in_dword f in
        let surface_offset = in_dword f in
        let eof_offset = in_dword f in
        let frames = in_array f frame_offset frame_count in_frame in
        let tags = in_array f tag_offset tag_count in_tag in
        let surfaces = in_surface_array f surface_offset surface_count in
          
          {path=path;flags=flags;md3_frame_count=frame_count;tag_count=tag_count;
           surface_count=surface_count;
           skins=skins;frame_offset=frame_offset;tag_offset=tag_offset;
           surface_offset=surface_offset;eof_offset=eof_offset;
           frames=frames;tags=tags;surfaces=surfaces;}
   | _ -> raise Invalid_md3_format;;

let readfile f =
    match input_char f, input_char f,
      input_char f, input_char f with
        'I','D','P','3' -> read_version f;
    | _ -> raise Invalid_md3_format;;

let get_point v p =
  Array.get v (Int32.to_int p);;

let triangle_to_points t v =
 get_point v t.a, get_point v t.b, get_point v t.c;;

let all_triangles_to_points s =
  let t = s.triangles in
  let v = s.vertexes in 
  Array.map (fun x -> triangle_to_points x v) t;;

let map_triangles f s =
  let triangles = all_triangles_to_points s in
    Array.map f triangles;;

let draw_triangle t color style =
  let (v1,v2,v3) = t in
    GlDraw.color color;
    GlDraw.begins `triangles;

    GlDraw.normal3 (v3.nx, v3.ny, v3.nz);
    GlDraw.vertex3 (v3.vx, v3.vy, v3.vz);

    GlDraw.normal3 (v2.nx, v2.ny, v2.nz);
    GlDraw.vertex3 (v2.vx, v2.vy, v2.vz); 


    GlDraw.normal3 (v1.nx, v1.ny, v1.nz);
    GlDraw.vertex3 (v1.vx, v1.vy, v1.vz); 

    GlDraw.ends ();;

let draw_frame_triangles surface frame_no color style =
  let triangles = surface.triangles in
  let frame = Array.get surface.vertexes frame_no in
  Array.iter (fun x -> draw_triangle (triangle_to_points x frame) color style) triangles;;

let draw_surface surface frame_no color style =
  draw_frame_triangles surface frame_no color style;;

let draw_surfaces md3 frame_no color style =
  Array.iter (fun x -> draw_surface x frame_no color style) md3.surfaces;;

let set_material_color r g b a =
  GlLight.material `front (`specular (r, g, b, a));
  GlLight.material `front (`diffuse (r, g, b, a));
  GlLight.material `front (`ambient (r, g, b, a));;


let draw_axes () =
  (*Material to do color? *)
  (* Z - RED *)
  
  GlDraw.begins `lines;
  set_material_color 1.0 0.0 0.0 1.0;
  GlDraw.vertex3 (0.0,0.0,-250.0);
  GlDraw.vertex3 (0.0,0.0,250.0);
  
  (* X GREEN *)

  set_material_color 0.0 1.0 0.0 1.0;
  GlDraw.vertex3 (-250.0,0.0,0.0);
  GlDraw.vertex3 (250.0, 0.0, 0.0);
  
  (* Y BLUE *)
  set_material_color 0.0 0.0 1.0 1.0;
  GlDraw.vertex3 (0.0,-250.0,0.0);
  GlDraw.vertex3 (0.0,250.0,0.0);
 
  GlDraw.ends ();;


let leg_position = ref 151;;

let draw_player frame_no lower upper head =
  let lt = Array.get lower.tags 0 in
  let lm = tag_to_matrix lt in
  let lf = Array.get lower.frames !leg_position in
  let ut = Array.get upper.tags 0 in
  let um = tag_to_matrix ut in
  let uf = Array.get upper.frames frame_no in
  let ht = Array.get head.tags 0 in
  let hm = tag_to_matrix ht in
  let hf = Array.get head.frames 0 in
  let foff = !leg_position - 191 in
  let angle = (float_of_int foff) /. 17.0 *. 360.0 in
    GlMat.push();

    (*GlMat.rotate ~angle:angle ~y:(1.0) ();*)
    set_material_color 1.0 1.0 1.0 1.0;
    draw_surfaces lower !leg_position (0.0,1.0,1.0) `triangles;
    leg_position := !leg_position + 1;
    if !leg_position > 151 then leg_position := 151;

    GlMat.translate ~z:10.0 ();
    GlMat.translate ~x:(-10.0) ();
    draw_surfaces upper frame_no (0.75,0.75,0.75) `triangles;

    GlMat.translate ~x:(22.0) ~y:0.0 ~z:(3.0) ();
    draw_surfaces head 0 (0.5,0.5,0.5) `triangles;

    GlMat.pop();;

let load_file fname =
  let f = open_in_bin(fname) in
  let md3 = readfile f in
  let _ = close_in f in
    md3;;

(* test harness.  We should probably move at least some of this
  stuff to a 'player' module *)
let lower = load_file "./pak0/models/players/sarge/lower.md3" ;;

let upper = load_file "./pak0/models/players/sarge/upper.md3" ;;

let head = load_file "./pak0/models/players/sarge/head.md3" ;;

let lighting_init () =
  let light_ambient = 0.1, 0.1, 0.1, 1.0
  and light_diffuse = 0.2, 0.2, 0.2, 1.0
  and light_specular = 0.25, 0.25, 0.25, 1.0
  (*  light_position is NOT default value	*)
  and light_position = -50.0, 50.0, 25.0, 0.0
  in
  GlDraw.shade_model `smooth;

  GlLight.light ~num:0 (`ambient light_ambient);
  GlLight.light ~num:0 (`diffuse light_diffuse);
  GlLight.light ~num:0 (`specular light_specular);
  GlLight.light ~num:0 (`position light_position);
  
  List.iter Gl.enable [`lighting; `light0; `depth_test];;

let angle = ref 0.0;;


let display () =
  Gl.enable `cull_face;
  GlDraw.cull_face `back;
  GlClear.color (0.0, 0.0, 0.0);
  GlClear.clear [`color];
  GlClear.clear [`depth];
  GlDraw.color (1.0, 1.0, 1.0);

  GlMat.mode `projection;
  GlMat.load_identity ();
  
  GlMat.mode `modelview;

  GlMat.load_identity ();
  GlMat.ortho ~x:(-50.0,50.0) ~y:(-50.0,50.0) ~z:(-50.0,50.0);

  GlMat.rotate ~angle:270.0 ~x:(1.0) ();
  GlMat.rotate ~angle:90.0 ~z:1.0 ();
      
  GlMat.rotate ~angle:!angle ~z:1.0 ();     
  angle := !angle +. 1.0;
  if !angle > 359.0 then angle := 0.0;

  GlMat.translate ~x:(0.0) ~y:(0.0) ~z:(0.0) ();

  draw_axes ();

  lighting_init(); 

  draw_player 136 lower upper head;

  Gl.flush ();
  Glut.postRedisplay () ;;

let main () =
  ignore(Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~depth:true () ;
  Glut.initWindowSize ~w:500 ~h:500 ;
  ignore(Glut.createWindow ~title:"lablglut & LablGL");
  Glut.displayFunc ~cb:display;

  Glut.mainLoop();
  ;;

let _ = main ()




