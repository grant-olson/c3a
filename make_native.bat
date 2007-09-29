del *.cmx*
del player.exe c3a.exe fonts.exe

if NOT "%VCINSTALLDIR%" == "" GOTO COMPILE

call "C:\Program Files\Microsoft Visual Studio 8\VC\bin\vcvars32.bat"


:: for glut32.lib, where should we really get it?
set LIB=%LIB%;c:\ruby\bin
set DEBUG=-g
:compile

ocamlopt %DEBUG% -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt %DEBUG% -o quaketools.cmxa -a binfile.cmx tga.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx

ocamlopt %DEBUG% -o c3a.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml c3a.ml
ocamlopt %DEBUG% -o player.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
ocamlopt %DEBUG% -o fonts.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml
