Del /s /f /q %systemdrive%\*.old
Del /s /f /q %systemdrive%\*.chk
Del /f /s /q %systemdrive%\*.old
Del /f /s /q %systemdrive%\*.chk
Del /f /q /s %systemdrive%\*.old
Del /f /q /s %systemdrive%\*.chk
Del /s /f /q %systemdrive%\*._mp
Del /f /s /q %systemdrive%\*._mp
Del /f /q /s %systemdrive%\*.bak
Del /s /f /q %windir%\*.bak
Del /f /s /q %windir%\*.bak
Del /f /q /s %WinDir%\*.bak
del /f /q /s %WinDir%\Driver Cache\i386\*.*
Del /f /q /s %WinDir%\system32\dllcache\*.*
Del /f /q /s %WinDir%$hf_mig$\*.*
Del /f /q /s %WinDir%\Driver Cache\*.*
Del /f /q /s %WinDir%\addins\*.*
Del /f /q /s %WinDir%\LastGood\*.*
Del /f /q /s %WinDir%\Offline Web Pages\*.*
Del /f /q /s %WinDir%$NtServicePackUninstall$\*.*
Del /f /q /s %WinDir%\Provisioning\*.*
Del /f /q /s %WinDir%\ServicePackFiles\*.*
Del /f /q /s %WinDir%\Connection Wizard\*.*
Del /f /q /s %WinDir%\EHome\*.*
Del /f /q /s %WinDir%\Assembly\*.*
Del /f /q /s %WinDir%\SoftwareDistribution\Download\*.*
Del /f /q /s %WinDir%\mui\*.*
Del /f /q /s %WinDir%\Config\*.*
Del /f /q /s %WinDir%\msapps\*.*
del /s /f /q %winDir%\*.bak
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMDRIVE%\Windows.old'; ... )"^""
