@echo off
title pci device latency
:: Run as administrator.
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this file as administrator.
    pause
    exit /b
)

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wdf01000\Parameters" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Wdf01000\Parameters" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PcixLatencyTimerControl" /t REG_DWORD /d "20" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" /v "IoLatencyCap" /t REG_DWORD /d "20" /f

for /f %%a in ('wmic PATH Win32_PnPEntity GET DeviceID ^| findstr /l "PCI\VEN_"') do (
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v PciLatencyTimerControl /t REG_DWORD /d 20 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v PcixLatencyTimerControl /t REG_DWORD /d 20 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v IoLatencyCap /t REG_DWORD /d 20 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v fid_D3Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v fid_D2Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v fid_D1Latency /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v LowLatency /t REG_DWORD /d 1 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v LatencyPerformance /t REG_DWORD /d 64 /f
    reg.exe add "HKLM\SYSTEM\ControlSet001\Enum\PCI\%%a\Device Parameters" /v "Latency Sensitive" /t REG_SZ /d "True" /f
)

echo.
echo Done. Restart Windows to fully apply changes.
pause
