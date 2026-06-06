@echo off
title mouse keyboard latency
:: Run as administrator.
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this file as administrator.
    pause
    exit /b
)

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f

echo.
echo Done. Restart Windows to fully apply changes.
pause
