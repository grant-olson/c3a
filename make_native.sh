#!/bin/sh

rm *.cmx*
rm player c3a fonts

ocamlopt -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.ml tga.ml texture.ml md3.ml player.ml q3Fonts.ml
ocamlopt -o quaketools.cmxa -a binfile.cmx tga.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx

ocamlopt -o c3a -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa c3aModels.ml c3a.ml
ocamlopt -o player -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
ocamlopt -o fonts -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml
