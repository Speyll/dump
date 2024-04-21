f1:: ;hotkey for activate, you can change it
WinGet, id, list, Trove
offsetX := 0
offsetY := 0
Loop, %id%
{
	this_id := id%A_Index%
	WinMove, ahk_id %this_id%, , offsetX, offsetY, 300, 200
	offsetX := offsetX + 302
	if(offsetX > 1200)
	{
		offsetY := offsetY + 235
		offsetX := 0
	}
}
while(true)
{
	Loop, %id%
	{
		this_id := id%A_Index%
		WinActivate, ahk_id %this_id%
		Loop, 2
		{
			SendInput, {LCtrl Down}
			Sleep, 100
			SendInput, {b down}
			Sleep, 100
			SendInput, {b up}
			Sleep, 100
			SendInput, {LCtrl up}
			Sleep, 200
		}
		WinGetPos, X, Y
		Click %X% + 133, %Y% + 117
		Sleep, 100
		Click %X% + 188, %Y% + 202
		Sleep, 100
		Click %X% + 270, %Y% + 202
		Sleep, 100
	}
	Sleep, 20000
}
return

f10:: reload ;hotkey for deactivate, you can change it