@echo off
cd /d "%~dp0"
REM Debug launcher: opens a persistent window and runs the starter
cmd.exe /k ""%~dp0Server_Start.bat""
