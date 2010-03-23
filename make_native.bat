del *.cmx*
del player.exe c3a.exe fonts.exe c3a-id-models.exe

if NOT "%VCINSTALLDIR%" == "" GOTO COMPILE

call "C:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"

:: for glut32.lib, where should we really get it?
set LIB=%LIB%;.\c3a-win32
:compile

set DEBUG=-g

:: Quake Version

copy /Y quake3Models.ml c3aModels.ml
copy /Y quake3Strings.ml strings.ml

ocamlopt %DEBUG% -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml strings.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt %DEBUG% -o quaketools.cmxa -a binfile.cmx tga.cmx strings.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx

ocamlopt %DEBUG% -o c3a-id-models.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa  c3aModelsShared.ml c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml c3a.ml


:: openarena version

copy /Y openArenaModels.ml c3aModels.ml
copy /Y OpenArenaStrings.ml strings.ml

ocamlopt %DEBUG% -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa binfile.mli binfile.ml tga.mli tga.ml strings.ml texture.mli texture.ml md3.mli md3.ml player.mli player.ml q3Fonts.mli q3Fonts.ml
ocamlopt %DEBUG% -o oatools.cmxa -a binfile.cmx tga.cmx strings.cmx texture.cmx md3.cmx player.cmx q3Fonts.cmx

ocamlopt %DEBUG% -o c3a.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa oatools.cmxa  c3aModelsShared.ml c3aModels.mli c3aModels.ml compOpponent.mli compOpponent.ml c3a.ml


:: test apps
ocamlopt %DEBUG% -o player.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa player_test.ml
ocamlopt %DEBUG% -o fonts.exe -I +lablGL lablgl.cmxa lablglut.cmxa unix.cmxa quaketools.cmxa font_test.ml

