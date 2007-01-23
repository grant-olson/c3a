#!/bin/sh

rm *.cmx*


ocamlopt -o c3a -I +lablgl lablgl.cmxa lablglut.cmxa unix.cmxa binfile.ml tga.ml texture.ml md3.ml player.ml chess_test.ml
ocamlopt -o player -I +lablgl lablgl.cmxa lablglut.cmxa unix.cmxa binfile.ml tga.ml texture.ml md3.ml player.ml player_test.ml
