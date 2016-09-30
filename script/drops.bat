@echo off
cd C:\Users\%USERNAME%\Desktop\CMDRPG\enemies\%locChoose%
for /f "skip=5 tokens=2" %%G IN (%CurrentMob%_data.dll) DO if not defined mobDrop set "mobDrop=%%G"
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
for /f "tokens=2" %%G IN (%mobDrop%.dll) DO if not defined mobDropAmount set "mobDropAmount=%%G"
for /f "skip=1 tokens=2" %%G IN (%mobDrop%.dll) DO if not defined mobDropCost set "mobDropCost=%%G"
set /a nmbrDrop=(%random%  * (2 - 0 + 1) / 32768)
if %nmbrDrop%==0 echo The %CurrentMob% dropped %nmbrDrop% %mobDrop%s.
if %nmbrDrop%==1 echo The %CurrentMob% dropped %nmbrDrop% %mobDrop%.
if %nmbrDrop%==2 echo The %CurrentMob% dropped %nmbrDrop% %mobDrop%s.
set /a newplayerCount=(%mobDropAmount% + %nmbrDrop%)
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player\inventory\drops
echo Amount= %newplayerCount% >%mobDrop%.dll
ping 1.1.1.1 -n 1 -w 1 > nul
echo Cost= %mobDropCost% >>%mobDrop%.dll
echo.
endlocal
