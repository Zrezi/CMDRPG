REM Creates a new weapon, the code is self explanatory. This code acts just like the newMob.bat file.
@echo off
cd C:\Users\%USERNAME%\Desktop\CMDRPG\gear
color 70
setlocal enableextensions
cls
echo.
echo Names must be in '***'_'***' format.
echo For instance, Iron_Shortsword, or Wooden_Staff
echo.
set /p ask=Name of item: 
echo.
echo Stats must be a number between 1 and 15.
echo.
set /p hp=HP stat: 
set /p spd=SPD stat: 
set /p atk=ATK stat: 
set /p def=DEF stat: 
echo.
echo Type is 1 of 3 strings, 'wep' 'carmor' or 'larmor'
echo.
set /p type=Type: 
set /p cost=Cost: 
set /p mlvl=Minimum Level: 
echo.
echo Generating files...
echo HP= %hp% >%ask%.dll
echo SPD= %spd% >>%ask%.dll
echo ATK= %atk% >>%ask%.dll
echo DEF= %def% >>%ask%.dll
echo TYPE= %type% >>%ask%.dll
echo COST= %cost% >>%ask%.dll
echo MLVL= %mlvl% >>%ask%.dll
timeout /t 1 /nobreak>NUL
exit