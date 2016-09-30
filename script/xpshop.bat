REM Main menu for the experience shop.
:MainShopMenu
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
setlocal EnableDelayedExpansion
for /f "tokens=2" %%G IN (playerData.dll) DO if not defined playerName set "playerName=%%G"
for /f "skip=1 tokens=2" %%G IN (playerData.dll) DO if not defined playerRace set "playerRace=%%G"
for /f "skip=2 tokens=2" %%G IN (playerData.dll) DO if not defined ppHP set "ppHP=%%G"
for /f "skip=3 tokens=2" %%G IN (playerData.dll) DO if not defined ppSPD set "ppSPD=%%G"
for /f "skip=4 tokens=2" %%G IN (playerData.dll) DO if not defined ppATK set "ppATK=%%G"
for /f "skip=5 tokens=2" %%G IN (playerData.dll) DO if not defined ppDEF set "ppDEF=%%G"
for /f "skip=6 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Chest set "playerArmor_Chest=%%G"
for /f "skip=7 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Leg set "playerArmor_Leg=%%G"
for /f "skip=8 tokens=2" %%G IN (playerData.dll) DO if not defined playerWeapon set "playerWeapon=%%G"
for /f "skip=9 tokens=2" %%G IN (playerData.dll) DO if not defined playerLevel set "playerLevel=%%G"
for /f "skip=10 tokens=2" %%G IN (playerData.dll) DO if not defined playerExp set "playerExp=%%G"
for /f "skip=11 tokens=2" %%G IN (playerData.dll) DO if not defined playerMoney set "playerMoney=%%G"
set /a xpNeeded=(%playerLevel%*150)
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type xpshop.txt
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
echo.
echo Welcome to the experience shop.
echo You have %playerExp% experience points to spend.
echo.
echo 1. Level Up (%xpNeeded% points)
echo 2. Boost Menu
echo 3. Exit
echo.
set /p ShopMenu=What item would you like to buy? 
if '%ShopMenu%'=='1' goto LevelUp
if '%ShopMenu%'=='2' goto BoostMenu
if '%ShopMenu%'=='3' (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup
)
if not '%ShopMenu%'=='' (
echo You entered an incorrect answer, please try again.
goto MainShopMenu
)

REM Checks the player's level and if it is at the max (20) it will end. If that is not the case, it then checks
REM the player's experience points to make sure that the player has accumulated enough points to level up.
:LevelUp
if %playerLevel% GEQ 20 (
echo.
echo You are already max level!
echo.
pause
cls
goto MainShopMenu
)
if %playerExp% LSS %xpNeeded% (
echo.
echo You do not have enough experience points.
echo.
pause
goto MainShopMenu
)
set /a transactionLevelUpexp=(%playerExp% - %xpNeeded%)
set /a transactionplayerLevel=(%playerLevel% + 1)
goto ChangeStats

REM Assuming the player is not max level and has enough experience points.
:ChangeStats
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
cls
echo.
echo Congratulations, you leveled up.
echo You are now level %transactionplayerLevel%.
echo.
set /a LeveledUpPlayerHP=(%ppHP%* 12) / (10)
set /a LeveledUpPlayerSPD=(%ppSPD%* 12) / (10)
set /a LeveledUpPlayerATK=(%ppATK%* 12) / (10)
set /a LeveledUpPlayerDEF=(%ppDEF%* 12) / (10)
set /a GainedHP=(%LeveledUpPlayerHP% - %ppHP%)
set /a GainedSPD=(%LeveledUpPlayerSPD% - %ppSPD%)
set /a GainedATK=(%LeveledUpPlayerATK% - %ppATK%)
set /a GainedDEF=(%LeveledUpPlayerDEF% - %ppDEF%)
REM Outputting new data to the playerData.dll file.
echo Updating stats...
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %LeveledUpPlayerHP% >>playerData.dll
echo playerSPD= %LeveledUpPlayerSPD% >>playerData.dll
echo playerATK= %LeveledUpPlayerATK% >>playerData.dll
echo playerDEF= %LeveledUpPlayerDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
echo playerLevel= %transactionplayerLevel% >>playerData.dll
echo playerExp= %transactionLevelUpexp% >>playerData.dll
echo playerMoney= %playerMoney% >>playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo.
echo You gained %GainedHP% health.
echo You gained %GainedSPD% speed.
echo You gained %GainedATK% attack.
echo You gained %GainedDEF% defense.
echo.
pause
endlocal 
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

REM The boost menu, containing all the boosts in a list menu.
:BoostMenu
set /p exp=<exp.dll
cls
echo.
echo This is the boost menu.
echo You have %exp%experience points.
echo.
echo 1. Boost HP
echo 2. Boost SPD
echo 3. Boost ATK
echo 4. Boost DEF
echo 5. Boost Help
echo 6. Exit
echo.
set /p Boost--Menu=What do you want to do? 
if '%Boost--Menu%'=='1' goto BoostHP
if '%Boost--Menu%'=='2' goto BoostSPD
if '%Boost--Menu%'=='3' goto BoostATK
if '%Boost--Menu%'=='4' goto BoostDEF
if '%Boost--Menu%'=='5' goto BoostHelp
if '%Boost--Menu%'=='6' (
endlocal
goto MainShopMenu
)
if not '%Boost--Menu%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto MainShopMenu
)

REM The following boost code (for each stat) checks that the player has enough experience points to buy
REM the boost. Assuming that they do, the code jumps to Boost(stat)Success and reduces the player's XP
REM by the cost of boost. The stats are increased and it returns to the boost menu.

:BoostHP
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
set /p NumberOfHPBoost=<boostHP.dll
set /a BoostHPCost=((%NumberOfHPBoost% * 250) + 250)
cls
echo.
echo A Health boost requires %BoostHPCost% experience points.
echo.
echo 1. Buy HP boost
echo 2. Exit
echo.
set /p ConfirmHPBoost=What do you want to do? 
if '%ConfirmHPBoost%'=='1' goto BoostHPSuccess
if '%ConfirmHPBoost%'=='2' (
endlocal
goto BoostMenu
)
if not '%ConfirmHPBoost%'=='' goto BoostIncorrectAnswer

:BoostHPSuccess
if %exp% LSS %BoostHPCost% goto NEEboost
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a SpentXP=(%exp% - %BoostHPCost%)
echo %SpentXP% >exp.dll
set /a LeveledUpPlayerHP=(%ppHP% * 105 / 100)
set /a GainedHP=(%LeveledUpPlayerHP% - %ppHP%)
set /a NewBoostAmount=(%NumberOfHPBoost% + 1)
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %LeveledUpPlayerHP% >>playerData.dll
echo playerSPD= %ppSPD% >>playerData.dll
echo playerATK= %ppATK% >>playerData.dll
echo playerDEF= %ppDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
echo %NewBoostAmount% >boostHP.dll
echo.
echo You have gained %GainedHP% health with the boost.
echo.
pause
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

:BoostSPD
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
set /p NumberOfSPDBoost=<boostSPD.dll
set /a BoostSPDCost=((%NumberOfSPDBoost% * 250) + 250)
cls
echo.
echo A Speed boost requires %BoostSPDCost% experience points.
echo.
echo 1. Buy SPD boost
echo 2. Exit
echo.
set /p ConfirmSPDBoost=What do you want to do? 
if '%ConfirmSPDBoost%'=='1' goto BoostSPDSuccess
if '%ConfirmSPDBoost%'=='2' (
endlocal
goto BoostMenu
)
if not '%ConfirmSPDBoost%'=='' goto BoostIncorrectAnswer

:BoostSPDSuccess
if %exp% LSS %BoostSPDCost% goto NEEboost
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a SpentXP=(%exp% - %BoostSPDCost%)
echo %SpentXP% >exp.dll
set /a LeveledUpPlayerSPD=(%ppSPD% * 105 / 100)
set /a GainedSPD=(%LeveledUpPlayerSPD% - %ppSPD%)
set /a NewBoostAmount=(%NumberOfSPDBoost% + 1)
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %ppHP% >>playerData.dll
echo playerSPD= %LeveledUpPlayerSPD% >>playerData.dll
echo playerATK= %ppATK% >>playerData.dll
echo playerDEF= %ppDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
echo %NewBoostAmount% >boostSPD.dll
echo.
echo You have gained %GainedSPD% speed with the boost.
echo.
pause
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

:BoostATK
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
set /p NumberOfATKBoost=<boostATK.dll
set /a BoostATKCost=((%NumberOfATKBoost% * 250) + 250)
cls
echo.
echo An Attack boost requires %BoostATKCost% experience points.
echo.
echo 1. Buy ATK boost
echo 2. Exit
echo.
set /p ConfirmATKBoost=What do you want to do? 
if '%ConfirmATKBoost%'=='1' goto BoostATKSuccess
if '%ConfirmATKBoost%'=='2' (
endlocal
goto BoostMenu
)
if not '%ConfirmATKBoost%'=='' goto BoostIncorrectAnswer

:BoostATKSuccess
if %exp% LSS %BoostATKCost% goto NEEboost
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a SpentXP=(%exp% - %BoostATKCost%)
echo %SpentXP% >exp.dll
set /a LeveledUpPlayerATK=(%ppATK% * 105 / 100)
set /a GainedATK=(%LeveledUpPlayerATK% - %ppATK%)
set /a NewBoostAmount=(%NumberOfATKBoost% + 1)
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %ppHP% >>playerData.dll
echo playerSPD= %ppSPD% >>playerData.dll
echo playerATK= %LeveledUpPlayerATK% >>playerData.dll
echo playerDEF= %ppDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
echo %NewBoostAmount% >boostATK.dll
echo.
echo You have gained %GainedATK% attack with the boost.
echo.
pause
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

:BoostDEF
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
set /p NumberOfDEFBoost=<boostDEF.dll
set /a BoostDEFCost=((%NumberOfDEFBoost% * 250) + 250)
cls
echo.
echo A Defense boost requires %BoostDEFCost% experience points.
echo.
echo 1. Buy DEF boost
echo 2. Exit
echo.
set /p ConfirmDEFBoost=What do you want to do? 
if '%ConfirmDEFBoost%'=='1' goto BoostDEFSuccess
if '%ConfirmDEFBoost%'=='2' (
endlocal
goto BoostMenu
)
if not '%ConfirmDEFBoost%'=='' goto BoostIncorrectAnswer

:BoostDEFSuccess
if %exp% LSS %BoostDEFCost% goto NEEboost
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a SpentXP=(%exp% - %BoostDEFCost%)
echo %SpentXP% >exp.dll
set /a LeveledUpPlayerDEF=(%ppDEF% * 105 / 100)
set /a GainedDEF=(%LeveledUpPlayerDEF% - %ppDEF%)
set /a NewBoostAmount=(%NumberOfDEFBoost% + 1)
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %ppHP% >>playerData.dll
echo playerSPD= %ppSPD% >>playerData.dll
echo playerATK= %ppATK% >>playerData.dll
echo playerDEF= %LeveledUpPlayerDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
echo %NewBoostAmount% >boostDEF.dll
echo.
echo You have gained %GainedDEF% defense with the boost.
echo.
pause
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

REM Called if the player does not have enough experience points.
:NEEboost
cls
echo.
echo You do not have enough experience points.
echo.
pause
goto BoostMenu

REM The incorrect answer code, same as every other.
:BoostIncorrectAnswer
echo.
echo You have entered an incorrect answer.
echo.
pause
goto BoostMenu

REM The boost help menu. Explains a little bit about how boosts work and how they affect the character.
:BoostHelp
cls
echo.
echo Boosts are stat specific upgrades that you can buy to upgrade your
echo character's stats beyond that of the level 20 cap.
echo.
echo Boosts have unlimited uses, but become more and more expensize to use.
echo This behavior is stat specific. For example if I use a HP boost ten times, the
echo cost of my first SPD boost will still be that of my first HP boost.
echo.
echo Boosts enchance a stat by increasing it by 5%% each time. For reference, each
echo time you level up your stats are enchanced by 20%%.
echo.
echo Boosts are more effective the higher your base stats are, so buying a bunch of
echo boosts at level 1 will be nowhere near as effective as buying them at level 20.
echo.
pause
goto BoostMenu