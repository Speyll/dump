Pause::
SoundSet, +1, MASTER, mute,8
SoundGet, master_mute, , mute, 8

ToolTip, Mic is muted: %master_mute%
SetTimer, RemoveToolTip, 1000
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return