; Application shortcuts
; =========================
#Requires Autohotkey >=v2.0
#SingleInstance Force
#NoTrayIcon
; #Warn
SetWorkingDir(A_ScriptDir)
DetectHiddenWindows(true)

#Include ".\lib\programs.ahk"

; Variables
; ------------------------

workDir := RegExReplace(A_Desktop, "\\Desktop", "")

; Apps
; ------------------------

bin          := _Bin()
steam        := _Steam()
firefox      := _Firefox()
discord      := _Discord()
spotify      := _Spotify()
playnite     := _Playnite()
powershell   := _Powershell()
powertoysRun := _PowerToysRun()

; Shortcuts
; ------------------------

#B::            bin.Open()
#S::            steam.Open()
#F::            firefox.Open()
#D::            discord.Open()
#P::            playnite.Open()
#^::            powershell.Open(workDir)
RWin::          powertoysRun.Open("Search")

Launch_Media::  spotify.Open()
F13::           spotify.Do("Play/Pause")
F14::           spotify.Do("Previous Track")
F15::           spotify.Do("Next Track")
F16::           spotify.Do("Seek Backward")
F17::           spotify.Do("Seek Forward")
F18::           spotify.Do("Volume Down")
F19::           spotify.Do("Volume Up")
F20::           spotify.Do("Shuffle")
F21::           spotify.Do("Repeat")
