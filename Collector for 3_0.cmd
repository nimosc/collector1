@echo off



:: Check WMIC is available
WMIC.EXE Alias /? >NUL 2>&1 || GOTO s_error

:: Use WMIC to retrieve date and time
FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
      Set _hour=00%%H
      SET _minute=00%%I
      SET _second=00%%K
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%
      Set _hour=%_hour:~-2%
      Set _minute=%_minute:~-2%
      Set _second=%_second:~-2%

Set logtimestamp=%_mm%-%_dd%-%_yyyy%

goto make_dump

:s_error
echo WMIC is not available, using default log filename
Set logtimestamp=_

:make_dump

SET date=logs-%logtimestamp%

echo "the date"
echo %date%


md "c:\%date%-%computername%"
md "c:\%date%-%computername%"
md "c:\%date%-%computername%\CerOx-3310"
md "c:\%date%-%computername%\CerOx-Root"
md "c:\%date%-%computername%\System"

xcopy "C:\Program Files\Ornim\CerOx-3310" /o /x /e "c:\%date%-%computername%\CerOx-3310"
xcopy "D:\CerOxRoot\OutputData" /o /x /e "c:\%date%-%computername%\CerOx-Root"
xcopy "C:\WINDOWS\WindowsUpdate.log" "c:\%date%-%computername%"
xcopy "C:\Windows\System32\winevt\Logs\Application.Evtx" "c:\%date%-%computername%\System"
xcopy "C:\Windows\System32\winevt\Logs\System.Evtx" "c:\%date%-%computername%\System"
xcopy "C:\Windows\System32\winevt\Logs\Security.Evtx" "c:\%date%-%computername%\System"



:END