del *.cmi
del *.cmo
del qt.exe

ocamlc -o quaketools.cma -a -I +LablGL lablgl.cma lablglut.cma unix.cma binfile.ml tga.ml texture.ml md3.ml player.ml q3Fonts.ml
ocamlmktop -o qt.exe -I +LablGL lablgl.cma lablglut.cma unix.cma quaketools.cma

