set DATESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
set SRCRELEASE=c3a-source-%DATESTAMP%.tar
set EXERELEASE=c3a-exe-%DATESTAMP%.zip

mkdir distprep

:: Get the code
svn export svn+ssh://grant@johnwhorfin/var/local/svn/c3a/trunk distprep/c3a

:: Remove Quake 3 models, can't legally redistribute.
rmdir /S /Q distprep\c3a\pak0

:: Make source distribution

cd distprep
tar cvf %SRCRELEASE% c3a
gzip %SRCRELEASE%
set SRCRELEASE=%SRCRELEASE%.gz

:: Make binary distribution
cd c3a
CALL make_native.bat

cd ..
mkdir c3a-win32
copy c3a\c3a.exe c3a-win32
copy c3a\coa.exe c3a-win32
copy c3a\LICENSE c3a-win32
copy c3a\README c3a-win32
copy c3a\RELEASE c3a-win32
copy c3a\TODO c3a-win32
copy c3a\glut32.dll c3a-win
copy c3a\glut-README-win32.txt

mkdir c3a-win32\openarena
xcopy /E c3a\openarena c3a-win32\openarena

zip -r %EXERELEASE% c3a-win32

:: copy built files to release dir and sign

cd ..

mkdir releases

copy distprep\%EXERELEASE% releases
copy distprep\%SRCRELEASE% releases

cd releases
gpg --armor --detach-sign %EXERELEASE%
gpg --armor --detach-sign %SRCRELEASE%

cd ..
rmdir /S /Q distprep
