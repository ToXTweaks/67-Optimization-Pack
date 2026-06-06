for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" ^| findstr "Interfaces"') do (
reg add "%%i" /v "TCPNoDelay" /t REG_DWORD /d 1 /f
)
