REM Allows the player to choose the location of the fight. Different locations provide different monsters
REM and different levels of difficulty.
:ChooseLocation
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type choosefightlocation.txt
echo.
echo.
echo 1. Sewers......(Level 1-5)
if %playerLevel% GEQ 3 echo 2. Town........(Level 5-10)
if %playerLevel% GEQ 8 echo 3. Forest......(Level 10-15)
if %playerLevel% GEQ 13 echo 4. Mountain....(Level 15-20)
if %playerLevel% GEQ 20 echo 5. Castle.....(Level 20+)
echo 6. Exit
echo.
set /p locChoose=Where do you want to go? 
REM Sewers is the starting area, monsters are easy to kill and you can level up fast.
if '%locChoose%'=='1' (
set locChoose=Sewers
goto RandMob
)
REM Town has some more intermediate monsters, actually doing damage and putting up a little bit of a fight.
if '%locChoose%'=='2' (
set locChoose=Town
goto RandMob
)
REM Forest is the dead middle of the game, level 10.
if '%locChoose%'=='3' (
set locChoose=Forest
goto RandMob
)
REM Mountain is technically the end game area, because it is the area in which the character will hit max level.
if '%locChoose%'=='4' (
set locChoose=Mountain
goto RandMob
)
REM Castle is the boss room of the game. All monsters here are extremely difficult and will do massive damage.
if '%locChoose%'=='5' (
set locChoose=Castle
goto RandMob
)
if '%locChoose%'=='6' (
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup
)

REM Randomly generates a number, compares it against the amount of tokens in the mobID.txt file
REM and then sets the 'CurrentMob' variable to the corresponding token. It then outputs the variable
REM to the TempmobLOG.dll file to be used later.
:RandMob
setlocal
@echo off
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%locChoose%
set /p MobCount=<mobCount.txt
set /a RandomMob=(%random% * (%MobCount% - 1 + 1) / 32768 + 1)
for /f "tokens=%RandomMob%" %%G IN (mobID.txt) DO (
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies
echo %%G>>ArchivedmobLOG.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo %%G>TempmobLOG.dll
)
endlocal
goto setMobValues

REM Determines the amount of mobs you have killed, what the current mob is (found in the TempmobLOG.dll file
REM mentioned earlier. Finds the folder associated with the mob and pulls in its stats to be set as variables.
:setMobValues
setlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies
set /p KillCount=<mobKillCount.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
set /p CurrentMob=<TempmobLOG.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%locChoose%
for /f "tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobHP set "mobHP=%%G"
for /f "skip=1 tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobSPD set "mobSPD=%%G"
for /f "skip=2 tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobATK set "mobATK=%%G"
for /f "skip=3 tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobDEF set "mobDEF=%%G"
for /f "skip=4 tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobXP set "mobXP=%%G"
goto setTempFiles

REM Outputs the mob's and the player's stats temporarily to the temp folder to be used during this "fight".
:setTempFiles
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo %mobHP%>tempmob_HP.dll
echo %mobSPD%>tempmob_SPD.dll
echo %mobATK%>tempmob_ATK.dll
echo %mobDEF%>tempmob_DEF.dll
echo %playerHP%>tempplayer_HP.dll
echo %playerSPD%>tempplayer_SPD.dll
echo %playerATK%>tempplayer_ATK.dll
echo %playerDEF%>tempplayer_DEF.dll
goto setTempValues

REM Sets the new variables by pulling in the data in the temporary files created in the previous step.
:setTempValues
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
set /p tempmobHP=<tempmob_HP.dll
set /p tempmobSPD=<tempmob_SPD.dll
set /p tempmobATK=<tempmob_ATK.dll
set /p tempmobDEF=<tempmob_DEF.dll
set /p tempplayerHP=<tempplayer_HP.dll
set /p tempplayerSPD=<tempplayer_SPD.dll
set /p tempplayerATK=<tempplayer_ATK.dll
set /p tempplayerDEF=<tempplayer_DEF.dll
goto CompareSPD

REM Compares the speed values of the player and the mob you are currently fighting against. Whichever is
REM greater is set to the 'fasterEntity' variable.
:CompareSPD
if %tempmobSPD% GTR %tempplayerSPD% (
set fasterEntity=%CurrentMob%
) else (
set fasterEntity=%playerName%
)
goto StartFight

REM This is the first part of the code that you actually see in the program. It displays all the temporary stats
REM of the mob and the player. You have three options, attack, use potion, or run away.
:StartFight
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type fight.txt
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo.
echo You have killed %KillCount%enemies.
echo.
echo %playerName%
echo HP: %tempplayerHP%
echo SPD: %tempplayerSPD%
echo ATK: %tempplayerATK%
echo DEF: %tempplayerDEF%
echo.
echo %CurrentMob%			
echo HP: %tempmobHP%
echo SPD: %tempmobSPD%
echo ATK: %tempmobATK%
echo DEF: %tempmobDEF%
echo.
echo 1. Attack
echo 2. Use Potion
echo 3. Run Away
echo.
echo %fasterEntity% is faster and will attack first.
echo.
set /p ConfirmFight=What would you like to do?
if '%ConfirmFight%'=='1' goto UseAttack
if '%ConfirmFight%'=='2' goto UsePotion
if '%ConfirmFight%'=='3' goto UseRunAway
if not '%ConfirmFight%'=='' (
echo.
echo You have entered incorrect text, please try again.
echo.
pause
goto StartFight
)

REM Finds the current amount of potions you have by setting the data found in potionCount.dll (found in
REM the inventory folder) as a variable. If that value is zero, you can't use any potions because you don't have any.
:UsePotion
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /p amountPotion=<potionCount.dll
set /a Zero=0
if %amountPotion% LEQ %Zero% (
echo.
echo You do not have any potions!
echo.
pause
goto StartFight
)
if %tempplayerHP% GEQ %playerHP% (
echo.
echo You are already at maximum health.
echo.
pause
goto StartFight
)
goto DeterminePotionEffectiveness

REM Determines how much health the player currently has, compares it to the effectiveness of the potion, and either
REM sets player's health to max, or "adds" 25 to it
:DeterminePotionEffectiveness
set /a CompareNormalHP=(%playerHP% - 100)
if %tempplayerHP% LSS %CompareNormalHP% (
goto PotionPlus100
) else (
goto PotionFullHealth
)

REM This part of the code is called assuming the player has taken MORE damage than the effectiveness of the potion.
:PotionPlus100
set /a NewHealthPotion25=(%tempplayerHP% + 100)
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo %NewHealthPotion25%>tempplayer_HP.dll
echo.
echo You have a total of %playerHP% health.
echo You had %tempplayerHP%.
echo The potion restored 100HP.
echo.
pause
goto setNewPotionAmount

REM This part is called assuming that you have taken some damage, but less damage than the effectiveness of the potion.
:PotionFullHealth
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo %playerHP%>tempplayer_HP.dll
echo.
echo You have a total of %playerHP% health.
echo You had %tempplayerHP%.
echo The potion restored you to full health.
echo.
pause
goto setNewPotionAmount

REM "Uses" one potion, by taking the input of the potion.dll and subtracting 1 and re-outputing the information to the .dll file.
:setNewPotionAmount
set /a newPotionAmount=(%amountPotion% - 1)
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo %newPotionAmount% >potionCount.dll
goto setTempValues

REM Simple little random code here, just to determine if the player "ran away" or tripped over himself.
:UseRunAway
set /a RunAwayChance=(%random% * (2 - 1 + 1) / (32768 + 1))
ping 1.1.1.1 -n 1 -w 500 > nul
if %RunAwayChance%==1 goto RunAwaySuccess
if %RunAwayChance%==2 goto DealTrip

REM Ends the fight, no experience, loot, or money is gained or lost by the player.
:RunAwaySuccess
cls
echo.
echo You ran away from the %CurrentMob%.
echo.
pause
del "C:\Users\%USERNAME%\Desktop\CMDRPG\temp\*.dll"
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup

REM Assuming that the player trips over himself in the attempt to run away, the player takes damage equal to 
REM half of his current health.
:DealTrip
set /a TripDamage=(%tempplayerHP% / 2)
set /a New1PlayerHealth=(%tempplayerHP% - %TripDamage%)
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
echo %New1PlayerHealth%>tempplayer_HP.dll
ping 1.1.1.1 -n 1 -w 500 > nul
cls
echo.
echo You tripped while running away.
echo You dealt %TripDamage% damage to yourself!
echo.
pause
goto setTempValues

REM First code called when the player decides to attack the monster. This code compares the speed of the two entities
REM (you and the monster) and sets the fasterEntity variable equal to the entity with the higher speed value.
:UseAttack
if %fasterEntity%==%CurrentMob% (
goto MobAttackFirst
) else (
goto PlayerAttackFirst
)

REM All damage caused by the player and monster is a random number that is between -10% and +10% of the
REM attack value. This allows the fight to have a bit of variability. The fight defense value can be a
REM value -0% + 10%, that way the instanced defense value is never less than the original defense value.

REM Called if the speed of the player is greater than the speed of the monster.
:PlayerAttackFirst
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
set /a UpperPlayerAttack=(%tempplayerATK% * 110 / 100)
set /a LowerPlayerAttack=(%tempplayerATK% * 90 / 100)
set /a SubtotalPlayerAttack=(%random% * (%UpperPlayerAttack% - %LowerPlayerAttack% + 1) / 32768 + %LowerPlayerAttack%)
set /a UpperMobAttack=(%tempmobATK% * 110 / 100)
set /a LowerMobAttack=(%tempmobATK% * 90 / 100)
set /a SubtotalMobAttack=(%random% * (%UpperMobAttack% - %LowerMobAttack% + 1) / 32768 + %LowerMobAttack%)
ping 1.1.1.1 -n 1 -w 500 > nul
set /a UpperPlayerDefense=(%tempplayerDEF% * 110 / 100)
set /a LowerPlayerDefense=(%tempplayerDEF%)
set /a TotalPlayerDefense=(%random% * (%UpperPlayerDefense% - %LowerPlayerDefense% + 1) / 32768 + %LowerPlayerDefense%) / 5
set /a UpperMobDefense=(%tempmobDEF% * 110 / 100)
set /a LowerMobDefense=(%tempmobDEF%)
set /a TotalMobDefense=(%random% * (%UpperMobDefense% - %LowerMobDefense% + 1) / 32768 + %LowerMobDefense%) / 5
ping 1.1.1.1 -n 1 -w 500 > nul
set /a TotalPlayerAttack=(%SubtotalPlayerAttack% - %TotalMobDefense%)
set /a TotalMobAttack=(%SubtotalMobAttack% - %TotalPlayerDefense%)
if %SubtotalPlayerAttack% LSS %TotalMobDefense% goto MobDefended1
echo.
echo You did %TotalPlayerAttack% damage to the %CurrentMob%.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewMobHealth=(%tempmobHP% - %TotalPlayerAttack%)
if %NewMobHealth% LSS 1 goto PlayerWins
if %SubtotalMobAttack% LSS %TotalPlayerDefense% goto PlayerDefended2
echo The %CurrentMob% did %TotalMobAttack% damage to you.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewPlayerHealth=(%tempplayerHP%-%TotalMobAttack%)
if %NewPlayerHealth% LSS 1 goto MobWins
goto EchoHealth

REM Called if the speed of the monster is greater than the speed of the player.
:MobAttackFirst
cd C:\Users\%USERNAME%\Desktop\CMDRPG\temp
set /a UpperPlayerAttack=(%tempplayerATK% * 110 / 100)
set /a LowerPlayerAttack=(%tempplayerATK% * 90 / 100)
set /a SubtotalPlayerAttack=(%random% * (%UpperPlayerAttack% - %LowerPlayerAttack% + 1) / 32768 + %LowerPlayerAttack%)
set /a UpperMobAttack=(%tempmobATK% * 110 / 100)
set /a LowerMobAttack=(%tempmobATK% * 90 / 100)
set /a SubtotalMobAttack=(%random% * (%UpperMobAttack% - %LowerMobAttack% + 1) / 32768 + %LowerMobAttack%)
ping 1.1.1.1 -n 1 -w 500 > nul
set /a UpperPlayerDefense=(%tempplayerDEF% * 110 / 100)
set /a LowerPlayerDefense=(%tempplayerDEF%)
set /a TotalPlayerDefense=(%random% * (%UpperPlayerDefense% - %LowerPlayerDefense% + 1) / 32768 + %LowerPlayerDefense%) / 5
set /a UpperMobDefense=(%tempmobDEF% * 110 / 100)
set /a LowerMobDefense=(%tempmobDEF%)
set /a TotalMobDefense=(%random% * (%UpperMobDefense% - %LowerMobDefense% + 1) / 32768 + %LowerMobDefense%) / 5
ping 1.1.1.1 -n 1 -w 500 > nul
set /a TotalPlayerAttack=(%SubtotalPlayerAttack% - %TotalMobDefense%)
set /a TotalMobAttack=(%SubtotalMobAttack% - %TotalPlayerDefense%)
if %SubtotalMobAttack% LSS %TotalPlayerDefense% goto PlayerDefended1
echo.
echo The %CurrentMob% did %TotalMobAttack% damage to you.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewPlayerHealth=(%tempplayerHP% - %TotalMobAttack%)
if %NewPlayerHealth% LSS 1 goto MobWins
if %SubtotalPlayerAttack% LSS %TotalMobDefense% goto MobDefended2
echo You did %TotalPlayerAttack% damage to the %CurrentMob%.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewMobHealth=(%tempmobHP%-%TotalPlayerAttack%)
if %NewMobHealth% LSS 1 goto PlayerWins
goto EchoHealth

REM This code rewrites the tempmob_HP.dll file to accomodate the player's attack.
:EchoHealthMob
echo %NewMobHealth% >tempmob_HP.dll
pause
ping 1.1.1.1 -n 1 -w 500 > nul
goto setTempValues

REM Same as above, just rewrites the player's temporary health file.
:EchoHealthPlayer
echo %NewPlayerHealth% >tempplayer_HP.dll
pause
ping 1.1.1.1 -n 1 -w 500 > nul
goto setTempValues

:EchoHealth
echo %NewPlayerHealth% >tempplayer_HP.dll
echo %NewMobHealth% >tempmob_HP.dll
pause
ping 1.1.1.1 -n 1 -w 500 > nul
goto setTempValues



REM ----------------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------------
REM The code between the two REM'ed dashes takes care of defending against attacks and dealing with "who wins"
REM once either the player's or the monster's health is reduced to zero. Whoever has the second turn, if the the health
REM is reduced to zero, that entity loses.
:PlayerDefended1
echo.
echo You defended against the attack and took no damage!
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
goto PlayerSecondTurn

:PlayerDefended2
echo.
echo You defended against the attack and took no damage!
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
goto EchoHealthMob

:MobDefended1
echo.
echo The %CurrentMob% defended against your attack and took no damage.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
goto MobSecondTurn

:MobDefended2
echo The %CurrentMob% defended against your attack and took no damage.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
goto EchoHealthPlayer

:MobSecondTurn
echo The %CurrentMob% did %TotalMobAttack% damage to you.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewPlayerHealth=(%tempplayerHP%-%TotalMobAttack%)
if %NewPlayerHealth% LSS 1 goto MobWins
echo %NewPlayerHealth% >tempplayer_HP.dll
pause
ping 1.1.1.1 -n 1 -w 500 > nul
goto setTempValues

:PlayerSecondTurn
echo You did %TotalPlayerAttack% damage to the %CurrentMob%.
echo.
ping 1.1.1.1 -n 1 -w 500 > nul
set /a NewMobHealth=(%tempmobHP%-%TotalPlayerAttack%)
if %NewMobHealth% LSS 1 goto PlayerWins
ping 1.1.1.1 -n 1 -w 500 > nul
echo %NewMobHealth% >tempmob_HP.dll
pause
ping 1.1.1.1 -n 1 -w 500 > nul
goto setTempValues
REM ----------------------------------------------------------------------------------------------------
REM ----------------------------------------------------------------------------------------------------


REM Called assuming the monster's health runs out before the player's health.
:PlayerWins
cls
echo.
echo You have defeated the %CurrentMob%.
echo.
pause
goto LootWin

REM Called assuming the player's health runs out before the monster's health.
:MobWins
cls
echo.
echo You have been defeated by the %CurrentMob%.
goto LootLose

REM Determines the monster's loot value and randomly generates a number between 0 and 2 to give to the player.
REM Only is called if the player wins.
:LootWin
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /p CurrentMoney=<money.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /p CurrentXP=<exp.dll
set /a MoneyDropped=(%random% * (50 - 1 + 1) / 32768 + 1)
set /a NewCurrentMoney=(%CurrentMoney% + %MoneyDropped%)
echo.
echo You looted %MoneyDropped% $ from the %CurrentMob%.
echo You now have %NewCurrentMoney% $ to spend at the shop.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo %NewCurrentMoney% >money.dll
echo.
echo You gained %mobXP% experience points.
echo.
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a NewXP=(%CurrentXP% + %mobXP%)
echo %NewXP% >exp.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies
set /a newKillCount=(%KillCount% + 1)
echo %newKillCount% >mobKillCount.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call drops
pause
goto ResetTempFiles

REM Called if the player loses, this assumes that the monster "took" more money than you currently have, so
REM it is just reduced to zero.
:LootLose
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
set /p CurrentMoney=<money.dll
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
set /a UpperMoneyTaken=(%CurrentMoney% * 10 / 100)
set /a LowerMoneyTaken=(%CurrentMoney% * 0 / 100)
set /a MoneyTaken=(%random% * (%UpperMoneyTaken% - %LowerMoneyTaken% + 1) / 32768 + %LowerMoneyTaken%)
set /a NewCurrentMoney=(%CurrentMoney% - %MoneyTaken%)
ping 1.1.1.1 -n 1 -w 500 > nul
if %NewCurrentMoney% GTR 0 goto LootLose1
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo 0 >money.dll
echo.
echo The %CurrentMob% stole the rest of your money!
echo You have no money left.
echo.
echo You didn't gain any experience.
echo.
pause
goto ResetTempFiles

REM Called if the player loses, this code basically reduces the player's money by an amount equal to +0% to -10%.
:LootLose1
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory
echo %NewCurrentMoney% >money.dll
echo.
echo The %CurrentMob% stole %MoneyTaken% $ from you!
echo You now have %NewCurrentMoney% $ to spend at the shop.
echo.
echo You didn't gain any experience.
echo.
pause
goto ResetTempFiles

REM Deletes all the temporary files generated by this code.
:ResetTempFiles
ping 1.1.1.1 -n 1 -w 1 > nul
del "C:\Users\%USERNAME%\Desktop\CMDRPG\temp\*.dll"
endlocal
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
call startup