@REM Run batch file from "Send To" menu, copy this script to path:
@REM C:\Users\Invader\AppData\Roaming\Microsoft\Windows\SendTo
@echo off
echo Current Directory is %cd%
echo Current batch run is %0 %~dpnx0
echo Subject is %1 %~dpnx1
pause  