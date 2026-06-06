taskkill /F /IM Teams.exe >nul 2>&1
taskkill /F /IM msteams.exe >nul 2>&1
taskkill /F /IM msteams_autostarter.exe >nul 2>&1
taskkill /F /IM msteamsupdate.exe >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *MicrosoftTeams* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.GroupMe10* | Remove-AppxPackage -ErrorAction SilentlyContinue"
