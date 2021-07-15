cd %HOMEPATH%\Downloads
set /P url=Enter media url: 
youtube-dl -f "bestvideo[height<=360]+bestaudio/best[height<=360]" %url%