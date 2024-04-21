IF NOT A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2

f1:: ;hotkey for activate, you can change it
WinGet, id, list, Trove
offsetX := 0
offsetY := 0

while(true)
{
	Loop, %id%
	{
		SendInput, {r}
		Sleep, 1000
		Click %X% + 234, %Y% + 189
		Sleep, 1000
		Click, %X% + 263, %Y% + 189
		Sleep, 1000
		Click, %X% + 206, %Y% + 127
		Sleep, 1000
		Click, %X% + 276, %Y% + 64
		Sleep, 1000
		SendInput, {e}
		Sleep, 1000
		Click, %X% + 258, %Y% + 214
		Sleep, 1000
		Click, %X% + 180, %Y% + 126
		Sleep, 1000
		Click, %X% + 313, %Y% + 56
	}
	Sleep, 1000
}
return

f9:: reload ;hotkey for deactivate, you can change it