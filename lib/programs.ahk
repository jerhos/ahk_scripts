; This is a helper file
; It contains class definitions for all the programs.
; Since the programs need different implementations, it helps to make the main file more readable.
; =========================

; Program Interface
class Program {
    __Init() {
        this.path := ""
        this.actions := Map()
    }

    ; Executes the specified action within the program.
    Do(action := "") {
        hwnd := WinGetID("ahk_exe " this.path)
        ControlFocus(hwnd)
	    ControlSend(this.actions.Get(action), hwnd)
        return this
    }

    ; Executes the program. Use like the native Run() function.
        Run(options := "", directory := "") {
        Run(this.path, options, directory)
        return this
    }

    ; Waits for the specified time. Useful for chaining actions.
    Sleep(ms := 100) {
        Sleep(ms)
        return this
    }
}

; Spotify Object
class _Spotify extends Program {
    __Init() {
        this.path := A_AppData "\Spotify\Spotify.exe"
        ; Actions Map
        this.actions := Map()
        this.actions["Previous Track"]  := "^{Left}"
        this.actions["Play/Pause"]      := "{Space}"
        this.actions["Next Track"]      := "^{Right}"
        this.actions["Volume Down"]     := "^{Down}"
        this.actions["Shuffle"]         := "^s"
        this.actions["Volume Up"]       := "^{Up}"
        this.actions["Seek Backward"]   := "+{Left}"
        this.actions["Seek Forward"]    := "+{Right}"
        this.actions["Repeat"]          := "^r"
    }

    Run() {
        try {
            Run(this.path)
        } catch Error {
            WinActivate("ahk_exe " this.path)
        }
        return this
    }
}
; Firefox Object
class _Firefox extends Program {
    __Init() {
        this.path := "C:\Program Files\Firefox Nightly\firefox.exe"
    }

    Run() {
        Run(A_ComSpec ' /c ""C:\Program Files\Firefox Nightly\firefox.exe" "-new-tab" "moz-extension://19b084f2-f170-46ec-a8ea-1ff6586eb3ce/index.html""', , "Hide")
        WinActivate("ahk_exe " this.path)
        return this
    }
}
; Playnite Object
class _Playnite extends Program {
    __Init() {
        this.path := RegExReplace(A_AppData, "\\Roaming" , "\Local\Playnite\Playnite.DesktopApp.exe")
    }
}
; PowerToysRun Object
class _PowerToysRun extends Program {
    __Init() {
        this.path := "C:\Program Files\PowerToys\modules\launcher\PowerLauncher.exe"
        ; Actions Map
        this.actions := Map()
        this.actions["Open Search"] := "^!{Space}"
    }

    Do(action := "") {
        Send(this.actions.Get(action))
        return this
    }
}
; Bin Object
class _Bin extends Program {
    __Init() {
        this.path := "::{645ff040-5081-101b-9f08-00aa002f954e}"
    }
}
