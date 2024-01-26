@echo off
set /P url=media url: 
yt-dlp --username "Speyll" --password "" %url%
pause