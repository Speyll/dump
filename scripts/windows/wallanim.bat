:ecran1
taskkill /IM "mpv.exe" /F
wp killall
goto :ecran2
wp run mpv ^
--player-operation-mode=pseudo-gui ^
--force-window=yes ^
--terminal=no ^
--no-audio ^
--loop=inf ^
--loop-playlist=inf ^
--pause=no ^
--input-ipc-server=\\.\pipe\mpvsocket ^
4.gif

wp mv --wait --class mpv -x 1920
wp add --wait --fullscreen --class mpv

:ecran2
wp run mpv ^
--player-operation-mode=pseudo-gui ^
--force-window=yes ^
--terminal=no ^
--no-audio ^
--loop=inf ^
--loop-playlist=inf ^
--pause=no ^
--input-ipc-server=\\.\pipe\mpvsocket ^
1.gif

wp mv --wait --class mpv -y -1080
wp add --wait --fullscreen --class mpv