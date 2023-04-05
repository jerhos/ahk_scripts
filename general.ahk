#Requires Autohotkey >=v2.0
#SingleInstance Force
#NoTrayIcon
; #Warn
SetWorkingDir(A_ScriptDir)

; App paths
bin := "::{645ff040-5081-101b-9f08-00aa002f954e}"
spotify := A_AppData "\Spotify\Spotify.exe"
firefox := A_ComSpec ' /c ""C:\Program Files\Firefox Nightly\firefox.exe" "-new-tab" "-foreground" "moz-extension://19b084f2-f170-46ec-a8ea-1ff6586eb3ce/index.html""' ; Open via cmdline to get acces to -new-tab and -foreground params
playnite := RegExReplace(A_AppData, "\\Roaming" , "\Local\Playnite\Playnite.DesktopApp.exe")

; App Shortcuts
RWin:: Send("^!{Space}") ; Launch Powertoys Run
#F:: Run(firefox, , "Min") ; Start a new Tab
#S:: Run(spotify)
#B:: Run(bin)
#P:: Run(playnite)