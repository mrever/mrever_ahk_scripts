#SingleInstance Force
SetWinDelay(2)
CoordMode("Mouse")

; -------------------------------------------------
; State
; -------------------------------------------------
global DoubleAlt := false

; =================================================
; Alt + Left Mouse Button → MOVE WINDOW
; =================================================
!LButton::{
    global DoubleAlt

    if DoubleAlt {
        MouseGetPos(,, &KDE_id)
        ; Minimize (avoids PSPad bug)
        PostMessage(0x112, 0xF020,,, "ahk_id " KDE_id)
        DoubleAlt := false
        return
    }

    ; Initial mouse + window
    MouseGetPos(&KDE_X1, &KDE_Y1, &KDE_id)
    if WinGetMinMax("ahk_id " KDE_id)
        return

    WinGetPos(&KDE_WinX1, &KDE_WinY1,,, "ahk_id " KDE_id)

    Loop {
        ; BREAK when button released (v2-correct)
        if !GetKeyState("LButton", "P")
            break

        MouseGetPos(&KDE_X2, &KDE_Y2)
        dx := KDE_X2 - KDE_X1
        dy := KDE_Y2 - KDE_Y1

        WinMove(
            KDE_WinX1 + dx,
            KDE_WinY1 + dy,
            , ,
            "ahk_id " KDE_id
        )

        Sleep(5)
    }
}

; =================================================
; Alt + Right Mouse Button → RESIZE WINDOW
; =================================================
!RButton::{
    global DoubleAlt

    if DoubleAlt {
        MouseGetPos(,, &KDE_id)
        if WinGetMinMax("ahk_id " KDE_id)
            WinRestore("ahk_id " KDE_id)
        else
            WinMaximize("ahk_id " KDE_id)

        DoubleAlt := false
        return
    }

    MouseGetPos(&KDE_X1, &KDE_Y1, &KDE_id)
    if WinGetMinMax("ahk_id " KDE_id)
        return

    WinGetPos(&KDE_WinX1, &KDE_WinY1, &KDE_WinW, &KDE_WinH, "ahk_id " KDE_id)

    ; Determine quadrant
    KDE_WinLeft := (KDE_X1 < KDE_WinX1 + KDE_WinW / 2) ? 1 : -1
    KDE_WinUp   := (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2) ? 1 : -1

    Loop {
        if !GetKeyState("RButton", "P")
            break

                ; Current mouse
                MouseGetPos(&mx, &my)

                dx := mx - KDE_X1
                dy := my - KDE_Y1

                ; Current window geometry (MUST be refreshed)
                WinGetPos(&wx, &wy, &ww, &wh, "ahk_id " KDE_id)

                WinMove(
                        wx + (KDE_WinLeft + 1) / 2 * dx,
                        wy + (KDE_WinUp   + 1) / 2 * dy,
                        ww - KDE_WinLeft * dx,
                        wh - KDE_WinUp   * dy,
                        "ahk_id " KDE_id
                       )

                KDE_X1 := mx
                KDE_Y1 := my

                Sleep(5)
    }
}

