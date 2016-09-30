REM Resets all player variables to nothing (had to do this in order for the level-up and boost system to work properly).
:SetNameAndRace
setlocal EnableDelayedExpansion
set playerName=
set playerRace=
set preliminaryplayerHP=
set preliminaryplayerSPD=
set preliminaryplayerATK=
set preliminaryplayerDEF=
set playerArmor_Chest=
set playerArmor_Leg=
set playerWeapon=
set playerLevel=
set playerExp=
set playerMoney=
set preliminaryLegArmorHP=
set preliminaryLegArmorSPD=
set preliminaryLegArmorATK=
set preliminaryLegArmorDEF=
set preliminaryChestArmorHP=
set preliminaryChestArmorSPD=
set preliminaryChestArmorATK=
set preliminaryChestArmorDEF=
set preliminaryWeaponHP=
set preliminaryWeaponSPD=
set preliminaryWeaponATK=
set preliminaryWeaponDEF=
set ComputerUsername=%USERNAME%
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
for /f "tokens=2" %%G IN (playerData.dll) DO if not defined playerName set "playerName=%%G"
for /f "skip=1 tokens=2" %%G IN (playerData.dll) DO if not defined playerRace set "playerRace=%%G"
for /f "skip=6 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Chest set "playerArmor_Chest=%%G"
for /f "skip=7 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Leg set "playerArmor_Leg=%%G"
for /f "skip=8 tokens=2" %%G IN (playerData.dll) DO if not defined playerWeapon set "playerWeapon=%%G"
for /f "skip=9 tokens=2" %%G IN (playerData.dll) DO if not defined playerLevel set "playerLevel=%%G"
for /f "skip=10 tokens=2" %%G IN (playerData.dll) DO if not defined playerExp set "playerExp=%%G"
for /f "skip=11 tokens=2" %%G IN (playerData.dll) DO if not defined playerMoney set "playerMoney=%%G"
goto PrelimValues

REM Reads the playerData.dll file to load in the player's information and stats.
:PrelimValues
REM Player base stats.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
for /f "skip=2 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerHP set "preliminaryplayerHP=%%G"
for /f "skip=3 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerSPD set "preliminaryplayerSPD=%%G"
for /f "skip=4 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerATK set "preliminaryplayerATK=%%G"
for /f "skip=5 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerDEF set "preliminaryplayerDEF=%%G"
cd C:\Users\%USERNAME%\Desktop\CMDRPG\gear
REM Leg armor stats.
for /f "tokens=2" %%G IN (%playerArmor_Leg%.dll) DO if not defined preliminaryLegArmorHP set "preliminaryLegArmorHP=%%G"
for /f "skip=1 tokens=2" %%G IN (%playerArmor_Leg%.dll) DO if not defined preliminaryLegArmorSPD set "preliminaryLegArmorSPD=%%G"
for /f "skip=2 tokens=2" %%G IN (%playerArmor_Leg%.dll) DO if not defined preliminaryLegArmorATK set "preliminaryLegArmorATK=%%G"
for /f "skip=3 tokens=2" %%G IN (%playerArmor_Leg%.dll) DO if not defined preliminaryLegArmorDEF set "preliminaryLegArmorDEF=%%G"
REM Chest armor stats.
for /f "tokens=2" %%G IN (%playerArmor_Chest%.dll) DO if not defined preliminaryChestArmorHP set "preliminaryChestArmorHP=%%G"
for /f "skip=1 tokens=2" %%G IN (%playerArmor_Chest%.dll) DO if not defined preliminaryChestArmorSPD set "preliminaryChestArmorSPD=%%G"
for /f "skip=2 tokens=2" %%G IN (%playerArmor_Chest%.dll) DO if not defined preliminaryChestArmorATK set "preliminaryChestArmorATK=%%G"
for /f "skip=3 tokens=2" %%G IN (%playerArmor_Chest%.dll) DO if not defined preliminaryChestArmorDEF set "preliminaryChestArmorDEF=%%G"
REM Weapon stats.
for /f "tokens=2" %%G IN (%playerWeapon%.dll) DO if not defined preliminaryWeaponHP set "preliminaryWeaponHP=%%G"
for /f "skip=1 tokens=2" %%G IN (%playerWeapon%.dll) DO if not defined preliminaryWeaponSPD set "preliminaryWeaponSPD=%%G"
for /f "skip=2 tokens=2" %%G IN (%playerWeapon%.dll) DO if not defined preliminaryWeaponATK set "preliminaryWeaponATK=%%G"
for /f "skip=3 tokens=2" %%G IN (%playerWeapon%.dll) DO if not defined preliminaryWeaponDEF set "preliminaryWeaponDEF=%%G"
goto SetValues

REM Adds the player's base stats to the stats of the gear. Combines values to come up with the total health, speed, attack, and defense.
:SetValues
set /a playerHP=(%preliminaryplayerHP% + %preliminaryLegArmorHP% + %preliminaryChestArmorHP% + %preliminaryWeaponHP%)
set /a playerSPD=(%preliminaryplayerSPD% + %preliminaryLegArmorSPD% + %preliminaryChestArmorSPD% + %preliminaryWeaponSPD%)
set /a playerATK=(%preliminaryplayerATK% + %preliminaryLegArmorATK% + %preliminaryChestArmorATK% + %preliminaryWeaponATK%)
set /a playerDEF=(%preliminaryplayerDEF% + %preliminaryLegArmorDEF% + %preliminaryChestArmorDEF% + %preliminaryWeaponDEF%)
goto MainMenu

REM The main menu when the game is first initiated.
:MainMenu
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type mainmenu.txt
echo.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
echo.
echo Name: %playerName%
echo Race: %playerRace%
echo.
echo 1. Fight
echo 2. Inventory
echo 3. Shop
echo 4. Character Information
echo 5. Credits
echo 6. Mini Games
echo 7. Exit
echo.
set /p Main--Menu=What would you like to do? 
if '%Main--Menu%'=='1' goto GoFight
if '%Main--Menu%'=='2' goto GoInventory
if '%Main--Menu%'=='3' goto GoShop
if '%Main--Menu%'=='4' goto playerInformation
if '%Main--Menu%'=='5' (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call credits
goto MainMenu
)
if '%Main--Menu%'=='6' goto GoMiniGames
if '%Main--Menu%'=='7' goto Exit
if not '%Main--Menu%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto MainMenu
)

REM The player information screen, shows stats and your gear.
:playerInformation
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type characterinfo.txt
echo.
echo.
echo -------------------------------------
echo Name: 		%playerName%
echo Race: 		%playerRace%
echo HP: 		%playerHP%
echo SPD: 		%playerSPD%
echo ATK: 		%playerATK%
echo DEF: 		%playerDEF%
echo Weapon: 	%playerWeapon%
echo Chest Armor: 	%playerArmor_Chest%
echo Leg Armor: 	%playerArmor_Leg%
echo -------------------------------------
echo Level: 		%playerLevel%
echo Money: 		%playerMoney%$
echo Experience: 	%playerExp% points
echo -------------------------------------
echo.
pause
goto MainMenu

REM This is the shop menu, you can choose to go to either the money shop or the experience shop from this menu.
:GoShop
endlocal
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type chooseshop.txt
echo.
echo.
echo 1. Money Shop
echo 2. Experience Shop
echo 3. Exit
echo.
set /p ShopChoose=Which shop do you want to visit?
if '%ShopChoose%'=='1' (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call moneyshop
goto SetNameAndRace
)
if '%ShopChoose%'=='2' (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call xpshop
goto SetNameAndRace
)
if '%ShopChoose%'=='3' (
endlocal
goto SetNameAndRace
)
if not '%ShopChoose%'=='' (
echo.
echo You have entered an incorrect answer, please try again.
echo.
pause
goto GoShop
)

REM Starts the "fight" script.
:GoFight
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call fightnpc
endlocal
goto SetNameAndRace

REM Opens the Mini Game menu.
:GoMiniGames
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call minigame
endlocal
goto SetNameAndRace

REM Closes CMDRPG, also deleting any left over temporary files in case some were left.
:Exit
echo.
del "C:\Users\%USERNAME%\Desktop\CMDRPG\temporary\*.dll"
echo.
echo Closing Command RPG...
timeout /t 2 /nobreak>NUL
exit

REM Takes you to the inventory viewer.
:GoInventory
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call invviewer
endlocal
goto SetNameAndRace
