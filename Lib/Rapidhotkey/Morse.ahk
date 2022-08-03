;* Morse by Laszo @ http://www.autohotkey.com/forum/viewtopic.php?t=16951 
;* as modified by HotKeyIt @ https://www.autohotkey.com/board/topic/35566-rapidhotkey/

Morse(timeout = 400) { ;by Laszo -> http://www.autohotkey.com/forum/viewtopic.php?t=16951 (Modified to return: KeyWait %key%, T%tout%)
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