; Application shortcuts
; =========================
#Requires Autohotkey >=v2.0
#SingleInstance Force
#NoTrayIcon
; #Warn
SetWorkingDir(A_ScriptDir)

; App paths
bin := "::{645ff040-5081-101b-9f08-00aa002f954e}"
spotify := A_AppData "\Spotify\Spotify.exe"
playnite := RegExReplace(A_AppData, "\\Roaming" , "\Local\Playnite\Playnite.DesktopApp.exe")
powertoysRun := "^!{Space}"
firefox := A_ComSpec ' /c ""C:\Program Files\Firefox Nightly\firefox.exe" "-new-tab" "-foreground" "moz-extension://19b084f2-f170-46ec-a8ea-1ff6586eb3ce/index.html""' ; ^1

; Shortcuts
RWin:: Send(powertoysRun)
#F:: Run(firefox, , "Hide")
#S:: Run(spotify)
#B:: Run(bin)
#P:: Run(playnite)

; ------------------------
; ^1: Firefox
;    Open via cmdline to get access to "-new-tab" and "-foreground" params.
;    "moz-extension://[...]" is in my case the URI for Tabliss, which I use as my new tab page.
;    You can get it via dev tools. If you use the default, leave it empty.