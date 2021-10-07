set FILETOZIP= \databases\
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set timeset=%%a%%b)
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set dateset=%%c-%%a-%%b)

set TEMPDIR=C:\temp_923738
rmdir %TEMPDIR%
mkdir %TEMPDIR%
xcopy /s %FILETOZIP% %TEMPDIR%

echo Set objArgs = WScript.Arguments > _zipIt.vbs
echo InputFolder = objArgs(0) >> _zipIt.vbs
echo ZipFile = objArgs(1) >> _zipIt.vbs
echo CreateObject("Scripting.FileSystemObject").CreateTextFile(ZipFile, True).Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar) >> _zipIt.vbs
echo Set objShell = CreateObject("Shell.Application") >> _zipIt.vbs
echo Set source = objShell.NameSpace(InputFolder).Items >> _zipIt.vbs
echo objShell.NameSpace(ZipFile).CopyHere(source) >> _zipIt.vbs
echo wScript.Sleep 2000 >> _zipIt.vbs

CScript  _zipIt.vbs  %TEMPDIR%  .\%dateset%_%timeset%.zip

pause