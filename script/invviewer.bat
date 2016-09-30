REM The next lines load the quantities of items and sets them as variables to be used when displaying.
REM for /f "tokens=2" %%G IN (NameOfTheItem_DROP.dll) DO if not defined NameOfTheItem set "NameOfTheItem=%%G"
cd C:\Users\%ComputerUsername%\Desktop\CMDRPG\player\inventory\drops
for /f "tokens=2" %%G IN (Dark_Cloth_DROP.dll) DO if not defined Dark_Cloth set "Dark_Cloth=%%G"

REM Displays all the information onto the screen.
setlocal
cls
cd C:\Users\%USERNAME%\Desktop\CMDRPG\script\headings
type inventory.txt
cd C:\Users\%ComputerUsername%\Desktop\CMDRPG\player\inventory\drops
echo.
echo.
echo -------------------------------------
echo Weapon:		%playerWeapon%
echo HP: 		%preliminaryWeaponHP%
echo SPD: 		%preliminaryWeaponSPD%
echo ATK: 		%preliminaryWeaponATK%
echo DEF: 		%preliminaryWeaponDEF%
echo -------------------------------------
echo Chest Armor:	%playerArmor_Chest%
echo HP: 		%preliminaryChestArmorHP%
echo SPD: 		%preliminaryChestArmorSPD%
echo ATK: 		%preliminaryChestArmorATK%
echo DEF: 		%preliminaryChestArmorDEF%
echo -------------------------------------
echo Leg Armor:	%playerArmor_Leg%
echo HP: 		%preliminaryLegArmorHP%
echo SPD: 		%preliminaryLegArmorSPD%
echo ATK: 		%preliminaryLegArmorATK%
echo DEF: 		%preliminaryLegArmorDEF%
echo -------------------------------------
echo.

REM This is the list of all items and the quantity you currently possess.
echo Dark_Cloth: 	%Dark_Cloth%
echo.
pause
