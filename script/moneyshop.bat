REM Start of the Money Shop code. Sets the player's money equal to the value contained in the
REM money.dll file located in the player/inventory directory.
:MainShopMenu
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
for /f "tokens=2" %%G IN (playerData.dll) DO if not defined playerName set "playerName=%%G"
for /f "skip=1 tokens=2" %%G IN (playerData.dll) DO if not defined playerRace set "playerRace=%%G"
for /f "skip=2 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerHP set "preliminaryplayerHP=%%G"
for /f "skip=3 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerSPD set "preliminaryplayerSPD=%%G"
for /f "skip=4 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerATK set "preliminaryplayerATK=%%G"
for /f "skip=5 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerDEF set "preliminaryplayerDEF=%%G"
for /f "skip=6 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Chest set "playerArmor_Chest=%%G"
for /f "skip=7 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Leg set "playerArmor_Leg=%%G"
for /f "skip=8 tokens=2" %%G IN (playerData.dll) DO if not defined playerWeapon set "playerWeapon=%%G"
for /f "skip=9 tokens=2" %%G IN (playerData.dll) DO if not defined playerLevel set "playerLevel=%%G"
for /f "skip=10 tokens=2" %%G IN (playerData.dll) DO if not defined playerExp set "playerExp=%%G"
for /f "skip=11 tokens=2" %%G IN (playerData.dll) DO if not defined playerMoney set "playerMoney=%%G"
setlocal

REM Main menu when you enter the shop.
:ShopStart
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type moneyshop.txt
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo.
echo Welcome to the shop.
echo You have %playerMoney%$ to spend.
echo.
echo 1. Buy Items
echo 2. Sell Items
echo 3. Buy Gear
echo 4. Exit
echo.
set /p ShopMenu=What item would you like to buy? 
if '%ShopMenu%'=='1' goto BuyItemList
if '%ShopMenu%'=='2' goto SellItemList
if '%ShopMenu%'=='3' goto BuyGearMenu
if '%ShopMenu%'=='4' (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup
)
if not '%ShopMenu%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto ShopStart
)

REM The buy item list. 
:BuyItemList
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /p potionCount=<potionCount.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
for /f "skip=11 tokens=2" %%G IN (playerData.dll) DO set "playerMoney=%%G"
cls
echo.
echo You have %playerMoney%$.
echo.
echo Item #		Item:		$$$:		Qnty:
echo -----------------------------------------------------------
echo 1.		Potion		100 $		%potionCount%
echo.
echo 9 - Return to shop.
echo.
set /p BuyItemMenu=What would you like to buy? 
if '%BuyItemMenu%'=='1' goto BuyPotion
if '%BuyItemMenu%'=='9' goto ShopStart
if not '%BuyItemMenu%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto BuyItemList
)

REM Checks the player's money and compares it to 100. If it is less it will output that the player doesn't
REM have enough money to buy a potion. If it is at least 100, then the player will "gain" a potion. All
REM data is output to the respective files (potionCount.dll and money.dll).
:BuyPotion
if %playerMoney% LSS 100 (
echo.
echo You do not have enough money.
echo.
pause
goto BuyItemList
)
set /a transactionPotionMoney=(%playerMoney% - 100)
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
echo playerName= %playerName% >playerData.dll
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %preliminaryplayerHP% >>playerData.dll
echo playerSPD= %preliminaryplayerSPD% >>playerData.dll
echo playerATK= %preliminaryplayerATK% >>playerData.dll
echo playerDEF= %preliminaryplayerDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
echo playerLevel= %playerLevel% >>playerData.dll
echo playerExp= %playerExp% >>playerData.dll
echo playerMoney= %transactionPotionMoney% >>playerData.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /a transactionPotionCount=(%potionCount% + 1)
echo %transactionPotionCount% >potionCount.dll
goto BuyItemList

REM Allows the player to sell an item dropped from monsters. Each item has a different value and must be searched
REM for in order to sell the item. You can sell as many as you want at once.
:SellItemList
setlocal
cls
echo.
echo In order to sell items, you must first search for them!
echo Press '1' to list all items.
echo Press '2' to exit.
echo.
set /p SearchItem=Search: 
if %SearchItem%==1 goto ListItems
if %SearchItem%==2 (
endlocal
goto MainShopMenu
)
if exist "C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops\%SearchItem%.dll" (
goto SellingItem
) else (
echo.
echo That item doesn't exist! Try again!
pause
endlocal
goto SellItemList
)

REM This part lists every item in the game, so that you can search for them. It does not display the player's
REM amounts for each item. In order to know that the item must be searched for.
:ListItems
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
forfiles /p "C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops" /m "*.dll" /c "cmd.exe /c echo @fname"
echo.
pause
goto SellItemList

REM Once you search this menu comes up, and allows you to either sell the item(s) or search again for
REM a different item. This code displays the player's amount and the item's cost.
:SellingItem
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
for /f "tokens=2" %%G IN (%SearchItem%.dll) DO if not defined itemAmount set "itemAmount=%%G"
for /f "skip=1 tokens=2" %%G IN (%SearchItem%.dll) DO if not defined itemCost set "itemCost=%%G"
cls
echo. 
echo Your search provided this item: %SearchItem%
echo.
echo Amount: %itemAmount%
echo Cost: %itemCost%
echo.
echo 1. Sell Item
echo 2. Search again
echo.
set /p SellItemQuestion=What do you want to do? 
if '%SellItemQuestion%'=='1' goto SellItemConfirmed1
if '%SellItemQuestion%'=='2' (
endlocal
goto SellItemList
)
echo.
echo You entered an incorrect answer.
echo.
pause
goto SellingItem

REM Once you select to sell the item, this code asks the player how much he/she wants to sell at this time.
REM You CAN sell 0, and nothing happens. The code multiplies the cost of the item by the amount that you
REM want to sell. The money is added to the current value in the money.dll file.
:SellItemConfirmed1
cls
echo.
echo You can sell as many as you would like.
echo.
set /p sellAmount=How many do you want to sell? 
if %sellAmount% GTR %itemAmount% (
echo.
echo You don't have that many.
echo.
pause
goto SellItemConfirmed1
)
set /a newitemAmount=%itemAmount%-%sellAmount%
set /a totalitemCost=%sellAmount%*%itemCost%
set /a newMoney=%money%+%totalitemCost%
echo.
if %sellAmount%==0 (
echo You didn't sell any.
echo.
pause
endlocal
goto SellItemList
)
if %sellAmount%==1 echo You sold a %SearchItem% for %itemCost% $.
if %sellAmount% GTR 1 echo You sold %sellAmount% %SearchItem%s for %totalitemCost% $.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo %newMoney% >money.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
echo Amount= %newitemAmount% >%SearchItem%.dll
echo Cost= %itemCost% >>%SearchItem%.dll
echo.
pause
endlocal
goto SellItemList

REM When the buy gear option is selected, it resets all the player's stat values. Also it displays the 
REM current gear that the player has equipped. Since gear is level-specific, it also displays the player's
REM current level and the player's money.
:BuyGearMenu
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
ping 1.1.1.1 -n 1 -w 500 > nul
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
for /f "tokens=2" %%G IN (playerData.dll) DO if not defined playerName set "playerName=%%G"
for /f "skip=1 tokens=2" %%G IN (playerData.dll) DO if not defined playerRace set "playerRace=%%G"
for /f "skip=2 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerHP set "preliminaryplayerHP=%%G"
for /f "skip=3 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerSPD set "preliminaryplayerSPD=%%G"
for /f "skip=4 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerATK set "preliminaryplayerATK=%%G"
for /f "skip=5 tokens=2" %%G IN (playerData.dll) DO if not defined preliminaryplayerDEF set "preliminaryplayerDEF=%%G"
for /f "skip=6 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Chest set "playerArmor_Chest=%%G"
for /f "skip=7 tokens=2" %%G IN (playerData.dll) DO if not defined playerArmor_Leg set "playerArmor_Leg=%%G"
for /f "skip=8 tokens=2" %%G IN (playerData.dll) DO if not defined playerWeapon set "playerWeapon=%%G"
for /f "skip=9 tokens=2" %%G IN (playerData.dll) DO if not defined playerLevel set "playerLevel=%%G"
for /f "skip=10 tokens=2" %%G IN (playerData.dll) DO if not defined playerExp set "playerExp=%%G"
for /f "skip=11 tokens=2" %%G IN (playerData.dll) DO if not defined playerMoney set "playerMoney=%%G"
cls
echo.
echo Weapon: 	%playerWeapon%
echo Chest Armor: 	%playerArmor_Chest%
echo Leg Armor: 	%playerArmor_Leg%
echo.
echo Money:	%playerMoney%$
echo Level:	%playerLevel%
echo.
echo 1. List gear
echo 2. Purchase gear
echo 3. Sets
echo 4. Exit
echo.
set /p GearMenu=What would you like to buy? 
if '%GearMenu%'=='1' (
echo.
forfiles /p "C:\Users\%USERNAME%\Desktop\CMDRPG\gear" /m "*.dll" /c "cmd.exe /c echo @fname"
echo.
pause
goto BuyGearMenu
)
if '%GearMenu%'=='2' goto BuyGearList
if '%GearMenu%'=='3' goto GearSets
if '%GearMenu%'=='4' goto ShopStart
if not '%GearMenu%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto BuyGearMenu
)

REM Sets are going to be something I will add later on in development.
:GearSets
cls
echo.
echo ... Sets will be added later on in development ...
echo.
pause
goto BuyGearMenu

REM 
:BuyGearList
cls
echo.
echo Here you can purchase gear for your character. In order to purchase 
echo an item, you must first search for it using the name displayed in the 
echo 'List Gear' section. Names must be typed exactly as they appear.
echo When items are bought, they are automatically set as your active
echo gear. The lost items are non-refundable and the action is irreversible.
echo Type '1' to return.
echo.
set /p SearchGear=Search: 
if %SearchGear%==1 goto ReturnFromSearch
if exist "C:\Users\%USERNAME%\Desktop\CMDRPG\gear\%SearchGear%.dll" (
goto intergect
) else (
goto NoExist
)

:ReturnFromSearch
endlocal
goto BuyGearMenu

REM Displays the gear that you searched for and also displays the gear's stats.
:intergect
cd C:\Users\%USERNAME%\Desktop\CMDRPG\gear
for /f "tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearHP set "gearHP=%%G"
for /f "skip=1 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearSPD set "gearSPD=%%G"
for /f "skip=2 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearATK set "gearATK=%%G"
for /f "skip=3 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearDEF set "gearDEF=%%G"
for /f "skip=4 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearTYPE set "gearTYPE=%%G"
for /f "skip=5 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearCOST set "gearCOST=%%G"
for /f "skip=6 tokens=2" %%G IN (%SearchGear%.dll) DO if not defined gearMLVL set "gearMLVL=%%G"
cls
echo.
echo Your search provided this item: %SearchGear%
echo.
if %gearTYPE%==wep echo Gear type: Weapon
if %gearTYPE%==carmor echo Gear type: Chest Armor
if %gearTYPE%==larmor echo Gear type: Leg Armor
echo HP: %gearHP%
echo SPD: %gearSPD%
echo ATK: %gearATK%
echo DEF: %gearDEF%
echo Minimum Level: %gearMLVL%
echo.
echo %SearchGear% costs %gearCOST%$.
echo.
echo 1. Buy Item
echo 2. Search again.
echo 3. Exit
echo.
set /p GearListQuestion=What do you want to do? 
if '%GearListQuestion%'=='1' goto CheckMoney
if '%GearListQuestion%'=='2' (
endlocal
goto BuyGearList
)
if '%GearListQuestion%'=='3' (
endlocal
goto BuyGearMenu
)
if not '%GearListQuestion%'=='' (
echo.
echo You entered an incorrect answer, please try again.
echo.
pause
goto intergect
)

REM Called upon when the search doesn't return a piece of gear.
:NoExist
echo.
echo That piece of gear doesn't exist. Try again.
echo.
pause
goto BuyGearList

REM Makes sure that the player has enough money to purchase the piece of gear.
:CheckMoney
if %playerMoney% GEQ %gearCOST% goto CheckLevel
cls
echo.
echo You do not have enough money.
echo.
pause
endlocal
goto CheckLevel

REM Makes sure that the player is high enough level purchase the piece of gear.
:CheckLevel
if %playerLevel% GEQ %gearMLVL% goto SetGearDataOverall
cls
echo.
echo You are not high enough level to use that item yet.
echo.
pause
endlocal
goto BuyGearList

REM Determines what type of gear you purchased, whether it be chest armor, leg armor, or a weapon.
REM Goes to the next section that outputs all the data to the player's files, in the correct file.
:SetGearDataOverall
echo.
echo Updating stats...
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /a NewMoney=(%playerMoney% - %gearCOST%)
ping 1.1.1.1 -n 1 -w 500 > nul
if %gearTYPE%==wep (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
goto SetGearWep
)
if %gearTYPE%==carmor (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
goto SetGearCarmor
)
if %gearTYPE%==larmor (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
goto SetGearLarmor
)

REM Weapon section stated above.
:SetGearWep
echo playerName= %playerName% >playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %preliminaryplayerHP% >>playerData.dll
echo playerSPD= %preliminaryplayerSPD% >>playerData.dll
echo playerATK= %preliminaryplayerATK% >>playerData.dll
echo playerDEF= %preliminaryplayerDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %SearchGear% >>playerData.dll
echo playerLevel= %playerLevel% >>playerData.dll
echo playerExp= %playerExp% >>playerData.dll
echo playerMoney= %NewMoney% >>playerData.dll
goto finished

REM Chest armor section stated above.
:SetGearCarmor
echo playerName= %playerName% >playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %preliminaryplayerHP% >>playerData.dll
echo playerSPD= %preliminaryplayerSPD% >>playerData.dll
echo playerATK= %preliminaryplayerATK% >>playerData.dll
echo playerDEF= %preliminaryplayerDEF% >>playerData.dll
echo playerArmor_Chest= %SearchGear% >>playerData.dll
echo playerArmor_Leg= %playerArmor_Leg% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
echo playerLevel= %playerLevel% >>playerData.dll
echo playerExp= %playerExp% >>playerData.dll
echo playerMoney= %NewMoney% >>playerData.dll
goto finished

REM Leg armor section stated above.
:SetGearLarmor
echo playerName= %playerName% >playerData.dll
ping 1.1.1.1 -n 1 -w 500 > nul
echo playerRace= %playerRace% >>playerData.dll
echo playerHP= %preliminaryplayerHP% >>playerData.dll
echo playerSPD= %preliminaryplayerSPD% >>playerData.dll
echo playerATK= %preliminaryplayerATK% >>playerData.dll
echo playerDEF= %preliminaryplayerDEF% >>playerData.dll
echo playerArmor_Chest= %playerArmor_Chest% >>playerData.dll
echo playerArmor_Leg= %SearchGear% >>playerData.dll
echo playerWeapon= %playerWeapon% >>playerData.dll
echo playerLevel= %playerLevel% >>playerData.dll
echo playerExp= %playerExp% >>playerData.dll
echo playerMoney= %NewMoney% >>playerData.dll
goto finished

REM Displays the message that you purchased the gear, then takes you back to the startup screen.
:finished
ping 1.1.1.1 -n 1 -w 500 > nul
echo.
echo You purchased the %SearchGear% for %gearCOST%$.
echo.
pause
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup