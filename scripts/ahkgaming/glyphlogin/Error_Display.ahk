#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 2
DetectHiddenWindows, On

Gui, Margin, 0, 0
Gui, Color, Black
Gui, Font, cWhite s12 bold, Arial
Gui, Add, Text,x1 y1 w58 h23, Error:

Gui, Add, Text,x1 y24 vplaceholder, %1%
Gui, Add, Button, gexit, Kill all related instances
Gui, Show, AutoSize
return

exit:
    MsgBox, 4, , If not a file-error, this error might be able to be resolved.`nClose all related AHKs?
    IfMsgBox Yes
    {
        Send, {F4} ;Every script's kill switch
        ExitApp ;In case F4 doesn't close this GUI
    }

F4::
    ExitApp
