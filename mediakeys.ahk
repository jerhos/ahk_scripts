#SingleInstance, Force
#NoEnv
;#Warn
;#NoTrayIcon
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%/Lib/Program.ahk

Spotify := new Program("spotify.exe", "Chrome_RenderWidgetHostHWND1")

; To get most spotify native shortcuts:
; In Spotify, press CTRL + / (with English keyboard layout)
; In Spotify, press CTRL + # (with German keyboard layout)

+Media_Play_Pause::Spotify.press("{Space}") ; Shift + Media_Play_Pause: Play/Pause

+Volume_Down::Spotify.press("^{Down}") ; Shift + Volume_Down: Volume down

+Volume_Up::Spotify.press("^{Up}") ; Shift + Volume_Up: Volume up

+Volume_Mute::Spotify.press("^s") ; Shift + Volume_Mute: Shuffle

+Media_Stop::Spotify.press("^r") ; Shift + Media_Stop: Repeat

+Media_Prev::Spotify.rapidPress("+{Left}""^{Left}","1""2") ; Shift + Media_Prev: Seek backward (1x), Backskip (2x)

+Media_Next::Spotify.rapidPress("+{Right}""^{Right}","1""2") ; Shift + Media_Prev: Seek forward (1x), Skip (2x)

;+NumpadDiv::Spotify.pressSequence() ; Shift + Numpad_Divide: Add song to playlist

+NumpadMult::Spotify.pressSequence("!+b""{Esc}", 10) ; Shift + Numpad_Multiply: Favourite song

+NumpadSub::Spotify.rapidPress("^f""^k","1""2") ; Shift + Numpad_Subtract: Quicksearch (1x), Search (2x)
