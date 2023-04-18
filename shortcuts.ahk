; Application shortcuts
; =========================
#Requires Autohotkey >=v2.0
#SingleInstance Force
#NoTrayIcon
; #Warn
SetWorkingDir(A_ScriptDir)
DetectHiddenWindows(true)

#Include ".\lib\programs.ahk"

; Apps
bin             := _Bin()
firefox         := _Firefox()
playnite        := _Playnite()
powertoysRun    := _PowerToysRun()
spotify         := _Spotify()

; Shortcuts
; ------------------------
#B::        bin.Run()
#F::        firefox.Run()
#P::        playnite.Run()
RWin::      powertoysRun.Do("Open Search")

#S::        spotify.Run()
; Ctrl Layer
^Insert::   spotify.Do("Previous Track")
^Home::     spotify.Do("Play/Pause")
^PgUp::     spotify.Do("Next Track")
^Delete::   spotify.Do("Volume Down")
^End::      spotify.Do("Shuffle")
^PgDn::     spotify.Do("Volume Up")
; Shift Layer
+Insert::   spotify.Do("Seek Backward")
+PgUp::     spotify.Do("Seek Forward")
+End::      spotify.Do("Repeat")