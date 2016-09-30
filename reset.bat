REM Deletes all player data, including the playerData.dll, boosts, the inventory files, and sets
REM the mob kill count equal to 0.
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\*.dll"
del "C:\Users\%USERNAME%\Desktop\CMDRPG\temporary\*.dll"
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\boost\*.dll"
del "C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\*.dll"
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies
echo 0 >mobKillCount.dll
exit