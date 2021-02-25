#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ON/OFF AUTO MOUNT+POTION
^w::
	SetTimer, POTION, 24500
	Goto, POTION
^x::
	ExitApp

; POTION
POTION:
Loop {
	Sleep, 500
	Send, {e}
	Sleep, 1000
	Send, {2}
	Sleep, 1000
	Loop, 4
	{
	Send, {a}
	Sleep, 1000
	}	
	Send, {2}
	Sleep, 1000
}
Return