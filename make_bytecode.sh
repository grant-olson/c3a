rm *.cmi
rm *.cmo
rm qt

ocamlc -o quaketools.cma -a -I +lablGL lablgl.cma lablglut.cma unix.cma binfile.mli binfile.ml tga.mli tga.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlmktop -o qt -I +lablGL lablgl.cma lablglut.cma unix.cma quaketools.cma

ocamlc -o c3a_byte -I +lablGL lablgl.cma lablglut.cma unix.cma quaketools.cma c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml c3a.ml
#ocamlc -o player.cma -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
#ocamlc -o fonts.cma -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml
