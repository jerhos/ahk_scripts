; Removing unwanted Systemtray icon from iCUE but keeping the battery info
info := TrayIcon_GetInfo("iCUE.exe")
loop info.MaxIndex()
{
    If (info[A_Index].tooltip = "iCUE")
    {
        icons := TrayIcon_GetInfo(A_LoopField)
        TrayIcon_Remove(icons[1].hwnd, icons[1].uid)
    }
}