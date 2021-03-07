#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F3:: ;Stop
ExitApp
F2:: ; Start
TpX = 283
TpY = 185

CoordMode, Mouse, Client
Send, {o}
Sleep 500
MouseClick, left, 324, 198
Sleep 500
MouseClick, left, 324, 249
Sleep 500
MouseClick, left, 324, 303
Sleep 500
MouseClick, left, 324, 355
Sleep 500
MouseClick, left, 324, 407
Sleep 500
MouseClick, left, 324, 459
Sleep 500
MouseClick, left, 324, 511
Sleep 500


CoordMode, Mouse, Window
WinGet, l, list, ahk_exe Trove.exe

Loop %l%
{
if (a_index > 1)
{
d := l%a_index%
WinGet, o, PID, ahk_id %d%
WinActivate, ahk_pid %o%
MouseClick, left, %TpX%, %TpY%, ,7
Sleep 500
}
}

WinGet, o, PID, ahk_id %l1%
WinActivate, ahk_pid %o%