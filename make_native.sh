#!/bin/sh

rm -f *.cmx*
rm -f player c3a fonts c3a-id-models

DEBUG=

#QUAKE version

cp quake3Models.ml c3aModels.ml
cp quake3Strings.ml strings.ml

ocamlopt $DEBUG -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml strings.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt $DEBUG -o quaketools.cmxa -a binfile.cmx tga.cmx strings.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx
ocamlopt $DEBUG -o c3a-id-models -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa c3aModelsShared.ml c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml foot.ml camera.ml pencil.ml c3a.ml

#OpenArena Models

cp openArenaModels.ml c3aModels.ml
cp openArenaStrings.ml strings.ml

ocamlopt $DEBUG -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml strings.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt $DEBUG -o oatools.cmxa -a binfile.cmx tga.cmx strings.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx
ocamlopt $DEBUG -o c3a -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa oatools.cmxa c3aModelsShared.ml c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml foot.ml camera.ml pencil.ml c3a.ml

# OTHER STUFF

ocamlopt $DEBUG -o player.opt -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
ocamlopt $DEBUG -o fonts.opt -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml

