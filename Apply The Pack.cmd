@echo off
setlocal EnableExtensions EnableDelayedExpansion
title 67 Sec Optimization Pack by ToX Tweaks

set "ROOT=%~dp0"
set "RES=%ROOT%Resources"
set "GPU_VENDOR=unknown"
set "GPU_NAME=Unknown"
set "TOTAL=0"

cls
echo [95m============================================================[0m
echo [95m              67 SEC OPTIMIZATION PACK[0m
echo [95m                    BY TOX TWEAKS[0m
echo [95m============================================================[0m
echo.
echo [94m[DESCRIPTION][0m
echo A fast one-click PC optimizer and game booster designed to
echo reduce input delay, improve FPS stability, clean system junk,
echo optimize network responsiveness, and apply GPU-specific tweaks.
echo.
echo [93m[PERFORMANCE BENEFITS][0m
echo - Lower input latency
echo - Better FPS consistency
echo - Smoother frame pacing
echo - Reduced background activity
echo - Cleaner Windows environment
echo - Improved network responsiveness
echo - Optimized GPU-related settings
echo - Faster and more responsive gaming experience
echo.
echo [95mWebsite:[0m https://toxtweaks.com/67
echo [95mDiscord:[0m discord.gg/toxtweaks
echo.
echo [92mPress any key to apply the pack...[0m
pause >nul

set "START_TIME=%time%"

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [93mRequesting administrator permissions...[0m
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

if not exist "%RES%\" (
    echo [91m[ERROR] Resources folder not found.[0m
    echo Make sure this file is next to the Resources folder.
    pause
    exit /b 1
)

call :DetectGPU

echo.
echo [94m[GPU DETECTED][0m
echo %GPU_NAME%
echo Vendor: %GPU_VENDOR%
echo.

call :LaunchFolder "Cleanup Tools"
call :LaunchFolder "FPS Tweaks"
call :LaunchSelectedGPU
call :LaunchFolder "Latency Tweaks"
call :LaunchFolder "Network Tweaks"
call :LaunchFolder "Windows Debloat"

call :ShowLaunched
pause >nul
exit /b


:DetectGPU
for /f "usebackq delims=" %%G in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "try { (Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name) -join ' | ' } catch { (Get-WmiObject Win32_VideoController | Select-Object -ExpandProperty Name) -join ' | ' }"`) do (
    set "GPU_NAME=%%G"
)

echo !GPU_NAME! | findstr /i "nvidia geforce rtx gtx quadro" >nul && set "GPU_VENDOR=nvidia"
echo !GPU_NAME! | findstr /i "amd radeon rx vega" >nul && set "GPU_VENDOR=amd"
echo !GPU_NAME! | findstr /i "intel uhd iris arc hd graphics" >nul && set "GPU_VENDOR=intel"

exit /b


:LaunchFolder
set "FOLDER=%~1"
set "PATH_TO_RUN=%RES%\%FOLDER%"

if not exist "%PATH_TO_RUN%\" (
    echo [93m[SKIP][0m %FOLDER% folder not found.
    exit /b
)

echo.
echo [95m[%FOLDER%][0m
echo ============================================================

for /r "%PATH_TO_RUN%" %%B in (*.bat *.cmd) do (
    call :LaunchBatch "%%~fB" "%%~nxB"
)

exit /b


:LaunchSelectedGPU
set "GPU_DIR=%RES%\GPU Tweaks"

if not exist "%GPU_DIR%\" (
    echo [93m[SKIP][0m GPU Tweaks folder not found.
    exit /b
)

echo.
echo [95m[GPU TWEAKS][0m
echo ============================================================

if /i "%GPU_VENDOR%"=="nvidia" (
    call :LaunchMatchingGPU "nvidia"
    exit /b
)

if /i "%GPU_VENDOR%"=="amd" (
    call :LaunchMatchingGPU "amd"
    exit /b
)

if /i "%GPU_VENDOR%"=="intel" (
    call :LaunchMatchingGPU "intel"
    exit /b
)

echo [93m[SKIP][0m No supported GPU vendor detected.
exit /b


:LaunchMatchingGPU
set "MATCH=%~1"

for /r "%GPU_DIR%" %%B in (*.bat *.cmd) do (
    echo %%~nxB | findstr /i "%MATCH%" >nul
    if !errorlevel! equ 0 (
        call :LaunchBatch "%%~fB" "%%~nxB"
    )
)

exit /b


:LaunchBatch
set "BAT_PATH=%~1"
set "BAT_NAME=%~2"
set /a TOTAL+=1

echo [92mLaunching:[0m %BAT_NAME%

start "" /min cmd /c call "%BAT_PATH%" ^>nul 2^>^&1

exit /b


:ShowLaunched
for /f "tokens=1-4 delims=:., " %%a in ("%START_TIME%") do (
    set /a "START_MS=((1%%a%%100)*3600000)+((1%%b%%100)*60000)+((1%%c%%100)*1000)+(1%%d%%100)"
)

for /f "tokens=1-4 delims=:., " %%a in ("%time%") do (
    set /a "END_MS=((1%%a%%100)*3600000)+((1%%b%%100)*60000)+((1%%c%%100)*1000)+(1%%d%%100)"
)

set /a ELAPSED=END_MS-START_MS

if %ELAPSED% lss 0 (
    set /a ELAPSED+=86400000
)

set /a SECONDS=ELAPSED/1000
set /a MILLISECONDS=ELAPSED%%1000

cls
echo [95m============================================================[0m
echo [95m              67 SEC OPTIMIZATION PACK[0m
echo [95m                    BY TOX TWEAKS[0m
echo [95m============================================================[0m
echo.
echo [94m[STATUS][0m
echo All optimization batches have been launched successfully.
echo.
echo [93m[TWEAKS LAUNCHED][0m
echo %TOTAL% batch files started in the background.
echo.
echo [93m[LAUNCH TIME][0m
echo %SECONDS%.%MILLISECONDS%s
echo.
echo [91m[IMPORTANT][0m
echo Tweaks are applying silently in the background.
echo Do not restart your PC immediately.
echo Wait up to 67 seconds, then restart your PC to fully apply changes.
echo.
echo Press any key to exit...
exit /b
