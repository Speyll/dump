#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; 2.0 - correction unsync / 2.1 - ajout bouton pause / 2.2 -tests de timings, cancel bouton pause

; ----- Variables -----
VarM:=0
VarP:=0

; ----- EXIT/PAUSE BUTTON -----
+<::ExitApp
;$::Pause

; ----- TGL MOUNT+POT -----
<::
if VarM=0
{
	VarM:=1
	SetTimer, TimeMount, 25250
	Goto, TimeMount
}
if VarM=1
{
	VarM:=0
	SetTimer, TimeMount, Off
	SetTimer, TimePot, Off
	Sleep, 200
}
return

TimeMount:
Send, {é}
Sleep, 200
Send, {a}
SetTimer, TimePot, 7500
return

TimePot:
Send, {a}
VarP:=VarP+1
if VarP=2
{
	VarP:=0
	SetTimer, TimePot, Off
}
return

; ----- JUMP+MAP -----
~XButton1::
while GetKeyState("XButton1")
{
	Send, {Space}
	Sleep, 160
}
return

~MButton::
Sleep, 200
Send, {,}
return