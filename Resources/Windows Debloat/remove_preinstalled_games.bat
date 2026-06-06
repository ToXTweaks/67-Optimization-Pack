powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.MinecraftUWP* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage -ErrorAction SilentlyContinue"
