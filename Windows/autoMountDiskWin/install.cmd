icacls "D:\mountDisk" /grant %USERNAME%:(OI)(CI)F /T
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
D:
copy "D:\mountDisk\mount.cmd" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
C:
cd C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
icacls "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" /grant Everyone:(OI)(CI)F /T
icacls "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" /grant Users:(OI)(CI)F /T
icacls "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" /grant %USERNAME%:(OI)(CI)F /T
mount.cmd