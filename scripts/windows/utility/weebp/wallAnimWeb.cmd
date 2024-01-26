@echo off
taskkill /F /IM wp.exe
taskkill /F /IM mpv.exe
timeout /t 1 /nobreak

wp run mpv ^
--player-operation-mode=pseudo-gui ^
--force-window=yes ^
--terminal=no ^
--pause=no ^
--osd-playing-msg="" ^
--loop=inf ^
--ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]" ^
--loop-playlist=inf ^
--input-ipc-server=\\.\pipe\mpvsocket ^
https://youtu.be/zWgBvnBv8qY

wp mv --wait --class mpv -x 1920
wp add --wait --fullscreen --class mpv
