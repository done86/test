@echo off
setlocal EnableExtensions
cd /d "%~dp0"

REM ============================================================================
REM  Dart-Tournament-Manager - Windows Starter
REM  - Keeps a console window open (even when double-clicked)
REM  - Creates .venv (if missing), installs deps, starts server, opens browser
REM  - Writes a log to .\logs\
REM ============================================================================

REM If started by double-click (cmd /c), relaunch in a persistent window (cmd /k)
if not defined DTM_CONSOLE (
  set "DTM_CONSOLE=1"
  cmd.exe /k ""%~f0""
  exit /b
)

echo ==================================================
echo   Dart-Tournament-Manager - Server Start (Windows)
echo ==================================================
echo Working directory: %cd%
echo.

REM --- Log file ---
if not exist "logs" mkdir "logs" >nul 2>nul
set "TS="
for /f "delims=" %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss" 2^>nul') do set "TS=%%I"
if not defined TS (
  set "TS=%DATE%_%TIME%"
  set "TS=%TS::=-%"
  set "TS=%TS:/=-%"
  set "TS=%TS:.=-%"
  set "TS=%TS:,=-%"
  set "TS=%TS: =0%"
)
set "LOG=logs\startup_%TS%.log"
echo Logging to: %LOG%
echo. > "%LOG%"

call :log "== START =="

REM --- Find a working Python 3 command ---
set "PY="

py -3 -c "import sys; print(sys.version)" >nul 2>nul
if not errorlevel 1 set "PY=py -3"

if not defined PY (
  python -c "import sys; print(sys.version)" >nul 2>nul
  if not errorlevel 1 set "PY=python"
)

if not defined PY (
  python3 -c "import sys; print(sys.version)" >nul 2>nul
  if not errorlevel 1 set "PY=python3"
)

if not defined PY (
  call :log "[ERROR] No working Python 3 command found (py/python/python3)."
  echo.
  echo FEHLER: Python 3 wurde nicht gefunden oder ist nicht korrekt eingerichtet.
  echo.
  echo Bitte pruefe in einer Eingabeaufforderung:
  echo   py -3 --version
  echo oder
  echo   python --version
  echo.
  echo Falls Windows-Store-Aliase aktiv sind:
  echo   Einstellungen ^> Apps ^> App-Ausfuehrungsaliase ^> python.exe / python3.exe AUS
  echo.
  echo Log: %LOG%
  pause
  exit /b 1
)

call :log "Python command selected: %PY%"

REM --- Create venv if missing ---
set "VENV=.venv"
set "VPY=%cd%\%VENV%\Scripts\python.exe"

if not exist "%VPY%" (
  echo Creating virtual environment...
  call :log "Creating venv..."
  %PY% -m venv "%VENV%" >> "%LOG%" 2>&1
  if errorlevel 1 (
    echo.
    echo FEHLER: Konnte virtualenv nicht erstellen.
    echo Siehe Log: %LOG%
    echo.
    type "%LOG%"
    pause
    exit /b 1
  )
)

if not exist "%VPY%" (
  call :log "[ERROR] venv python not found at: %VPY%"
  echo.
  echo FEHLER: Virtualenv wurde erstellt, aber Python in .venv fehlt.
  echo Log: %LOG%
  pause
  exit /b 1
)

REM --- Install deps ---
echo Upgrading pip...
call :log "Upgrading pip..."
"%VPY%" -m pip install --upgrade pip >> "%LOG%" 2>&1

echo Installing requirements...
call :log "Installing requirements..."
"%VPY%" -m pip install -r requirements.txt >> "%LOG%" 2>&1
if errorlevel 1 (
  echo.
  echo FEHLER: Abhaengigkeiten konnten nicht installiert werden.
  echo Siehe Log: %LOG%
  echo.
  type "%LOG%"
  pause
  exit /b 1
)

REM --- Start server ---
echo.
echo Starting server at: http://127.0.0.1:5000
echo (Wenn der Browser zu frueh aufgeht, einmal aktualisieren.)
echo.

call :log "Opening browser..."
start "" "http://127.0.0.1:5000"

call :log "Starting app module..."
"%VPY%" -m dart_tournament_manager >> "%LOG%" 2>&1

echo.
echo ==================================================
echo Server process ended (or crashed).
echo Log file: %LOG%
echo ==================================================
echo.
type "%LOG%"
echo.
pause
exit /b 0

:log
echo [%DATE% %TIME%] %~1>> "%LOG%"
exit /b 0
