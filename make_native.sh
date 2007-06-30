#!/bin/sh

rm *.cmx*
rm player c3a fonts

ocamlopt -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt -o quaketools.cmxa -a binfile.cmx tga.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx

ocamlopt -o c3a -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa c3aModels.ml c3a.ml
ocamlopt -o player -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
ocamlopt -o fonts -I +lablgl lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml
