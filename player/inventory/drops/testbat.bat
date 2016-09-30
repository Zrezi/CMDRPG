@echo off
forfiles /p "C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops" /m "*.dll" /c "cmd.exe /c echo @fname"
echo.
pause