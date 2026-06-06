@echo off
title power latency
:: Run as administrator.
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this file as administrator.
    pause
    exit /b
)

powercfg /h off
powercfg.exe /setactive SCHEME_CURRENT
powercfg /setacvalueindex scheme_current sub_processor IDLECHECK 200000
powercfg /setacvalueindex scheme_current sub_processor PERFCHECK 5000
powercfg /setacvalueindex scheme_current sub_processor IDLEPROMOTE 100
powercfg /setacvalueindex scheme_current sub_processor PERFBOOSTPOL 100
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
powercfg -setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 2
powercfg -setacvalueindex scheme_current sub_processor SCHEDPOLICY 2
powercfg -setacvalueindex scheme_current SUB_PCIEXPRESS ASPM 0
powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg -setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 0853a681-27c8-4100-a2fd-82013e970683 0
powercfg.exe /setactive SCHEME_CURRENT
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LowLatencyScalingPercentage" /t REG_DWORD /d "100" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f

echo.
echo Done. Restart Windows to fully apply changes.
pause
