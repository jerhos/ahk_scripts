; This is a small file for making the German ISO keyboard layout a bit more programming friendly.
; Because AltGr on the number row is a royal knucklefuck.
#Requires Autohotkey >=v2.0
#SingleInstance Force
#NoTrayIcon
; #Warn
SetWorkingDir(A_ScriptDir)

; Square Brackets
<^>!a:: SendText("[") ; AltGr+A -> "["
<^>!s:: SendText("]") ; AltGr+S -> "]"
; Round Brackets
<^>!d:: SendText("(") ; AltGr+D -> "("
<^>!f:: SendText(")") ; AltGr+F -> ")"
; Curly Brackets
<^>!c:: SendText("{") ; AltGr+C -> "{"
<^>!v:: SendText("}") ; AltGr+V -> "}"
; Backslash
+8:: SendText("\") ; Shift+8 -> "\"

; Remove Keys from original location
<^>!7:: SendText("") ; AltGr+7 -> ""
<^>!8:: SendText("") ; AltGr+8 -> ""
<^>!9:: SendText("") ; AltGr+9 -> ""
<^>!0:: SendText("") ; AltGr+0 -> ""
+9:: SendText("") ; Shift+9 -> ""