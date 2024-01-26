@echo off
D:
cd %HOMEPATH%\Downloads
set /p link="link to dl: "
aria2c --optimize-concurrent-downloads %link%
pause