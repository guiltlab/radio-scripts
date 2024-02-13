; Press key (F4) to send "next track" info every 65s - useful to mark many tracks as "listened" in fb2k
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
#MaxThreadsPerHotkey 2
F4::
	toggle:=!toggle
	While toggle{
	  Send {Media_Next}
	  Sleep 62000
	}
Return