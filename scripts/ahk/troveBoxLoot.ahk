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
		Click %X% + 895, %Y% + 625
		Sleep, 1000
		Click, %X% + 991, %Y% + 627
		Sleep, 1000
		Click, %X% + 803, %Y% + 425
		Sleep, 1000
		Click, %X% + 1035, %Y% + 222
		Sleep, 1000
		SendInput, {e}
		Click, %X% + 975, %Y% + 700
		Sleep, 1000
		Click, %X% + 975, %Y% + 700
		Sleep, 1000
		Click, %X% + 717, %Y% + 423
		Sleep, 1000
		Click, %X% + 1149, %Y% + 195
	}
	Sleep, 1000
}
return

f9:: reload ;hotkey for deactivate, you can change it