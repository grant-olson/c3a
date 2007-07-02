rmdir /S /Q c3a
set DATESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

cvs -d:ext:grant@192.168.1.32:/usr/local/cvsroot export -rHEAD -dc3a 3dgame
cd c3a

:: CAN'T REDISTRIBUTE THIS
rmdir /S /Q pak0

:: Source dist
cd ..
tar cvf c3a-%DATESTAMP%.tar c3a
gzip c3a-%DATESTAMP%.tar

:: binary windows dist.
cd c3a
call make_native.bat
del /S *.ml
del /S *.mli
del /S *.cm*
del /S *.obj
del /S *.bat
del /S *.lib
del /S .cvsignore
del /S fonts.exe
del /S player.exe
del /S *.sh
del /S camlprog.exe

:: and zip it.

cd ..
zip c3a-bin-%DATESTAMP%.zip c3a/*

rmdir /S /Q c3a
