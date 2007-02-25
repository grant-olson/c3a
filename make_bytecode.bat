del *.cmi
del *.cmo

ocamlc -I +lablgl lablgl.cma lablglut.cma unix.cma binfile.ml tga.ml texture.ml md3.ml player.ml q3Fonts.ml
ocamlc -g -I +lablgl lablgl.cma lablglut.cma unix.cma binfile.ml tga.ml texture.ml md3.ml player.ml q3Fonts.ml chess_test.ml
