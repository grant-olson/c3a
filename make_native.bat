del *.cmx*

call "C:\Program Files\Microsoft Visual Studio .NET 2003\Vc7\bin\vcvars32.bat"


:: for glut32.lib, where should we really get it?
set LIB=%LIB%;c:\ruby\bin

ocamlopt -I +lablgl lablgl.cmxa lablglut.cmxa unix.cmxa binfile.ml tga.ml texture.ml md3.ml player.ml chess_test.ml
