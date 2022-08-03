;#Warn
#SingleInstance, force

#Include %A_lineFile%/../RapidHotkey/RapidHotkey.ahk
#Include %A_LineFile%/../Rufaydium_V1-6-0/Rufaydium.ahk

Class Program {
    __New(exe, cntrl) {
        WinGet, winHwnd, ID, ahk_exe %exe%
        this.winHwnd := winHwnd
        this.winCntrl := cntrl
    }
    ; Send key combination to target, when not in focus. -> press("foobar")
    press(keys) {
        winHwnd := this.winHwnd
        ControlFocus, % this.winCntrl, ahk_id %winHwnd%
        ControlSend, , %keys%, ahk_id %winHwnd%
    }
    ; Send a sequence of keypresses to target, when not in focus. -> pressSequence("foo""bar", "10")
    pressSequence(keys, delay=0) {
        Loop, Parse, keys, ""
        {
            this.press(A_LoopField)
            Sleep, delay
        }
    }
    ; Send keys to target, when pressed multiple times
    rapidPress(keys, presses="2", delay=0.2, isLabel=0) {
        rapidkeys := RapidHotkey(keys, presses, delay, isLabel)
        this.press(rapidkeys)
    }
}
