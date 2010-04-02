(* Copyright 2007-2010 Grant T. Olson.  See LICENSE file for license terms 
   and conditions *)

val load_texture_from_file : string -> unit
val activate_texture : ([< GlTex.format ], [< Gl.kind ]) GlPix.t -> unit
val set_current_texture : string -> unit
