#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

Run("ahk\winmove2.ahk")

; =========================================================
; App activation hotkeys
; =========================================================

#v::{
    WinActivate("ahk_class Chrome_WidgetWin_1")
}

#Home::{
    WinActivate("ahk_exe vlc.exe")
}

#n::{
    WinActivate("ahk_exe XWin_MobaX.exe")
}

!Home::{
    if WinActive("ahk_class Chrome_WidgetWin_1")
        Send("!{Home}")
    else
        Send("{Home}")
}

; =========================================================
; Mouse utilities
; =========================================================

#,::{
    CoordMode("Mouse", "Screen")
    MouseMove(A_ScreenWidth / 2, A_ScreenHeight / 2)
}

; =========================================================
; Key remaps
; =========================================================

CapsLock::Esc
#F12::CapsLock

; =========================================================
; Window ID memory slots
; =========================================================

+#]::{
    global rbid
    rbid := WinGetID("A")
}

#]::{
    global rbid
    if rbid
        WinActivate("ahk_id " rbid)
}

+#;::{
    global semid
    semid := WinGetID("A")
}

#;::{
    global semid
    if semid
        WinActivate("ahk_id " semid)
}

+#'::{
    global qid
    qid := WinGetID("A")
}

#'::{
    global qid
    if qid
        WinActivate("ahk_id " qid)
}

;+#.:{
    ;global pid
    ;pid := WinGetID("A")
;}

;#.:{
    ;global pid
    ;if pid
        ;WinActivate("ahk_id " pid)
;}

;+#/::{
    ;global slid
    ;slid := WinGetID("A")
;}

;#/:{
    ;global slid
    ;if slid
        ;WinActivate("ahk_id " slid)
;}

; =========================================================
; Transparency controls
; =========================================================

global trans := 255

#PgDn::{
    global trans
    if trans = 255
        trans := 225
    else if trans = 225
        trans := 180
    else if trans = 180
        trans := 100
    else
        trans := 255

    WinSetTransparent(trans, "A")
}

#PgUp::{
    global trans
    WinSetTransparent(255, "A")
    WinSetTransparent("Off", "A")
    trans := 255
}

; =========================================================
; Always-on-top toggle
; =========================================================

#Ins::{
    WinSetAlwaysOnTop(-1, "A")
}

; =========================================================
; Window positioning
; =========================================================

#Up::{
    WinGetPos(&X, &Y, &W, &H, "A")
    xoff := 59
    WinMove(xoff, 0,,, "A")
}

#Down::{
    WinGetPos(&X, &Y, &W, &H, "A")
    WinMove(
        A_ScreenWidth - W,
        A_ScreenHeight - H,
        , ,
        "A"
    )
}

#Left::{
    WinGetPos(&X, &Y, &W, &H, "A")
    xoff := 59
    WinMove(
        xoff,
        A_ScreenHeight - H,
        , ,
        "A"
    )
}

#Right::{
    WinGetPos(&X, &Y, &W, &H, "A")
    WinMove(
        A_ScreenWidth - W,
        0,
        , ,
        "A"
    )
}

; =========================================================
; Taskbar toggle
; =========================================================

!t::{
    static t := false
    t := !t

    if t {
        WinHide("ahk_class Shell_TrayWnd")
        WinHide("Start ahk_class Button")
    } else {
        WinShow("ahk_class Shell_TrayWnd")
        WinShow("Start ahk_class Button")
    }
}

; =========================================================
; Window tiling + Alt-Tab choreography
; =========================================================

#Esc::{
    xoff := 55
    sw := (A_ScreenWidth - xoff) / 2
    sh := A_ScreenHeight / 2

    SetKeyDelay(900)

    WinMove(xoff, 0, sw, sh, "A")
    Sleep(200)
    Send("!{Tab}")
    Sleep(200)

    WinMove(sw + xoff, 0, sw, sh, "A")
    Sleep(200)
    Send("!{Tab}{Tab}")
    Sleep(200)

    WinMove(xoff, sh, sw, sh, "A")
    Sleep(200)
    Send("!{Tab}{Tab}{Tab}")
    Sleep(200)

    WinMove(sw + xoff, sh, sw, sh, "A")
}

; =========================================================
; Mic mute toggle (Pause / Break)
; =========================================================

;Pause::{
    ;SoundSet(+1, "MASTER", "Mute", 9)
    ;master_mute := SoundGet("MASTER", "Mute", 9)
    ;ToolTip("Mute " master_mute)
    ;SetTimer(RemoveToolTip, 1000)
;}

;RemoveToolTip(){
    ;SetTimer(RemoveToolTip, 0)
    ;ToolTip()
;}

