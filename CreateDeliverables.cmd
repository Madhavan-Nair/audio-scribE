REM Run from dev command line

@ECHO OFF

VERIFY ON

D:
cd \ProjectsPersonal\audio-scribE
rd OnlyR\bin /q /s
rd Installer\Output /q /s

ECHO.
ECHO Publishing audio-scribE
dotnet publish audio-scribE\audio-scribE.csproj -p:PublishProfile=FolderProfile -c:Release
IF %ERRORLEVEL% NEQ 0 goto ERROR

ECHO.
ECHO Removing unwanted x64 DLLs
del audio-scribE\bin\Release\net8.0-windows\publish\win-x86\libmp3lame.64.dll

ECHO.
ECHO Creating installer
"D:\Program Files (x86)\Inno Setup 6\iscc" Installer\onlyrsetup.iss
IF %ERRORLEVEL% NEQ 0 goto ERROR

ECHO.
ECHO Creating portable zip
powershell Compress-Archive -Path audio-scribE\bin\Release\net8.0-windows\publish\win-x86\* -DestinationPath Installer\Output\audio-scribEPortable.zip 
IF %ERRORLEVEL% NEQ 0 goto ERROR

goto SUCCESS

:ERROR
ECHO.
ECHO ******************
ECHO An ERROR occurred!
ECHO ******************

:SUCCESS

PAUSE