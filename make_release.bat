set DATESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
set SRCRELEASE=c3a-source-%DATESTAMP%.tar
set EXERELEASE=c3a-exe-%DATESTAMP%.zip
set OASRCRELEASE=openarena-model-blender-source-files-%DATESTAMP%.tar

mkdir distprep
mkdir releases

:: Get the code
svn export svn+ssh://grant@johnwhorfin/var/local/svn/c3a/trunk distprep/c3a

:: Remove Quake 3 models, can't legally redistribute.
rmdir /S /Q distprep\c3a\pak0

:: Source is a seperate distribution

move distprep\c3a\openarena_src distprep\

:: Make source distributions

cd distprep
tar cvf %SRCRELEASE% c3a
gzip %SRCRELEASE%
set SRCRELEASE=%SRCRELEASE%.gz

tar cvf %OASRCRELEASE% openarena_src
gzip %OASRCRELEASE%
set OASRCRELEASE=%OASRCRELEASE%.gz

:: Make binary distribution
cd c3a
CALL make_native.bat

cd ..
mkdir c3a-win32
copy c3a\c3a.exe c3a-win32
copy c3a\c3a-id-models.exe c3a-win32
copy c3a\LICENSE c3a-win32
copy c3a\README c3a-win32
copy c3a\RELEASE c3a-win32
copy c3a\TODO c3a-win32
copy c3a\glut-bins\glut32.dll c3a-win
copy c3a\glut-bins\glut-README-win32.txt c3a-win

mkdir c3a-win32\openarena
xcopy /E c3a\openarena c3a-win32\openarena

zip -r %EXERELEASE% c3a-win32

:: copy built files to release dir and sign

cd ..

mkdir releases

copy distprep\%EXERELEASE% releases
copy distprep\%SRCRELEASE% releases
copy distprep\%OASRCRELEASE% releases

cd releases
gpg --armor --detach-sign %EXERELEASE%
gpg --armor --detach-sign %SRCRELEASE%
gpg --armor --detach-sign %OASRCRELEASE%

cd ..
rmdir /S /Q distprep
