@echo off
title usb selective suspend latency
:: Run as administrator.
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this file as administrator.
    pause
    exit /b
)

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D1Latency" /t REG_DWORD /d 0 /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D2Latency" /t REG_DWORD /d 0 /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D3Latency" /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f

for /f %%a in ('wmic PATH Win32_USBHub GET DeviceID ^| findstr /l "USB\ROOT_HUB"') do (
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters\WDF" /v IdleInWorkingState /t REG_DWORD /d 00000000 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v SelectiveSuspendOn /t REG_DWORD /d 00000000 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v SelectiveSuspendEnabled /t REG_BINARY /d 00 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v EnhancedPowerManagementEnabled /t REG_DWORD /d 00000000 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v AllowIdleIrpInD3 /t REG_DWORD /d 00000000 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v fid_D1Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v fid_D2Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v fid_D3Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\%%a\Device Parameters" /v "Latency Sensitive" /t REG_SZ /d "True" /f
)

echo.
echo Done. Restart Windows to fully apply changes.
pause
