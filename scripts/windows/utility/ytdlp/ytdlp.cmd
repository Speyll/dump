@echo off
D:
cd %HOMEPATH%\Downloads
set /P url=media url: 
yt-dlp -f "bestvideo[height<=360]+bestaudio/best[height<=360]" %url%
pause