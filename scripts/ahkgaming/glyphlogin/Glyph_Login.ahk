#NoEnv
#SingleInstance, Force
#Persistent
OnExit("CloseFunction")
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; #Warn  ; Enable warnings to assist with detecting common errors.



/*
- Made by BLURREDDOGE / JELLYMAN123
Copyright 2018, Luke Roper, All rights reserved.
- https://www.gov.uk/copyright 
- You are free to edit this but under no circumstances, without my written permission, are you allowed to redistribute this code yourself.
*/

global normal_sleep                                    := 200
global wait_for_trove_to_open                          := 5
global delay_time_in_ms                                := 20
global how_long_until_restart                          := 3600000
global troveopenerrorcheck                             := 600
global wait_for_glyph_to_login                         := 1800
OnExit(ObjBindMethod(GlyphLoginExit, "DoBeforeExit"))

	if FileExist("database.txt")
	{
		Array := []
		breakline = `n
		Loop, Read, database.txt
		{
			Array.Push(A_LoopReadLine)
		}
		for index, element in Array
		{
			oof := Mod(index, 2)
			if oof = 0
			{
				Passwords := element . breakline
				if index = 2
				{
					Global Password_One := element
				}
				if index = 4
				{
					Global Password_Two := element
				}
				if index = 6
				{
					Global Password_Three := element
				}
				if index = 8
				{
					Global Password_Four := element
				}	
				if index = 10
				{
					Global Password_Five := element
				}
				if index = 12
				{
					Global Password_Six := element
				}
				if index = 14
				{
					Global Password_Seven := element
				}
				if index = 16
				{
					Global Password_Eight := element
				}
				if index = 18
				{
					Global Password_Nine := element
				}
				if index = 20
				{
					Global Password_Ten := element
				}
				if index = 22
				{
					Global Password_Eleven := element
				}
				if index = 24
				{
					Global Password_Twelve := element
				}
				if index = 26
				{
					Global Password_Thirteen := element
				}
				if index = 28
				{
					Global Password_Fourteen := element
				}
				if index = 30
				{
					Global Password_Fifthteen := element
				}
				if index = 32
				{
					Global Password_Sixteen := element
				}
				if index = 34
				{
					Global Password_Seventeen := element
				}
				if index = 36
				{
					Global Password_Eighteen := element
				}
				if index = 38
				{
					Global Password_Nineteen := element
				}
				if index = 40
				{
					Global Password_Twenty := element
				}
				if index = 42
				{
					Global Password_TwentyOne := element
				}
				if index = 44
				{
					Global Password_TwentyTwo := element
				}
				if index = 46
				{
					Global Password_TwentyThree := element
				}
				if index = 48
				{
					Global Password_TwentyFour := element
				}
				if index = 50
				{
					Global Password_TwentyFive := element
				}
				if index = 52
				{
					Global Password_TwentySix := element
				}
				if index = 54
				{
					Global Password_TwentySeven := element
				}
				if index = 56
				{
					Global Password_TwentyEight := element
				}
				if index = 58
				{
					Global Password_TwentyNine := element
				}
				if index = 60
				{
					Global Password_Thirty := element
				}
			}
			else
			{
				Emails := element . breakline
				if index = 1
				{
					Global Email_One := element
				}
				if index = 3
				{
					Global Email_Two := element
				}
				 if index = 5
				{
					Global Email_Three := element
				}	
				 if index = 7
				{
					Global Email_Four := element
				}
				if index = 9
				{
					Global Email_Five := element
				}
				if index = 11
				{
					Global Email_Six := element
				}
				if index = 13
				{
					Global Email_Seven := element
				}
				if index = 15
				{
					Global Email_Eight := element
				}
				if index = 17
				{
					Global Email_Nine := element
				}
				if index = 19
				{
					Global Email_Ten := element
				}
				if index = 21
				{
					Global Email_Eleven := element
				}
				if index = 23
				{
					Global Email_Twelve := element
				}
				if index = 25
				{
					Global Email_Thirteen := element
				}
				if index = 27
				{
					Global Email_Fourteen := element
				}
				if index = 29
				{
					Global Email_Fifthteen := element
				}
				if index = 31
				{
					Global Email_Sixteen := element
				}
				if index = 33
				{
					Global Email_Seventeen := element
				}
				if index = 35
				{
					Global Email_Eighteen := element
				}
				if index = 37
				{
					Global Email_Nineteen := element
				}
				if index = 39
				{
					Global Email_Twenty := element
				}
				if index = 41
				{
					Global Email_TwentyOne := element
				}
				if index = 43
				{
					Global Email_TwentyTwo := element
				}
				if index = 45
				{
					Global Email_TwentyThree := element
				}
				if index = 47
				{
					Global Email_TwentyFour := element
				}
				if index = 49
				{
					Global Email_TwentyFive := element
				}
				if index = 51
				{
					Global Email_TwentySix := element
				}
				if index = 53
				{
					Global Email_TwentySeven := element
				}
				if index = 55
				{
					Global Email_TwentyEight := element
				}
				if index = 57
				{
					Global Email_TwentyNine := element
				}
				if index = 59
				{
					Global Email_Thirty := element
				}
			}
		}

	SetTitleMatchMode, 2
	SetControlDelay -1
	SetKeyDelay, %delay_time_in_ms%, 5

	Check_internet_connection() ;check if talktalk is being a terrible ISP

	try
	{
		RunWait, GlyphClientApp.exe, J:\Glyph, 5
	}
	catch first_error
	{
		try
		{
			RunWait, GlyphClientApp.exe, J:\Glyph, 5
		}
		catch
		{
			Run, Autohotkey.exe Error_Display.ahk "GlyphClientApp.exe (Trove Dashboard) could not be found!`nEdit line 293 of Glyph_Login.ahk to your Trove directory"
		}
	}

	Gui, +AlwaysOnTop
	Gui, Add, Tab, x-6 y-2 w250 h225, Launch Options|Info|Emails

	Gui, Tab, Launch Options
	howlonguntilrestartseconds := Round(how_long_until_restart /= 60000, 2)
	Gui, Add, CheckBox, x32 y29 w150 h30 vOpenBackpack, F3 To Open backpack on all clients, when in-game
	Gui, Add, CheckBox, x32 y58 w150 h30 vLaunchFishingBot, Start Nippy's fishing bot upon launch
	Gui, Add, CheckBox, x32 y90 w150 h30 vRestartEveryDelay, Restart clients every %howlonguntilrestartseconds% minutes
	Gui, Add, CheckBox, x32 y118 w150 h30 vlaunch_with_gui, Launch with Option_Gui
	Gui, Add, Button, x22 y155 w200 h40 glaunchthemainscript, Launch

	Gui, Tab, Info
	Gui, Add, Text, x12 y29 w220 h70, Made by BLURREDDOGE / JELLYMAN123                                                                      Copyright 2018`, Luke Roper`, All rights reserved. - https://www.gov.uk/copyright
	Gui, Add, Text, x12 y99 w220 h40, - You are free to edit this but under no circumstances`, without my written permission`, are you allowed to redistribute this code yourself.

	Gui, Tab, Emails
	Gui, Add, Button, x22 y25 w200 h190 gshowemails, Show Emails
	Gui, Show, x100 y225 h220 w240, Launcher
	return

	showemails:
    spaceforemaillist := Chr(160)
	if Email_One{
	stringof_emails = %stringof_emails% %spaceforemaillist% 1: %Email_One%  `n
	}
	if Email_Two{
	stringof_emails = %stringof_emails%  2: %Email_Two%  `n
	}
	if Email_Three{
	stringof_emails = %stringof_emails%  3: %Email_Three%  `n
	}
	if Email_Four{
	stringof_emails = %stringof_emails%  4: %Email_Four%  `n
	}
	if Email_Five{
	stringof_emails = %stringof_emails%  5: %Email_Five%  `n
	}
	if Email_Six{
	stringof_emails = %stringof_emails%  6: %Email_Six%  `n
	}
	if Email_Seven{
	stringof_emails = %stringof_emails%  7: %Email_Seven%  `n
	}
	if Email_Eight{
	stringof_emails = %stringof_emails%  8: %Email_Eight%  `n
	}
	if Email_Nine{
	stringof_emails = %stringof_emails%  9: %Email_Nine%  `n
	}
	if Email_Ten{
	stringof_emails = %stringof_emails%  10: %Email_Ten%  `n
	}
	if Email_Eleven{
	stringof_emails = %stringof_emails%  11: %Email_Eleven%  `n
	}
	if Email_Twelve{
	stringof_emails = %stringof_emails%  12: %Email_Twelve%  `n
	}
	if Email_Thirteen{
	stringof_emails = %stringof_emails%  13: %Email_Thirteen%  `n
	}
	if Email_Fourteen{
	stringof_emails = %stringof_emails%  14: %Email_Fourteen%  `n
	}
	if Email_Fithteen{
	stringof_emails = %stringof_emails%  15: %Email_Fithteen%  `n
	}
	if Email_Sixteen{
	stringof_emails = %stringof_emails%  16: %Email_Sixteen%  `n
	}
	if Email_Seventeen{
	stringof_emails = %stringof_emails%  17: %Email_Seventeen%  `n
	}
	if Email_Eighteen{
	stringof_emails = %stringof_emails%  18: %Email_Eighteen%  `n
	}
	if Email_Nineteen{
	stringof_emails = %stringof_emails%  19: %Email_Nineteen%  `n
	}
	if Email_Twenty{
	stringof_emails = %stringof_emails%  20: %Email_Twenty%  `n
	}
	if Email_TwentyOne{
	stringof_emails = %stringof_emails%  21: %Email_TwentyOne%  `n
	}
	if Email_TwentyTwo{
	stringof_emails = %stringof_emails%  22: %Email_TwentyTwo%  `n
	}
	if Email_TwentyThree{
	stringof_emails = %stringof_emails%  23: %Email_TwentyThree%  `n
	}
	if Email_TwentyFour{
	stringof_emails = %stringof_emails%  24: %Email_TwentyFour%  `n
	}
	if Email_TwentyFive{
	stringof_emails = %stringof_emails%  25: %Email_TwentyFive%  `n
	}
	if Email_TwentySix{
	stringof_emails = %stringof_emails%  26: %Email_TwentySix%  `n
	}
	if Email_TwentySeven{
	stringof_emails = %stringof_emails%  27: %Email_TwentySeven%  `n
	}
	if Email_TwentyEight{
	stringof_emails = %stringof_emails%  28: %Email_TwentyEight%  `n
	}
	if Email_TwentyNine{
	stringof_emails = %stringof_emails%  29: %Email_TwentyNine%  `n
	}
	if Email_Thirty{
	stringof_emails = %stringof_emails%  30: %Email_Thirty%  `n
	}
	MsgBox,0,Emails,
	(
	Emails entered: `n%stringof_emails%
	)
	stringof_emails = `
		return

	launchthemainscript:
	Gui, Submit
	Gui, Destroy

	if launch_with_gui = 1
	{
		Run, AutoHotkey.exe Option_Gui.ahk %OpenBackpack% %LaunchFishingBot% %RestartEveryDelay%
	}

	if RestartEveryDelay = 1
	{
		loop
		{
			window_setup(1, 0)
			Sleep, %normal_sleep%
			if (LaunchFishingBot)
			{
				Send, ^{Numpad1}
			}
			if (OpenBackpack)
			{
				Run, AutoHotKey.exe Open_Backpack.ahk
			}
			numberonloop = 1
			loop, 30
			{
				WinKill, Client%numberonloop%
				numberonloop += 1
			}
		}
	}
	else if !(RestartEveryDelay)
	{
		window_setup(1, 0)
		Sleep, %normal_sleep%
			if (LaunchFishingBot)
			{
				Send, ^{Numpad1}
			}
			if (OpenBackpack)
			{
				Run, AutoHotKey.exe Open_Backpack.ahk
			}
		ExitApp
	}
}
IfNotExist, database.txt
{
	MsgBox, You do not need to fill in all the boxes`, only the ones you want.
	Gui, New,, Create Email+Password Database
	Gui, Color, A9A9A9

	;			  Gui Group 1		   
	Gui, Add, groupbox, x10 y5 w180 h105
	Gui, Add, Text, x15 y15, Email 1:
	Gui, Add, Edit, w170 vEmail_One
	Gui, Add, Text, x15 y65, Password 1:
	Gui, Add, Edit, w170 Password vPassword_One
		;			  Gui Group 7			
		Gui, Add, groupbox, x200 y5 w180 h105
		Gui, Add, Text, x205 y15, Email 7:
		Gui, Add, Edit, w170 vEmail_Seven
		Gui, Add, Text, x205 y65, Password 7:
		Gui, Add, Edit, w170 Password vPassword_Seven
			;			  Gui Group 13			
			Gui, Add, groupbox, x390 y5 w180 h105
			Gui, Add, Text, x395 y15, Email 13:
			Gui, Add, Edit, w170 vEmail_Thirteen
			Gui, Add, Text, x395 y65, Password 13:
			Gui, Add, Edit, w170 Password vPassword_Thirteen
				;			  Gui Group 19			
				Gui, Add, groupbox, x580 y5 w180 h105
				Gui, Add, Text, x585 y15, Email 19:
				Gui, Add, Edit, w170 vEmail_Nineteen
				Gui, Add, Text, x585 y65, Password 19:
				Gui, Add, Edit, w170 Password vPassword_Nineteen
					;			  Gui Group 25			
					Gui, Add, groupbox, x770 y5 w180 h105
					Gui, Add, Text, x775 y15, Email 25:
					Gui, Add, Edit, w170 vEmail_TwentyFive
					Gui, Add, Text, x775 y65, Password 25:
					Gui, Add, Edit, w170 Password vPassword_TwentyFive
	;			  Gui Group 2			
	Gui, Add, groupbox, x10 y110 w180 h105
	Gui, Add, Text, x15 y120, Email 2:
	Gui, Add, Edit, w170 vEmail_Two
	Gui, Add, Text, x15 y170, Password 2:
	Gui, Add, Edit, w170 Password vPassword_Two
		;			  Gui Group 8			  
		Gui, Add, groupbox, x200 y110 w180 h105
		Gui, Add, Text, x205 y120, Email 8:
		Gui, Add, Edit, w170 vEmail_Eight
		Gui, Add, Text, x205 y170, Password 8:
		Gui, Add, Edit, w170 Password vPassword_Eight
			;			  Gui Group 14		      
			Gui, Add, groupbox, x390 y110 w180 h105
			Gui, Add, Text, x395 y120, Email 14:
			Gui, Add, Edit, w170 vEmail_Fourteen
			Gui, Add, Text, x395 y170, Password 14:
			Gui, Add, Edit, w170 Password vPassword_Fourteen
				;			  Gui Group 20		      
				Gui, Add, groupbox, x580 y110 w180 h105
				Gui, Add, Text, x585 y120, Email 20:
				Gui, Add, Edit, w170 vEmail_Twenty
				Gui, Add, Text, x585 y170, Password 20:
				Gui, Add, Edit, w170 Password vPassword_Twenty
					;			  Gui Group 26		      
					Gui, Add, groupbox, x770 y110 w180 h105
					Gui, Add, Text, x775 y120, Email 26:
					Gui, Add, Edit, w170 vEmail_TwentySix
					Gui, Add, Text, x775 y170, Password 26:
					Gui, Add, Edit, w170 Password vPassword_TwentySix
	;			  Gui Group 3			
	Gui, Add, groupbox, x10 y215 w180 h105
	Gui, Add, Text, x15 y225, Email 3:
	Gui, Add, Edit, w170 vEmail_Three
	Gui, Add, Text, x15 y275, Password 3:
	Gui, Add, Edit, w170 Password vPassword_Three
		;			  Gui Group 9			  
		Gui, Add, groupbox, x200 y215 w180 h105
		Gui, Add, Text, x205 y225, Email 9:
		Gui, Add, Edit, w170 vEmail_Nine
		Gui, Add, Text, x205 y275, Password 9:
		Gui, Add, Edit, w170 Password vPassword_Nine
			;			  Gui Group 15		  
			Gui, Add, groupbox, x390 y215 w180 h105
			Gui, Add, Text, x395 y225, Email 15:
			Gui, Add, Edit, w170 vEmail_Fifthteen
			Gui, Add, Text, x395 y275, Password 15:
			Gui, Add, Edit, w170 Password vPassword_Fiftheen
				;			  Gui Group 21		  
				Gui, Add, groupbox, x580 y215 w180 h105
				Gui, Add, Text, x585 y225, Email 21:
				Gui, Add, Edit, w170 vEmail_TwentyOne
				Gui, Add, Text, x585 y275, Password 21:
				Gui, Add, Edit, w170 Password vPassword_TwentyOne
					;			  Gui Group 27		  
					Gui, Add, groupbox, x770 y215 w180 h105
					Gui, Add, Text, x775 y225, Email 27:
					Gui, Add, Edit, w170 vEmail_TwentySeven
					Gui, Add, Text, x775 y275, Password 27:
					Gui, Add, Edit, w170 Password vPassword_TwentySeven
	;			  Gui Group 4			
	Gui, Add, groupbox, x10 y320 w180 h105
	Gui, Add, Text, x15 y330, Email 4:
	Gui, Add, Edit, w170 vEmail_Four
	Gui, Add, Text, x15 y380, Password 4:
	Gui, Add, Edit, w170 Password vPassword_Four
		;			  Gui Group 10			  
		Gui, Add, groupbox, x200 y320 w180 h105
		Gui, Add, Text, x205 y330, Email 10:
		Gui, Add, Edit, w170 vEmail_Ten
		Gui, Add, Text, x205 y380, Password 10:
		Gui, Add, Edit, w170 Password vPassword_Ten
			;			  Gui Group 16 		  
			Gui, Add, groupbox, x390 y320 w180 h105
			Gui, Add, Text, x395 y330, Email 16:
			Gui, Add, Edit, w170 vEmail_Sixteen
			Gui, Add, Text, x395 y380, Password 16:
			Gui, Add, Edit, w170 Password vPassword_Sixteen
				;			  Gui Group 22 		  
				Gui, Add, groupbox, x580 y320 w180 h105
				Gui, Add, Text, x585 y330, Email 22:
				Gui, Add, Edit, w170 vEmail_TwentyTwo
				Gui, Add, Text, x585 y380, Password 22:
				Gui, Add, Edit, w170 Password vPassword_TwentyTwo
					;			  Gui Group 28 		  
					Gui, Add, groupbox, x770 y320 w180 h105
					Gui, Add, Text, x775 y330, Email 28:
					Gui, Add, Edit, w170 vEmail_TwentyEight
					Gui, Add, Text, x775 y380, Password 28:
					Gui, Add, Edit, w170 Password vPassword_TwentyEight
	;			  Gui Group 5			
	Gui, Add, groupbox, x10 y425 w180 h105
	Gui, Add, Text, x15 y435, Email 5:
	Gui, Add, Edit, w170 vEmail_Five
	Gui, Add, Text, x15 y485, Password 5:
	Gui, Add, Edit, w170 Password vPassword_Five
		;			  Gui Group 11			  
		Gui, Add, groupbox, x200 y425 w180 h105
		Gui, Add, Text, x205 y435, Email 11:
		Gui, Add, Edit, w170 vEmail_Eleven
		Gui, Add, Text, x205 y485, Password 11:
		Gui, Add, Edit, w170 Password vPassword_Eleven
			;			  Gui Group 17			  
			Gui, Add, groupbox, x390 y425 w180 h105
			Gui, Add, Text, x395 y435, Email 17:
			Gui, Add, Edit, w170 vEmail_Seventeen
			Gui, Add, Text, x395 y485, Password 17:
			Gui, Add, Edit, w170 Password vPassword_Seventeen
				;			  Gui Group 23			  
				Gui, Add, groupbox, x580 y425 w180 h105
				Gui, Add, Text, x585 y435, Email 23:
				Gui, Add, Edit, w170 vEmail_TwentyThree
				Gui, Add, Text, x585 y485, Password 23:
				Gui, Add, Edit, w170 Password vPassword_TwentyThree
					;			  Gui Group 29			  
					Gui, Add, groupbox, x770 y425 w180 h105
					Gui, Add, Text, x775 y435, Email 29:
					Gui, Add, Edit, w170 vEmail_TwentyNine
					Gui, Add, Text, x775 y485, Password 29:
					Gui, Add, Edit, w170 Password vPassword_TwentyNine
	;			  Gui Group 6			
	Gui, Add, groupbox, x10 y530 w180 h105
	Gui, Add, Text, x15 y540, Email 6:
	Gui, Add, Edit, w170 vEmail_Six
	Gui, Add, Text, x15 y590, Password 6:
	Gui, Add, Edit, w170 Password vPassword_Six
		;			  Gui Group 12		  	  
		Gui, Add, groupbox, x200 y530 w180 h105
		Gui, Add, Text, x205 y540, Email 12:
		Gui, Add, Edit, w170 vEmail_Twelve
		Gui, Add, Text, x205 y590, Password 12:
		Gui, Add, Edit, w170 Password vPassword_Twelve
			;			  Gui Group 18		  	  
			Gui, Add, groupbox, x390 y530 w180 h105
			Gui, Add, Text, x395 y540, Email 18:
			Gui, Add, Edit, w170 vEmail_Eighteen
			Gui, Add, Text, x395 y590, Password 18:
			Gui, Add, Edit, w170 Password vPassword_Eighteen
				;			  Gui Group 24		  	  
				Gui, Add, groupbox, x580 y530 w180 h105
				Gui, Add, Text, x585 y540, Email 24:
				Gui, Add, Edit, w170 vEmail_TwentyFour
				Gui, Add, Text, x585 y590, Password 24:
				Gui, Add, Edit, w170 Password vPassword_TwentyFour
					;			  Gui Group 30		  	  
					Gui, Add, groupbox, x770 y530 w180 h105
					Gui, Add, Text, x775 y540, Email 30:
					Gui, Add, Edit, w170 vEmail_Thirty
					Gui, Add, Text, x775 y590, Password 30:
					Gui, Add, Edit, w170 Password vPassword_Thirty

	Gui, Add, Button, x10 y640 w940 gOK, Continue
	Gui, Show, w965 h675
	return

	OK:
	Gui, Submit
	Gui, Destroy
	if (Email_One) and (Password_One){
		FileAppend, %Email_One%`n%Password_One%`n, database.txt
		}
	if (Email_Two) and (Password_Two){
		FileAppend, %Email_Two%`n%Password_Two%`n, database.txt
		}
	if (Email_Three) and (Password_Three){
		FileAppend, %Email_Three%`n%Password_Three%`n, database.txt
	    }
	if (Email_Four) and (Password_Four){
		FileAppend, %Email_Four%`n%Password_Four%`n, database.txt
	    }
	if (Email_Five) and (Password_Five){
		FileAppend, %Email_Five%`n%Password_Five%`n, database.txt
	    }
	if (Email_Six) and (Password_Six){
		FileAppend, %Email_Six%`n%Password_Six%`n, database.txt
	    }
	if (Email_Seven) and (Password_Seven){
		FileAppend, %Email_Seven%`n%Password_Seven%`n, database.txt
	    }
	if (Email_Eight) and (Password_Eight){
		FileAppend, %Email_Eight%`n%Password_Eight%`n, database.txt
	    }
	if (Email_Nine) and (Password_Nine){
		FileAppend, %Email_Nine%`n%Password_Nine%`n, database.txt
	    }
	if (Email_Ten) and (Password_Ten){
		FileAppend, %Email_Ten%`n%Password_Ten%`n, database.txt
	    }
	if (Email_Eleven) and (Password_Eleven){
		FileAppend, %Email_Eleven%`n%Password_Eleven%`n, database.txt
	    }
	if (Email_Twelve) and (Password_Twelve){
		FileAppend, %Email_Twelve%`n%Password_Twelve%`n, database.txt
	    }
	if (Email_Thirteen) and (Password_Thirteen){
		FileAppend, %Email_Thirteen%`n%Password_Thirteen%`n, database.txt
	    }
	if (Email_Fourteen) and (Password_Fourteen){
		FileAppend, %Email_Fourteen%`n%Password_Fourteen%`n, database.txt
	    }
	if (Email_Fifthteen) and (Password_Fifthteen){
		FileAppend, %Email_Fifthteen%`n%Password_Fifthteen%`n, database.txt
	    }
	if (Email_Sixteen) and (Password_Sixteen){
		FileAppend, %Email_Sixteen%`n%Password_Sixteen%`n, database.txt
	    }
	if (Email_Seventeen) and (Password_Seventeen){
		FileAppend, %Email_Seventeen%`n%Password_Seventeen%`n, database.txt
	    }
	if (Email_Eighteen) and (Password_Eighteen){
		FileAppend, %Email_Eighteen%`n%Password_Eighteen%`n, database.txt
	    }
	if (Email_Nineteen) and (Password_Nineteen){
		FileAppend, %Email_Nineteen%`n%Password_Nineteen%`n, database.txt
	    }
	if (Email_Twenty) and (Password_Twenty){
		FileAppend, %Email_Twenty%`n%Password_Twenty%`n, database.txt
	    }
	if (Email_TwentyOne) and (Password_TwentyOne){
		FileAppend, %Email_TwentyOne%`n%Password_TwentyOne%`n, database.txt
	    }
	if (Email_TwentyTwo) and (Password_TwentyTwo){
		FileAppend, %Email_TwentyTwo%`n%Password_TwentyTwo%`n, database.txt
	    }
	if (Email_TwentyThree) and (Password_TwentyThree){
		FileAppend, %Email_TwentyThree%`n%Password_TwentyThree%`n, database.txt
	    }
	if (Email_TwentyFour) and (Password_TwentyFour){
		FileAppend, %Email_TwentyFour%`n%Password_TwentyFour%`n, database.txt
	    }
	if (Email_TwentyFive) and (Password_TwentyFive){
		FileAppend, %Email_TwentyFive%`n%Password_TwentyFive%`n, database.txt
	    }
	if (Email_TwentySix) and (Password_TwentySix){
		FileAppend, %Email_TwentySix%`n%Password_TwentySix%`n, database.txt
	    }
	if (Email_TwentySeven) and (Password_TwentySeven){
		FileAppend, %Email_TwentySeven%`n%Password_TwentySeven%`n, database.txt
	    }
	if (Email_TwentyEight) and (Password_TwentyEight){
		FileAppend, %Email_TwentyEight%`n%Password_TwentyEight%`n, database.txt
	    }
	if (Email_TwentyNine) and (Password_TwentyNine){
		FileAppend, %Email_TwentyNine%`n%Password_TwentyNine%`n, database.txt
	    }
	if (Email_Thirty) and (Password_Thirty){
		FileAppend, %Email_Thirty%`n%Password_Thirty%`n, database.txt
	    }
	reload
	return
}

add_runnum(only_once)
{
	if only_once = 1
	{
		return 0
	}
	else
	{
		runnum += 1
		return 1
	}
}

window_setup(runnum, only_once)
{
	loop, 1
	{
		if Email_Thirteeen
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client8
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 9)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client9
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 10)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client10
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 11)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client11
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 12)
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client12
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if Email_Thirteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client13
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%			
			}
			if Email_Fourteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client14
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Fifthteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client15
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Sixteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client16
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Seventeen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client17
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Eighteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client18
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Nineteen
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client19
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Twenty
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client20
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyOne
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client21
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyTwo
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client22
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyThree
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client23
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyFour
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client24
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyFive
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client25
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentySix
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client26
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentySeven
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client27
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyEight
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client28
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_TwentyNine
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client29
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if Email_Thirty
			{
				runloginfunctions(runnum)
				WinSetTitle, Trove,, Client30
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(30)
		}
		else if Email_Twelve
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client8
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 9)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 690, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client9
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 10)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 690, 485, 355
				WinSetTitle, Trove,, Client10
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 11)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 690, 485, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client11
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 12)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1443, 690, 485, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client12
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(12)
		}
		else if Email_Eleven
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client8
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 9)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 690, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client9
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 10)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 690, 485, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client10
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 11)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 944, 690, 983, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client11
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(11)
		}
		else if Email_Ten
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 0, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 473, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1433, 345, 495, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client8
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 9)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 690, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client9
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 10)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 690, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client10
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(10)
		}
		else if Email_Nine
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 633, 0, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1273, 0, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 347, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 633, 347, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1273, 347, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum) 
				WinMove, Trove,, -7, 694, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 633, 694, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client8
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 9)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1273, 694, 655, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client9
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(9)
		}
		else if Email_Eight
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 478, 0, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 963, 0, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1448, 0, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 530, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 478, 530, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 963, 530, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 8)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1448, 530, 500, 540
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client8
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(8)
		}
		else if Email_Seven
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 0, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 345, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 692, 655, 357
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 633, 692, 655, 357
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 7)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 1273, 692, 655, 357
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client7
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(7)
		}
		else if Email_Six
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 0, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 345, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 690, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 6)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 690, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client6
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(6)
		}
		else if Email_Five
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 0, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 345, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
					
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 948, 345, 979, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 5)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 690, 970, 355
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client5
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(5)
		}
		else if Email_Four
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 517, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 4)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 517, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client4
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(4)
		}
		else if Email_Three
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 975, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				if (add_runnum(only_once)) = 0
				{
					break
				} 
				Sleep, %normal_sleep%
			}
			if (runnum = 3)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 517, 1935, 527
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client3
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(3)
		}
		else if Email_Two
		{
			if (runnum = 1)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, -7, 0, 975, 1054
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client1
				if (add_runnum(only_once)) = 0
				{
					break
				}
				Sleep, %normal_sleep%
			}
			if (runnum = 2)
			{
				runloginfunctions(runnum)
				WinMove, Trove,, 953, 0, 975, 1054
				Sleep, %normal_sleep%
				WinSetTitle, Trove,, Client2
				Sleep, %normal_sleep%
			}
			check_for_crashed_clients(2)
		}
		else if Email_One
		{
			runloginfunctions(runnum)
			WinMove, Trove,, -7, 0, 975, 1054
			Sleep, %normal_sleep%
			WinSetTitle, Trove,, Client1
			check_for_crashed_clients(1)
		}
	}
}


check_for_crashed_clients(emailnum)
{
	num := (emailnum - emailnum) + 1
	loop %emailnum%
	{
		client_name := "Client" . num
		if !WinExist(client_name)
		{
			window_setup(num, 1)
		}
		num := num + 1
	}
}


Check_internet_connection()
{
	if (DllCall("Wininet.dll\InternetGetConnectedState", "Str", 0x40,"Int",0)) = 0
	{
		loop
		{
			if (DllCall("Wininet.dll\InternetGetConnectedState", "Str", 0x40,"Int",0)) = 0
			{
				Run, Autohotkey.exe Error_Display.ahk "You need to be connected to the internet to login to Glyph!" "continue"
				loop
				{
					if (DllCall("Wininet.dll\InternetGetConnectedState", "Str", 0x40,"Int",0)) = 1
					{
						break
						Sleep, 1000
					}
					Sleep, 600
					if !WinExist("Error_Display.ahk")
					{
						Run, Autohotkey.exe Error_Display.ahk "You need to be connected to the internet to login to Glyph!`n(on reconnect gui will update)" "continue"
						Sleep, 1000
					}
				}
			}
			else
			{
				DetectHiddenWindows, On
				WinClose, Error_Display.ahk ahk_class AutoHotkey
				DetectHiddenWindows, Off
				break
			}
			Sleep, 1000
		}
	}
}


runloginfunctions(num)
{
	change_account()
	set_glyph_login_name()
	login_account(num) 
	errorchecklogin(num)
}

change_account()
{
	ControlClick, x900 y20, Glyph
	Sleep, %normal_sleep%
	ControlSend,, {down down}{down up}, Glyph
	Sleep, %normal_sleep%
	ControlClick, x900 y20, Glyph
	Sleep, %normal_sleep%
	ControlSend,, {down down}{down up}, Glyph
	Sleep, %normal_sleep%
}

set_glyph_login_name()
{
	ifWinExist, Glyph Login
	{
		global glyphloginname = "Glyph Login"
	}
	ifWinExist, Glyph Anmeldung
	{
		global glyphloginname = "Glyph Anmeldung"
	}
	ifWinExist, Connexion à Glyph
	{
		global glyphloginname = "Connexion à Glyph"
	}
	ifWinExist, Вход в систему Glyph
	{
		global glyphloginname = "Вход в систему Glyph"
	}
	ifWinExist, Inicio de sesión de Glyph
	{
		global glyphloginname = "Inicio de sesión de Glyph"
	}
	ifWinExist, Login da Glyph
	{
		global glyphloginname = "Login da Glyph"
	}
	ifWinExist, Glyph 로그인
	{
		global glyphloginname = "Glyph 로그인"
	}
	ifWinExist, 登录 Glyph
	{
		global glyphloginname = "登录 Glyph"
	}
}

login_account(num) 
{
	if num = 1
	{
		compact_login_account(num, Email_One, Password_One)
	}
	else if num = 2
    {
        compact_login_account(num, Email_Two, Password_Two)
    }
	else if num = 3
    {
        compact_login_account(num, Email_Three, Password_Three)
    }
	else if num = 4
    {
        compact_login_account(num, Email_Four, Password_Four)
    }
	else if num = 5
    {
        compact_login_account(num, Email_Five, Password_Five)
    }
	else if num = 6
    {
        compact_login_account(num, Email_Six, Password_Six)
    }
	else if num = 7
    {
        compact_login_account(num, Email_Seven, Password_Seven)
    }
	else if num = 8
    {
        compact_login_account(num, Email_Eight, Password_Eight)
    }
	else if num = 9
    {
        compact_login_account(num, Email_Nine, Password_Nine)
    }
	else if num = 10
    {
        compact_login_account(num, Email_Ten, Password_Ten)
    }
	else if num = 11
    {
        compact_login_account(num, Email_Eleven, Password_Eleven)
    }
	else if num = 12
    {
        compact_login_account(num, Email_Twelve, Password_Twelve)
    }
	else if num = 13
	{
        compact_login_account(num, Email_Thirteen, Password_Thirteen)
    }
	else if num = 14
	{
        compact_login_account(num, Email_Fourteen, Password_Fourteen)
    }
	else if num = 15
	{
        compact_login_account(num, Email_Fifthteen, Password_Fifthteen)
    }
	else if num = 16
	{
        compact_login_account(num, Email_Sixteen, Password_Sixteen)
    }
	else if num = 17
	{
        compact_login_account(num, Email_Seventeen, Password_Seventeen)
    }
	else if num = 18
	{
        compact_login_account(num, Email_Eighteen, Password_Eighteen)
    }
	else if num = 19
	{
        compact_login_account(num, Email_Nineteen, Password_Nineteen)
    }
	else if num = 20
	{
        compact_login_account(num, Email_Twenty, Password_Twenty)
    }
	else if num = 21
	{
        compact_login_account(num, Email_TwentyOne, Password_TwentyOne)
    }
	else if num = 22
	{
        compact_login_account(num, Email_TwentyTwo, Password_TwentyTwo)
    }
	else if num = 23
	{
        compact_login_account(num, Email_TwentyThree, Password_TwentyThree)
    }
	else if num = 24
	{
        compact_login_account(num, Email_TwentyFour, Password_TwentyFour)
    }
	else if num = 25
	{
        compact_login_account(num, Email_TwentyFive, Password_TwentyFive)
    }
	else if num = 26
	{
        compact_login_account(num, Email_TwentySix, Password_TwentySix)
    }
	else if num = 27
    {
        compact_login_account(num, Email_TwentySeven, Password_TwentySeven)
    }
	else if num = 28
    {
        compact_login_account(num, Email_TwentyEight, Password_TwentyEight)
    }
	else if num = 29
    {
        compact_login_account(num, Email_TwentyNine, Password_TwentyNine)
    }
	else if num = 30
    {
        compact_login_account(num, Email_Thirty, Password_Thirty)
    }
	Sleep, %normal_sleep%
}

errorchecklogin(errorcheckaccount)
{
	WinWaitActive, Trove,, %wait_for_trove_to_open%
	if ErrorLevel
	{
		WinWaitActive, Trove,, %wait_for_trove_to_open%
		if ErrorLevel
		{
			ControlClick, x430 y530, Glyph
			WinWaitActive, Trove,, %wait_for_trove_to_open%
			if ErrorLevel
			{
				login_account(errorcheckaccount)
			}
		}
	}

}

compact_login_account(num, email, pass)
{
	clear_email_glyph_login()
	send_from_clipboard(email)
	ControlClick, x147 y322, %glyphloginname%
	Sleep, %normal_sleep%
	send_from_clipboard(pass)
	ControlSend,, {enter down}{enter up}, %glyphloginname%
	WinWaitNotActive, %glyphloginname%,, 2
	if ErrorLevel
	{
		login_account(num)
	}	
	Sleep, %wait_for_glyph_to_login%
	ControlClick, x430 y530, Glyph	
}

clear_email_glyph_login()
{
	loop 3{
	ControlClick, x155 y253, %glyphloginname%
	Sleep, %normal_sleep%
	}
}

send_from_clipboard(stuff_to_save)
{
	clipboard =  %stuff_to_save%
	ControlSend,, ^v, %glyphloginname%, 
	clipboard = ` ;clear clipboard
}

Check_for_pop_up_on_lauch(x)
{
	WinGetPos, , , WinW, WinH, Client%x%
	WinWh := WinW//1.9
	WinHh := WinH//8.3
	WinWw := WinW//18
	WinHw := WinH//19
	WinWf := WinWh-WinWw
	WinHf := WinHh+WinHw
	PixelGetColor, col, WinWf, WinHf, RGB
	;if col1 = "0x"
	return col
}

EndLoop:
	StopLoop := true
return

CloseFunction(ExitFor, ExitCode)
{
	oof := True
}
class GlyphLoginExit
{
    DoBeforeExit()
    {
		Send, {Shift Down}
		Send, {Shift Up}
    }
}

!F4::
^F4::
F4::ExitApp