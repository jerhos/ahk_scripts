#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; To get most spotify native shortcuts:
; In Spotify, press CTRL + / (with Englisch keyboard layout)
; In Spotify, press CTRL + # (with German keyboard layout)

+Media_Play_Pause::spotifyKey("{Space}") ; Shift + Media_Play_Pause: Play/Pause

+Volume_Down::spotifyKey("^{Down}") ; Shift + Volume_Down: Volume down

+Volume_Up::spotifyKey("^{Up}") ; Shift + Volume_Up: Volume up

+Volume_Mute::spotifyKey("^s") ; Shift + Volume_Mute: Shuffle

+Media_Stop::spotifyKey("^r") ; Shift + Media_Stop: Repeat

+Media_Next::rapidHotkey("+{Right}""^{Right}","1""2") ; Shift + Media_Next: Seek forward (1x), Skip (2x)

+Media_Prev::rapidHotkey("+{Left}""^{Left}","1""2") ; Shift + Media_Prev: Seek backward (1x), Backskip (2x)

!+Media_Play_Pause::favourite() ; Ctrl + Shift + Media_Play_Pause: Favourite 

favourite()
{
    ;[NOTE:] 
    ;Favouriting can only be triggered once, since it triggers the spotify home menu for some reason.
    ;This causes the responsible control element to lose focus somehow and not gain it back.
    ;Sending "Esc" immediately after closes the home menu but doesn't get the focus back, 
    ;but I am n̶o̶t̶ ̶s̶m̶a̶r̶t̶ ̶e̶n̶o̶u̶g̶h̶  too lazy to bother fixing that.
    ;
    ;For now, clicking on the song bar should reset the focus.
    spotifyKey("!+b")
    spotifyKey("Esc")
    Return
}

; THANK YOU TO THESE INDIVIDUALS, WHO DID MOST OF THE GROUNDWORK (WHICH I SLIGHTLY MODIFIED):
;
;
; [1] SpotifyGlobalKeys.ahk by jcsthe @ https://gist.github.com/jcsteh/7ccbc6f7b1b7eb85c1c14ac5e0d65195 (see fork)
; [2] RapidHotkey by HotKeyIt @ https://www.autohotkey.com/board/topic/35566-rapidhotkey/
; [3] Morse by Laszo @ http://www.autohotkey.com/forum/viewtopic.php?t=16951
;
;

; [1] SpotifyGlobalKeys.ahk by jcsthe @ https://gist.github.com/jcsteh/7ccbc6f7b1b7eb85c1c14ac5e0d65195
; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
    WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
    Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
    spotifyHwnd := getSpotifyHwnd()
    ; Chromium ignores keys when it isn't focused.
    ; Focus the document window without bringing the app to the foreground.
    ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
    ControlSend, , %key%, ahk_id %spotifyHwnd%
    Return
}

; [2] RapidHotkey by HotKeyIt @ https://www.autohotkey.com/board/topic/35566-rapidhotkey/
;
rapidHotkey(keystroke, times="2", delay=0.2, IsLabel=0)
{
    Pattern := morse(delay*1000)
    If (StrLen(Pattern) < 2 and Chr(Asc(times)) != "1")
        Return
    If (times = "" and InStr(keystroke, """"))
    {
        Loop, Parse, keystroke,""	
            If (StrLen(Pattern) = A_Index+1)
            continue := A_Index, times := StrLen(Pattern)
    }
    Else if (RegExMatch(times, "^\d+$") and InStr(keystroke, """"))
    {
        Loop, Parse, keystroke,""
            If (StrLen(Pattern) = A_Index+times-1)
            times := StrLen(Pattern), continue := A_Index
    }
    Else if InStr(times, """")
    {
        Loop, Parse, times,""
            If (StrLen(Pattern) = A_LoopField)
            continue := A_Index, times := A_LoopField
    }
    Else if (times = "")
        continue := 1, times := 2
    Else if (times = StrLen(Pattern))
        continue = 1
    If !continue
        Return
    Loop, Parse, keystroke,""
        If (continue = A_Index)
        keystr := A_LoopField
    Loop, Parse, IsLabel,""
        If (continue = A_Index)
        IsLabel := A_LoopField
    hotkey := RegExReplace(A_ThisHotkey, "[\*\~\$\#\+\!\^]")
    IfInString, hotkey, %A_Space%
        StringTrimLeft, hotkey,hotkey,% InStr(hotkey,A_Space,1,0)
    backspace := "{BS " times "}"
    keywait = Ctrl|Alt|Shift|LWin|RWin
    Loop, Parse, keywait, |
        KeyWait, %A_LoopField%
    If ((!IsLabel or (IsLabel and IsLabel(keystr))) and InStr(A_ThisHotkey, "~") and !RegExMatch(A_ThisHotkey
            , "i)\^[^\!\d]|![^\d]|#|Control|Ctrl|LCtrl|RCtrl|Shift|RShift|LShift|RWin|LWin|Alt|LAlt|RAlt|Escape|BackSpace|F\d\d?|"
        . "Insert|Esc|Escape|BS|Delete|Home|End|PgDn|PgUp|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|AppsKey|"
        . "PrintScreen|CtrlDown|Pause|Break|Help|Sleep|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|"
        . "Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|MButton|RButton|LButton|"
    . "Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2"))
    Send % backspace
    If (WinExist("AHK_class #32768") and hotkey = "RButton")
        WinClose, AHK_class #32768
    If !IsLabel
        spotifyKey(keystr)
    else if IsLabel(keystr)
        Gosub, %keystr%
    Return
}	

; [3] Morse by Laszo @ http://www.autohotkey.com/forum/viewtopic.php?t=16951
;
morse(timeout = 400) { ;by Laszo -> http://www.autohotkey.com/forum/viewtopic.php?t=16951 (Modified to return: KeyWait %key%, T%tout%) ~HotKeyIt
    tout := timeout/1000
    key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
    IfInString, key, %A_Space%
        StringTrimLeft, key, key,% InStr(key,A_Space,1,0)
    If Key in Shift,Win,Ctrl,Alt
        key1:="{L" key "}{R" key "}"
    Loop {
        t := A_TickCount
        KeyWait %key%, T%tout%
        Pattern .= A_TickCount-t > timeout
        If(ErrorLevel)
            Return Pattern
        If key in Capslock,LButton,RButton,MButton,ScrollLock,CapsLock,NumLock
            KeyWait,%key%,T%tout% D
        else if Asc(A_ThisHotkey)=36
            KeyWait,%key%,T%tout% D
        else
            Input,pressed,T%tout% L1 V,{%key%}%key1%
        If (ErrorLevel="Timeout" or ErrorLevel=1)
            Return Pattern
        else if (ErrorLevel="Max")
            Return
    }
}