; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "Regal工具集"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "RegalZ"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "C:\Users\Regal\Desktop\128x128.ico"
!define MUI_UNICON "C:\Users\Regal\Desktop\128x128.ico"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "C:\Users\Regal\Desktop\打包\help.txt"
; 组件选择页面
!insertmacro MUI_PAGE_COMPONENTS
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Regal工具集1.0.exe"
InstallDir "$PROGRAMFILES64\RegalTestTools"
ShowInstDetails show
ShowUnInstDetails show
BrandingText " "

Var revit1
Var revit2
Var revit3
Var revit4
Var revit5
Var revit6

Section "" SEC01
	SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\RegalTestTools.dll"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\WallEndsDisJoin.png"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\CreateWallPic.png"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\CreateFloorPic.png"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\BatchFamilyImageExport.png"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\About.png"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\64x64.ico"
  SetOutPath "$INSTDIR"
  File "C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\RegalTestTools.addin"
SectionEnd

Section
	StrCpy $1 "<Assembly>"
	StrCpy $1 "$1$INSTDIR"
	StrCpy $1 "$1\RegalTestTools.dll</Assembly>"
	
	Push <Assembly>C:\Users\Regal\source\repos\RegalTestTools\RegalTestTools\bin\Debug\RegalTestTools.dll</Assembly>
	Push $1
	Push all #replace all occurrences
	Push all #replace all occurrences
	Push "$INSTDIR\RegalTestTools.addin"
 Call AdvReplaceInFile
SectionEnd

Section "2014" SEC02
	SectionIn RO
	StrCmp $revit1 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2014"
SectionEnd

Section "2015" SEC03
  SectionIn RO
	StrCmp $revit2 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2015"
SectionEnd

Section "2016" SEC04
  SectionIn RO
	StrCmp $revit3 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2016"
SectionEnd

Section "2017" SEC05
  SectionIn RO
	StrCmp $revit4 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2017"
SectionEnd

Section "2018" SEC06
  SectionIn RO
	StrCmp $revit5 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2018"
SectionEnd

Section "2019" SEC07
  SectionIn RO
	StrCmp $revit6 "1" 0 +2
	CopyFiles "$INSTDIR\RegalTestTools.addin" "C:\ProgramData\Autodesk\Revit\Addins\2019"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\Regal工具集"
  CreateShortCut "$SMPROGRAMS\Regal工具集\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

; 区段组件描述
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC06} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC07} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END

/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2019\RegalTestTools.addin"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2018\RegalTestTools.addin"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2017\RegalTestTools.addin"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2016\RegalTestTools.addin"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2015\RegalTestTools.addin"
  Delete "C:\ProgramData\Autodesk\Revit\Addins\2014\RegalTestTools.addin"
  Delete "$INSTDIR\64x64.ico"
  Delete "$INSTDIR\About.png"
  Delete "$INSTDIR\BatchFamilyImageExport.png"
  Delete "$INSTDIR\CreateFloorPic.png"
  Delete "$INSTDIR\CreateWallPic.png"
  Delete "$INSTDIR\WallEndsDisJoin.png"
  Delete "$INSTDIR\RegalTestTools.dll"

  Delete "$SMPROGRAMS\Regal工具集\Uninstall.lnk"

  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2019"
  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2018"
  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2017"
  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2016"
  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2015"
  RMDir "C:\ProgramData\Autodesk\Revit\Addins\2014"
  RMDir "$SMPROGRAMS\Regal工具集"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Var regCount
 Var subCount
 Var regKeyName
 
Function .onInit
SetRegView 64

StrCpy $regCount 0
StrCpy $subCount 0
StrCpy $revit1 0
StrCpy $revit2 0
StrCpy $revit3 0
StrCpy $revit4 0
StrCpy $revit5 0
StrCpy $revit6 0

loop:
 EnumRegKey $regKeyName HKEY_LOCAL_MACHINE SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall $regCount
IntOp $regCount $regCount + 1
StrCmp $regKeyName "" done
StrCpy $0 $regKeyName 10 0
StrCmp $0 "Revit 2014" Revit_2014
StrCmp $0 "Revit 2015" Revit_2015
StrCmp $0 "Revit 2016" Revit_2016
StrCmp $0 "Revit 2017" Revit_2017
StrCmp $0 "Revit 2018" Revit_2018
StrCmp $0 "Revit 2019" Revit_2019
Goto loop

Revit_2014:
StrCpy $revit1 1
Goto loop

Revit_2015:
StrCpy $revit2 1
Goto loop

Revit_2016:
StrCpy $revit3 1
Goto loop

Revit_2017:
StrCpy $revit4 1
Goto loop

Revit_2018:
StrCpy $revit5 1
Goto loop

Revit_2019:
StrCpy $revit6 1
Goto loop

done:
StrCmp $revit1 1 a1 a0
a1:
SectionSetFlags ${SEC02} 1
Goto done1

a0:
SectionSetText ${SEC02} ""

done1:
StrCmp $revit2 1 b1 b0
b1:
SectionSetFlags ${SEC03} 1
Goto done2

b0:
SectionSetText ${SEC03} ""

done2:
StrCmp $revit3 1 c1 c0
c1:
SectionSetFlags ${SEC04} 1
Goto done3

c0:
SectionSetText ${SEC04} ""

done3:
StrCmp $revit4 1 d1 d0
d1:
SectionSetFlags ${SEC05} 1
Goto done4

d0:
SectionSetText ${SEC05} ""

done4:
StrCmp $revit5 1 e1 e0
e1:
SectionSetFlags ${SEC06} 1
Goto done5

e0:
SectionSetText ${SEC06} ""

done5:
StrCmp $revit6 1 f1 f0
f1:
SectionSetFlags ${SEC07} 1
Goto done6

f0:
SectionSetText ${SEC07} ""

done6:

FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd

Function AdvReplaceInFile
Exch $0 ;File to replace in
Exch
Exch $1 ;nuber to replace after
Exch
Exch 2
Exch $2 ;replace and onwards
Exch 2
Exch 3
Exch $3 ;replace with
Exch 3
Exch 4
Exch $4 ;to replace
Exch 4
Push $5 ;minus count
Push $6 ;universal
Push $7 ;end string
Push $8 ;left string
Push $9 ;right string
Push $R0 ;file1
Push $R1 ;file2
Push $R2 ;read
Push $R3 ;universal
Push $R4 ;count (onwards)
Push $R5 ;count (after)
Push $R6 ;temp file name

  GetTempFileName $R6
  FileOpen $R1 $0 r ;file to search in
  FileOpen $R0 $R6 w ;temp file
   StrLen $R3 $4
   StrCpy $R4 -1
   StrCpy $R5 -1

loop_read:
 ClearErrors
 FileRead $R1 $R2 ;read line
 IfErrors exit

   StrCpy $5 0
   StrCpy $7 $R2

loop_filter:
   IntOp $5 $5 - 1
   StrCpy $6 $7 $R3 $5 ;search
   StrCmp $6 "" file_write1
   StrCmp $6 $4 0 loop_filter

StrCpy $8 $7 $5 ;left part
IntOp $6 $5 + $R3
IntCmp $6 0 is0 not0
is0:
StrCpy $9 ""
Goto done
not0:
StrCpy $9 $7 "" $6 ;right part
done:
StrCpy $7 $8$3$9 ;re-join

IntOp $R4 $R4 + 1
StrCmp $2 all loop_filter
StrCmp $R4 $2 0 file_write2
IntOp $R4 $R4 - 1

IntOp $R5 $R5 + 1
StrCmp $1 all loop_filter
StrCmp $R5 $1 0 file_write1
IntOp $R5 $R5 - 1
Goto file_write2

file_write1:
 FileWrite $R0 $7 ;write modified line
Goto loop_read

file_write2:
 FileWrite $R0 $R2 ;write unmodified line
Goto loop_read

exit:
  FileClose $R0
  FileClose $R1

   SetDetailsPrint none
  Delete $0
  Rename $R6 $0
  Delete $R6
   SetDetailsPrint both

Pop $R6
Pop $R5
Pop $R4
Pop $R3
Pop $R2
Pop $R1
Pop $R0
Pop $9
Pop $8
Pop $7
Pop $6
Pop $5
Pop $0
Pop $1
Pop $2
Pop $3
Pop $4
FunctionEnd
