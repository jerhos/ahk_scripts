; This is a helper file
; It contains class definitions for all the programs.
; Since the programs need different implementations, it helps to make the main file more readable, but considerably more bloaty.
; =========================

/**
 * Program interface
 * 
 * @property {string} path - The path to the program.
 * @property {Map} actions - The actions map.
 */
class Program {
    __Init() {
        this.path := ""
        this.actions := Map()
    }

    /**
     * Executes the specified action within the program.
     * 
     * @param {string} action - The action to execute.
     * @return {Object} this - The program object.
     * 
     * @example
     * Program.Do("Action 1") ; Sends the associated keystroke to the program
     */
    Do(actions := "") {
        ; Failsafe
        if (!WinExist("ahk_exe " this.path)) {
            this.Open()
            WinWait("ahk_exe " this.path)
        }
        hwnd := WinGetID("ahk_exe " this.path)
        ControlFocus(hwnd)
        ControlSend(this.actions.Get(actions), hwnd)
        return this
    }

    /**
     * Opens the program. Use like the native Run() function.
     * 
     * @param {string} [options] - The options to pass.
     * @param {string} [directory] - The directory to set.
     * @return {Object} this - The program object.
     */
    Open(directory := "", options := "") {
        ; Failsafe
        if (!WinExist("ahk_exe " this.path)) {
            Run(this.path, directory, options)
            WinWait("ahk_exe " this.path)
        }
        hwnd := WinGetID("ahk_exe " this.path)
        WinActivate(hwnd)
        return this
    }
}

; Objects
; _________________________

; Bin Folder Object
class _Bin extends Program {
    __Init() {
        this.path := "::{645ff040-5081-101b-9f08-00aa002f954e}"
    }
}

; Powershell Object
class _Powershell extends Program {
    __Init() {
        this.path := "C:\Windows\System32\WindowsPowershell\v1.0\powershell.exe"
    }
}

; Playnite Object
class _Playnite extends Program {
    __Init() {
        this.path := RegExReplace(A_AppData, "\\Roaming", "\Local\Playnite\Playnite.DesktopApp.exe")
    }

    /**
     * Opens the Playnite.
     * 
     * @return {Object} this - The program object.
     */
    Open() {
        Run(this.path)
        WinWait("ahk_exe " this.path)
        hwnd := WinGetID("ahk_exe " this.path)
        WinActivate(hwnd)
        return this
    }
}

; Steam Object
class _Steam extends Program {
    __Init() {
        this.path := A_ProgramFiles " (x86)\Steam\steam.exe"
    }

    /**
     * Opens the program.
     * 
     * @return {Object} this - The program object.
     */
    Open() {
        Run(this.path)
        WinWait("ahk_exe " this.path)
        hwnd := WinGetID("ahk_exe " this.path)
        WinActivate(hwnd)
        ; Close Special Offers popup
        specialOffers := WinWait("ahk_exe " this.path, "Special Offers", 15)
        if (specialOffers) {
            ControlFocus(specialOffers)
            ControlSend("{Esc}")
            ControlFocus(hwnd)
        }
        return this
    }
}

; Spotify Object
class _Spotify extends Program {
    __Init() {
        this.path := A_AppData "\Spotify\Spotify.exe"
        ; Actions Map
        this.actions := Map()
        this.actions["Play/Pause"] := "{Space}"
        this.actions["Previous Track"] := "{Ctrl down}{Left}{Ctrl up}"
        this.actions["Next Track"] := "{Ctrl down}{Right}{Ctrl up}"
        this.actions["Volume Down"] := "{Ctrl down}{Down}{Ctrl up}"
        this.actions["Volume Up"] := "{Ctrl down}{Up}{Ctrl up}"
        this.actions["Seek Backward"] := "{Shift Down}{Left}{Shift Up}"
        this.actions["Seek Forward"] := "{Shift Down}{Right}{Shift Up}"
        this.actions["Shuffle"] := "{Ctrl down}s{Ctrl up}"
        this.actions["Repeat"] := "{Ctrl down}r{Ctrl up}"
    }
}

; PowerToysRun Object
class _PowerToysRun extends Program {
    __Init() {
        this.path := "C:\Program Files\PowerToys\modules\launcher\PowerLauncher.exe"
        ; Actions Map
        this.actions := Map()
        this.actions["Search"] := "^!{Space}"
    }

    /**
     * Opens the PowerToysRun search.
     * 
     * @return {Object} this - The program object.
     */
    Open(action := "") {
        Send(this.actions.Get(action))
        return this
    }
}

; Firefox Object
class _Firefox extends Program {
    __Init() {
        this.path := "C:\Program Files\Firefox Nightly\firefox.exe"
    }

    /**
     * Opens Firefox as a new Tabliss tab and focuses the address bar.
     * 
     * @return {Object} this - The program object.
     */
    Open() {
        Run(A_ComSpec ' /c ""C:\Program Files\Firefox Nightly\firefox.exe" "-new-tab" "moz-extension://19b084f2-f170-46ec-a8ea-1ff6586eb3ce/index.html""', , "Hide")
        WinWait("ahk_exe " this.path, , 5)
        WinActivate("ahk_exe " this.path)
        WinWaitActive("ahk_exe " this.path, , 5)
        SendInput("{F6}")
        return this
    }
}

; Discord Object
class _Discord extends Program {
    __Init() {
        this.path := RegExReplace(A_AppData, "\\Roaming", "\Local\Discord\Update.exe")
    }

    /**
     * Opens Discord.
     * 
     * @return {Object} this - The program object.
     */
    Open() {
        Run(A_AppData "\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk", A_AppData "\Microsoft\Windows\Start Menu\Programs\Discord Inc")
        return this
    }
}