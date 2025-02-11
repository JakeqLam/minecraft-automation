#include <ImageSearch2015.au3> ;must include imageSearchDLLx64, x32
#include <Misc.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>

#RequireAdmin
HotKeySet("{/}", "Terminate")
HotKeySet("-", "Terminate")
HotKeySet("+{/}", "Terminate")
HotKeySet("{`}", "TogglePause")

Global $g_bPaused = False
Global $res = 0

$atking = False

; Make sure the window is in the top left of screen
; resolution 1280x780

;creating gui
GUICreate("Hello World", 415, 150)
GUICtrlCreateLabel("Left Boundary", 20, 20)
GUICtrlCreateLabel("Right Boundary", 200, 20)
GUICtrlCreateLabel("Time Interval (ms)", 20, 70)

$LBInputVal = GUICtrlCreateInput("350", 20, 40, 100, 20) ; will not accept drag&drop files
$RBInputVal = GUICtrlCreateInput("850", 200, 40, 100, 20) ; will not accept drag&drop files
$timerInputVal = GUICtrlCreateInput("2000", 20, 90, 80, 20) ; will not accept drag&drop files
$randMovement = GUICtrlCreateCheckbox("Random Movement", 20, 120, 120, 25)

GUISetState(@SW_SHOW)


Func Terminate()
    Exit 0
EndFunc

Func TogglePause()
   $g_bPaused = Not $g_bPaused
   While $g_bPaused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
   WEnd
   ToolTip("")
EndFunc   ;==>TogglePause

;Global variables
$x1 = 0 ;char x position ingame
$y1 = 0
$leftBound = 0
$rightBound = 0
$timerVal = 1000
$search1 = 0; ;imagesearch result

;grab values from gui
;$leftBound = GUICtrlRead()


While (1)
   $min = 2.4
   $max = 2.5
   $leftBound = GUICtrlRead($LBInputVal) ;left side of the screen
   $rightBound = GUICtrlRead($RBInputVal)  ;right side of the screen
   $timerVal = GUICtrlRead($timerInputVal) ;movement time

   if ($atking == False) Then
      imageSearchName()
      moveForward($timerVal)
   EndIf
WEnd

; Utility functions

Func imageSearchName()
   ;search for name.png (must take a screenshot of img)
   For $i = 5 To 1 Step -1
      $search1 = _ImageSearch("name.png", 1, $x1, $y1, 130)
      ToolTip('Searching for name.png', 0, 0)
      If $search1 = 1 Then
         ToolTip($x1&@CRLF&$y1, 0, 0)
      EndIf
	  If $x1 < $leftBound or $x1 > $rightBound Then ExitLoop
      Sleep(Random($min, $max) * 100)
   Next
EndFunc   ;==>Example


;move char to the right
Func moveForward($timerVal)
   If $x1 < $leftBound Then
      Send("{Right down}")
      $res = Random($min, $max) * $timerVal
      Sleep($res)
      Send("{Right up}")
   EndIf
EndFunc   ;==>Example

Func isChecked($idControlID)
   Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc