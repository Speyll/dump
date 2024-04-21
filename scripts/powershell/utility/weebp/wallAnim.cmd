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
--no-audio ^
--loop=inf ^
--loop-playlist=inf ^
--input-ipc-server=\\.\pipe\mpvsocket ^
%USERPROFILE%\Videos\Wallpapers

wp mv --wait --class mpv -x 1920
wp add --wait --fullscreen --class mpv
