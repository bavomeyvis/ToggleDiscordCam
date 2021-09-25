#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On
SetTitleMatchMode 3 ;<-- so you can use partial window titles
; TODO: Automize finding the correct ahk_pid for discord

if WinExist("ahk_exe Discord.exe")
    WinActivate ; use the window found above
else
    MsgBox Could not open Discord

; ImageSearch uses pictures to retrieve their screen coordinates
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_WorkingDir%\green_video_btn.png
if (ErrorLevel = 2)
    MsgBox Make sure file "green_video_btn.png" exists.
else if (ErrorLevel = 1)
{
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_WorkingDir%\grey_video_btn.png
	if (ErrorLevel = 2)
		MsgBox Make sure file "grey_video_btn.png" exists.
	else if (ErrorLevel = 1)
		MsgBox Grey_video_btn.png could not be found on the screen either.
}
else 
	 MsgBox Found image at %FoundX% and %FoundY%

; Toggle camera by using camera button based on current state
; Control + Alt + z
^!z::
IfWinExist, ahk_exe Discord.exe
{
	WinGet, WinState, MinMax, ahk_pid 2280
	If WinState = -1
	{
		; MsgBox DEBUG: %WinState%
		WinActivate, ahk_pid 2280
		WinShow ahk_pid 2280
		WinMaximize ahk_pid 2280
		sleep 3000
		SetControlDelay -1
		ControlClick, x%FoundX% y%FoundY%, ahk_pid 2280,,,,NA =
		return
	}
	else
		; MsgBox DEBUG: %WinState%
		WinActivate, ahk_exe Discord.exe
		ControlClick, x%FoundX% y%FoundY%, ahk_exe Discord.exe,,,,NA
		sleep 3000
		WinMinimize ahk_exe Discord.exe
		return
}