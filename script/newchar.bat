REM Self explanatory, gives the player the option to choose his/her name. Outputs the data to a newly created
REM playerData.dll file, in which most of the player data will be held.
:ChooseCharacterName
@echo off
setlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
cls
echo.
type intro.txt
echo.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /p playerName=What is your name? 
echo playerName= %playerName%>>playerData.dll
goto ChooseCharacterRace

REM The code is similar to the name, but it sets the player's race and thus determines the player's starting
REM equipment and the player's stats.
:ChooseCharacterRace
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
cls
echo.
type chooserace.txt
echo.
echo.
echo There are three different races to choose from.
echo The mighty 'Orc', the intelligent 'Human', and the quick 'Elf'.
echo The race you choose affects every aspect of your character.
echo Choose wisely.
echo.
set /p playerRace=What race do you choose? 
if '%playerRace%'=='Orc' goto playerRaceOrc
if '%playerRace%'=='Human' goto playerRaceHuman
if '%playerRace%'=='Elf' goto playerRaceElf
echo.
echo That is not one of the available races to choose from. Please try again.
echo.
pause
goto ChooseCharacterRace

REM The following playerRace(YourRaceHere) labels set the player's stats and starting equipment and outputs
REM the data to the player's variables.
:playerRaceOrc
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type generatingfiles.txt
echo.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set playerHP=500
set playerATK=100
set playerDEF=140
set playerSPD=100
set playerWeapon=Iron_Axe
set playerArmor_Chest=Steel_Breastplate
set playerArmor_Leg=Steel_Leggings
ping 1.1.1.1 -n 1 -w 500 > nul
goto SetFinalInformation

:playerRaceHuman
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type generatingfiles.txt
echo.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set playerHP=450
set playerATK=80
set playerDEF=200
set playerSPD=150
set playerWeapon=Iron_Sword
set playerArmor_Chest=Leather_Tunic
set playerArmor_Leg=Leather_Pants
ping 1.1.1.1 -n 1 -w 500 > nul
goto SetFinalInformation

:playerRaceElf
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type generatingfiles.txt
echo.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set playerHP=400
set playerATK=120
set playerDEF=80
set playerSPD=200
set playerWeapon=Wooden_Bow
set playerArmor_Chest=Cloth_Tunic
set playerArmor_Leg=Cloth_Pants
ping 1.1.1.1 -n 1 -w 500 > nul
goto SetFinalInformation

REM After all race-specific data has been output to the variables, this label is called, and outputs
REM all of the player's variables to the playerData.dll file. Once data is output, recalls the file
REM launcher.bat and instead of coming to this batch file the launcher command instead goes to the
REM startup.bat file.
:SetFinalInformation
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
echo playerRace= %playerRace%>>playerData.dll
echo playerHP= %playerHP%>>playerData.dll
echo playerSPD= %playerSPD%>>playerData.dll
echo playerATK= %playerATK%>>playerData.dll
echo playerDEF= %playerDEF%>>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest%>>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg%>>playerData.dll
echo playerWeapon= %playerWeapon%>>playerData.dll
echo playerLevel= 1 >>playerData.dll
echo playerExp= 0 >>playerData.dll
echo playerMoney= 0 >>playerData.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo 0 >money.dll
echo 0 >potionCount.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost
echo 0 >boostHP.dll
echo 0 >boostSPD.dll
echo 0 >boostATK.dll
echo 0 >boostDEF.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo.
if %playerRace%==Orc echo You chose to become an orc.
if %playerRace%==Elf echo You chose to become an elf.
if %playerRace%==Human echo You chose to become a human.
echo Your journey awaits...
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\
pause
call launcher

