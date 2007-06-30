del *.cmi
del *.cmo
del qt.exe

ocamlc -o quaketools.cma -a -I +lablGL lablgl.cma lablglut.cma unix.cma binfile.mli binfile.ml tga.mli tga.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlmktop -o qt.exe -I +lablGL lablgl.cma lablglut.cma unix.cma quaketools.cma

