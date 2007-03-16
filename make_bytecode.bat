del *.cmi
del *.cmo
del qt.exe

ocamlc -o quaketools.cma -a -I +lablgl lablgl.cma lablglut.cma unix.cma binfile.ml tga.ml texture.ml md3.ml player.ml q3Fonts.ml
ocamlmktop -o qt.exe -I +lablgl lablgl.cma lablglut.cma unix.cma quaketools.cma

