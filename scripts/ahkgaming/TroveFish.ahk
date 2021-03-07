#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

SetTitleMatchMode, 2


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
	ControlSend, {e}, Trove
	Sleep, 1000
	ControlClick, x283 y185, Trove
	Sleep, 1000
}
Return