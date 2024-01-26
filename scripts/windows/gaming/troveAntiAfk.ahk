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
		settitlematchmode,2
		ControlSend,, z, Trove
	}
	Sleep, 50000
}
return

f9:: reload ;hotkey for deactivate, you can change it