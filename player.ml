(*
Player model is build up of 3 md3s.  THis will probably be a class (once I learn how classes work!)
*)

open Md3;;

type player = {lower:md3;upper:md3;head:md3;}


let leg_position = ref 0;;
let draw_player frame_no p =
  let lower_tag_set = Array.get p.lower.tags !leg_position in
  let lower_tag = Array.get lower_tag_set 0 in
  let lower_matrix = tag_to_matrix lower_tag in
  let upper_tag_set = Array.get p.upper.tags !leg_position in
  let upper_head_tag = Array.get upper_tag_set 1 in
  let head_matrix = tag_to_matrix upper_head_tag in
    GlMat.push();
    draw_md3 p.lower !leg_position;
    GlMat.mult lower_matrix;

    draw_md3 p.upper !leg_position;

    GlMat.mult head_matrix;
    draw_md3 p.head 0;
    
    leg_position := !leg_position + 1;
    if !leg_position >= 30 then leg_position := 0;

    (*GlMat.mult pelvis_matrix;*)

    GlMat.pop();;
 

let load_player path = 
  let lower = load_md3_file (path ^ "lower.md3") in
  let upper = load_md3_file (path ^ "upper.md3") in
  let head = load_md3_file (path ^ "head.md3") in
    {lower=lower;upper=upper;head=head;};;

