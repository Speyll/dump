#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^o::
Toggle := !Toggle
While Toggle {
	WinSet, AlwaysOnTop, Toggle, Current Window_Dx_Window_Class
	Click
	Sleep, 34
}
Return
^x::ExitApp