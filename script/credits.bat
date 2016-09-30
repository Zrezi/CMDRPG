REM Simple batch that displays the "CHANGELOG.txt" file to the screen, showing the player the most recent
REM changes to the game.
@echo off
cd C:\Users\%USERNAME%\Desktop\CMDRPG
cls
echo.
type CHANGELOG.txt
echo.
echo.
echo To see earlier versions, open the file 'Changelog' in the main folder.
echo.
pause