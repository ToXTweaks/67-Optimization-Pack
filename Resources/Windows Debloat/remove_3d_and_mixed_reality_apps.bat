powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage -ErrorAction SilentlyContinue"
