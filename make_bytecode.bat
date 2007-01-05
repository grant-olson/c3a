del *.cmi
del *.cmo

ocamlc -I +lablgl lablgl.cma lablglut.cma unix.cma binfile.ml tga.ml texture.ml md3.ml player.ml
