# My Personal AutoHotkey v.2 Scripts

Making them public in case anyone else finds them useful.

## Contents

* [Shortcuts](shortcuts.ahk)
    - Open the bin folder
    - Open Steam and close the promo popup
    - Open Firefox Nightly in a new tab
    - Open Discord [<sup>1</sup>](#footnote_1)
    - Open Playnite
    - Open MS Powershell
    - Open MS PowerToys Run search
    - Various Spotify commands
* [Keyboard Layout Modifications](keyboard_layout.ahk)
* [~~Tray Icon Removal~~](tray_remove.ahk) [<sup>2</sup>](#footnote_2)

## TODO

* [x] Try out a workaround for the Firefox bug
* [ ] Get [tray_remove.ahk](tray_remove.ahk) to work again (via dll call?)

## License

All files  are licensed under the [WTFPL](LICENSE) unless otherwise stated. Feel free to use them as you wish.

The files in the [lib](/lib/) folder are licensed under their respective licenses (stated in the file headers).

___

<sup id="footnote_1">1</sup> Note: Discords *Updater.exe* and *Discord.exe* (which are both referenced in the shortcut) need to be run with elevated privileges. Since Discord does not spawn an UAC prompt, and AHK doesn't error out, when failing to do so, this took me a long time to figure out. The simplest solution is to run the script itself as admin using a batch file. See [https://www.autohotkey.com/boards/viewtopic.php?t=104877#p466221](https://www.autohotkey.com/boards/viewtopic.php?t=104877#p466221)

<sup id="footnote_2">2</sup> This is broken for now, since a Win11 update broke it.
