@echo off
SETLOCAL EnableExtensions

REM This sets the location for the enemy (each enemy should be split up based on the planned stats)
color 70
cls
echo.
echo Names must only contain letters or underscores.
echo For instance, Crazed_Ninja or Turtle.
echo.
set /p enemyid=Name of enemy:
cls
echo.
echo Where is this enemy located?
echo Sewers (Level 1-5)
echo Town (Level 5-10)
echo Forest (Level 10-15)
echo Mountain (Level 15-20)
echo Castle (Level 20+)
echo.
set /p enemylocation=Location of Enemy: 
if exist C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%enemylocation% goto stats
mkdir C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%enemylocation%
goto stats

REM Sets the enemies stats, experience, drops, and the price of the drop, and outputs all the data
REM to the (mob)_data.dll files. Once outputted, a new file is created in the player directory, setting
REM the cost of the drops and setting the player's amount to 0.
:stats
echo.
echo Stats must be a number.
echo.
set /p hp=HP stat: 
set /p spd=SPD stat: 
set /p atk=ATK stat: 
set /p def=DEF stat: 
set /p xp=Experience Points: 
set /p drop=Drop: 
set /p dropworth=Price of drop: 
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%enemylocation%
set /p ExistingMobs=<mobID.txt
echo %ExistingMobs% %enemyid%>mobID.txt
timeout /t 1 /nobreak>NUL
echo HP= %hp% >%enemyid%_data.dll
echo SPD= %spd% >>%enemyid%_data.dll
echo ATK= %atk% >>%enemyid%_data.dll
echo DEF= %def% >>%enemyid%_data.dll
echo XP= %xp% >>%enemyid%_data.dll
echo DROP= %drop%>>%enemyid%_data.dll
set /p MobCount=<mobCount.txt
set /a NewMobCount=(%MobCount% + 1)
echo %NewMobCount% >mobCount.txt
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
echo Amount= 0 > %drop%.dll
echo Cost= %dropworth% >>%drop%.dll
pause
exit