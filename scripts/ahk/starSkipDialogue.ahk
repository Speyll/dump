IF NOT A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DetectHiddenWindows, on
Settitlematchmode 2
target=Star Rail ahk_exe StarRail.exe

PgUp::
flag = 1
	loop {
		CoordMode, Mouse, Client
		ControlClick, x1265 y670, %target%,,,, NA
		Sleep, 50
	if flag = 0
		break
	}

PgDn:: flag = 0