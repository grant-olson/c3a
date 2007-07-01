(* Copyright 2007, Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

(* Load a Quake 3 .md3 format file into a structure and provide
   render it in openGl *)

open Binfile;;

exception Invalid_md3_format;;



type vector = {x:float;y:float;z:float};;

let print_vector vect =
  Printf.printf " vector = {x = %.2f; y = %.2f; z = %.2f;}" vect.x
    vect.y vect.z;;

(*#install_printer print_vector;;*)

type triangle = {a:int;b:int;c:int};;

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
               shader_index:int;}

type surface = {surface_name:string;
                surface_flags:int32;
                surface_frame_count:int;
                shader_count:int;
                vertex_count:int;
                triangle_count:int;
                triangle_offset:int;
                shader_offset:int;
                st_offset:int;
                vertex_offset:int;
                end_offset:int;
                shaders:shader array;
                triangles:triangle array;
                sts:st array;
                vertexes:vertex array array;
               };;

type md3 = {path:string;
            flags:int32;
            md3_frame_count:int;
            tag_count:int;
            surface_count:int;
            skins:int;
            frame_offset:int;
            tag_offset:int;
            surface_offset:int;
            eof_offset:int;
           frames:frame array;
           tags:tag array array;
           surfaces:surface array;};;
          

let in_packed_float f =
  (* I guess to save space, md3 files pack floats
     as a signed 16 bit int.  You devide by 64.0
     to get the float *)
  let sw1 = float_of_int (in_signed_word f) in
    sw1 /. 64.0;;

let in_vector f =
  let x = in_single f in
  let y = in_single f in
  let z = in_single f in
     {x=x;y=y;z=z};;

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
  let a = float_of_int (in_char f) in
  let b = float_of_int (in_char f) in
  let lat = a /. 255.0 in
  let lng = b /. 255.0 in
  let nx = (cos lat) *. (sin lng) in
  let ny = (sin lat) *. (sin lng) in
  let nz = (cos lng) in    
    {vx=vx;vy=vy;vz=vz;nx=nx;ny=ny;nz=nz};;
 
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
  let matrix = [| [| a1.x;a1.y;a1.z;0.0 |];
                  [| a2.x;a2.y;a2.z;0.0 |];
                  [| a3.x;a3.y;a3.z;0.0 |];
                  [| o.x; o.y ;o.z;1.0;|] |] in
    GlMat.of_array matrix;;




let in_shader f =
  let shader_name = read_path f in
  let shader_index = in_dword f in
    String.set shader_name 0 'm';
    Texture.load_texture_from_file shader_name;
    {shader_name=shader_name;shader_index=shader_index};;

let in_frame_vertexes f surface_offset vertex_offset vertex_count frame_no =
  let begin_frame = surface_offset + vertex_offset + (vertex_count * frame_no *8) in (* 8 is sizeof(vertex) *)
  let _ = seek_in f begin_frame in
    Array.init vertex_count (fun x -> in_vertex f);; 

let in_vertexes f surface_offset vertex_offset vertex_count frame_count =
  Array.init frame_count (fun x -> in_frame_vertexes f surface_offset vertex_offset vertex_count x);;


let in_surface surface_offset f =
  match input_char f, input_char f,
    input_char f, input_char f with
        'I','D','P','3' ->
          let surface_name = in_string f 64 in
          let surface_flags = in_dword_as_int32 f in
          let frame_count = in_dword f in
          let shader_count = in_dword f in
          let vertex_count = in_dword f in
          let triangle_count = in_dword f in
          let triangle_offset = in_dword f in
          let shader_offset = in_dword f in
          let st_offset = in_dword f in
          let vertex_offset = in_dword f in
          let end_offset = in_dword f in
          let _ = seek_in f (surface_offset + shader_offset) in
          let shaders = in_array f shader_count in_shader in
          let _ = seek_in f (surface_offset + triangle_offset) in
          let triangles = in_array f triangle_count in_triangle in
          let _ = seek_in f (surface_offset + st_offset) in
          let sts = in_array f vertex_count in_st in
          let vertexes = in_vertexes f surface_offset vertex_offset
            vertex_count frame_count in
          let _ = seek_in f (surface_offset + end_offset) in
            {surface_name=surface_name;
             surface_flags=surface_flags;
             surface_frame_count=frame_count;
             shader_count=shader_count;
             vertex_count=vertex_count;
             triangle_count=triangle_count;
             triangle_offset=triangle_offset;
             shader_offset=shader_offset;
             st_offset=st_offset;
             vertex_offset=vertex_offset;
             end_offset=end_offset;
             shaders=shaders;
             triangles=triangles;
             sts=sts;
             vertexes=vertexes};
      | _ -> raise Invalid_md3_format;;

let in_surface_array f offset count  =
  seek_in f offset;
  Array.init count (fun x -> in_surface (pos_in f) f);;

let read_version f =
  match in_dword_as_int32 f with
      15l ->
        let path = read_path f in
        let flags = in_dword_as_int32 f in
        let frame_count = in_dword f in
        let tag_count = in_dword f in
        let surface_count = in_dword f in
        let skins = in_dword f in
        let frame_offset = in_dword f in
        let tag_offset = in_dword f in
        let surface_offset = in_dword f in
        let eof_offset = in_dword f in
        let _ = seek_in f frame_offset in
        let frames = in_array f frame_count in_frame in
        let _ = seek_in f tag_offset in
        let tags = in_array_array f frame_count tag_count in_tag in
        let surfaces = in_surface_array f surface_offset surface_count in
          
          {path=path;
           flags=flags;
           md3_frame_count=frame_count;
           tag_count=tag_count;
           surface_count=surface_count;
           skins=skins;
           frame_offset=frame_offset;
           tag_offset=tag_offset;
           surface_offset=surface_offset;
           eof_offset=eof_offset;
           frames=frames;
           tags=tags;
           surfaces=surfaces;}

   | _ -> raise Invalid_md3_format;;

let rec get_tag_two name tags =
  match tags with
      [] -> raise Not_found
    | h::t -> (if h.tag_name = name then h else get_tag_two name t);;

let get_tag name md3 frame_no =
  let tags = Array.get md3.tags frame_no in
  let tag_list = Array.to_list tags in
    get_tag_two name tag_list;;

let readfile f =
    match input_char f, input_char f,
      input_char f, input_char f with
        'I','D','P','3' -> read_version f;
    | _ -> raise Invalid_md3_format;;

let get_point v p =
  Array.get v p;;

let triangle_to_points t v =
 get_point v t.a, get_point v t.b, get_point v t.c;;

let all_triangles_to_points s =
  let t = s.triangles in
  let v = s.vertexes in 
  Array.map (fun x -> triangle_to_points x v) t;;

let map_triangles f s =
  let triangles = all_triangles_to_points s in
    Array.map f triangles;;

let draw_triangle surface frame triangle =
  let current_frame = Array.get surface.vertexes frame in
  let (v1,v2,v3) = triangle_to_points triangle current_frame in
  let st1 = (Array.get surface.sts triangle.a) in
  let st2 = (Array.get surface.sts triangle.b) in
  let st3 = (Array.get surface.sts triangle.c) in

    GlDraw.begins `triangles;

    GlTex.coord2 (st3.s, st3.t);
    GlDraw.normal3 (v3.nx, v3.ny, v3.nz);
    GlDraw.vertex3 (v3.vx, v3.vy, v3.vz);

    GlTex.coord2 (st2.s, st2.t);
    GlDraw.normal3 (v2.nx, v2.ny, v2.nz);
    GlDraw.vertex3 (v2.vx, v2.vy, v2.vz); 

    GlTex.coord2 (st1.s, st1.t);
    GlDraw.normal3 (v1.nx, v1.ny, v1.nz);
    GlDraw.vertex3 (v1.vx, v1.vy, v1.vz); 

    GlDraw.ends ()

let draw_frame_triangles surface frame_no color style =
  let triangles = surface.triangles in
  Array.iter (fun x -> draw_triangle surface frame_no x) triangles

let draw_surface surface frame_no color style =
  let tex = Array.get surface.shaders 0 in
    Texture.set_current_texture tex.shader_name;
    draw_frame_triangles surface frame_no color style

let draw_surfaces md3 frame_no color style =
  Array.iter (fun x -> draw_surface x frame_no color style) md3.surfaces;;


let draw_md3 md3 frame_no =
    GlMat.push();
    draw_surfaces md3 frame_no (0.0,1.0,1.0) `triangles;
    GlMat.pop()

let load_md3_file fname =
  let f = open_in_bin(fname) in
  let md3 = readfile f in
  let _ = close_in f in
    md3


let reskin_md3 assoc_list md3 =
  let new_surface surface =
    let sn = surface.surface_name in
    let new_shaders =
      try
        let shader  = List.assoc sn assoc_list in
              Texture.load_texture_from_file shader;
          [| {shader_name=shader;shader_index=0}|]
      with
          Not_found ->  surface.shaders
    in
      {surface with shaders=new_shaders}
  in
    {md3 with surfaces=(Array.map new_surface md3.surfaces)}
