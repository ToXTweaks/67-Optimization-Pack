for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f NetbiosOptions ^| find /i "Interfaces\"') do (
Reg.exe add "%%i" /v "NetbiosOptions" /t REG_DWORD /d 2 /f
)
