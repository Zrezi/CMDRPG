@echo off
mode con:cols=85 lines=50
color 0A
title Command RPG v0.18
set ComputerUsername=%USERNAME%
cd C:\Users\%USERNAME%\Desktop\CMDRPG\player
if exist playerData.dll (
	cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
	call startup
) else (
	cd C:\Users\%USERNAME%\Desktop\CMDRPG\script
    	call newchar
)