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
GUICreate("Player Controller", 415, 150)
GUICtrlCreateLabel("Mining Delay", 20, 20)
GUICtrlCreateLabel("Walking Interval", 200, 20)
GUICtrlCreateLabel("Time Interval (ms)", 20, 70)

$miningInputVal = GUICtrlCreateInput("350", 20, 40, 100, 20) ; will not accept drag&drop files
$walkingInputVal = GUICtrlCreateInput("850", 200, 40, 100, 20) ; will not accept drag&drop files
$timerInputVal = GUICtrlCreateInput("2000", 20, 90, 80, 20) ; will not accept drag&drop files
$randMovement = GUICtrlCreateCheckbox("Random Movement", 20, 120, 120, 25)

GUISetState(@SW_SHOW)

;Global variables
$x1 = 0 ;char x position ingame
$y1 = 0
$timerVal = 10000
$search1 = 0; ;imagesearch result

;grab values from gui
;$leftBound = GUICtrlRead()

;main loop logic
While (1)
   $min = 2.4
   $max = 2.5
   $miningInterval = GUICtrlRead($miningInputVal) ;left side of the screen
   $walkingInterval = GUICtrlRead($walkingInputVal)  ;right side of the screen
   $timerVal = GUICtrlRead($timerInputVal) ;movement time

   if ($atking == False) Then
      ;imageSearchName()
      moveForward($walkingInterval)
      mine($miningInterval)
      ;chunkMine()
   EndIf
WEnd

; Utility functions

;move char to the right
Func moveForward($walkingInterval)
   Send("{w down}")
   $res = Random($min, $max) * $timerVal
EndFunc   ;==>Example

;mine
Func mine($miningInterval)
   MouseDown("left")
   $res = Random($min, $max) * $timerVal
   Sleep($res)
EndFunc   ;==>Example

func chunkMine()
   ; Get screen dimensions
   ;$width = @DesktopWidth
   ;$height = @DesktopHeight

   ; Calculate center coordinates
   $centerX = 0
   $centerY = 0 ;keep y positon
   $offsetX = 0.2
   $delay = 10000


   $num = 0
   While 1
      $num = $num + 1
      MouseMove($centerX+$offsetX, $centerY , 0)
      If $num > 20 Then
         ExitLoop
      EndIf
   WEnd


EndFunc

; gui logic
Func isChecked($idControlID)
   Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc


; script controller logics 

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