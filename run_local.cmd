@echo off
setlocal ENABLEDELAYEDEXPANSION

title NVIAM Frontend — Local Server
echo ============================================
echo   NVIAM Frontend — Local Development Server
echo ============================================
echo.

REM Default port (can override by passing first arg or setting PORT)
if not "%1"=="" set PORT=%1
if "%PORT%"=="" set PORT=5173

REM Quick sanity check
if not exist index.html (
  echo [ERROR] index.html not found in current directory.
  echo Run this script from the project root, e.g. D:\cyber-fictionFrontend
  exit /b 1
)

echo Using port %PORT%
echo.

REM Try Node-based servers first (serve or http-server via npx)
where npx >nul 2>nul
if %ERRORLEVEL%==0 (
  echo [INFO] Found npx — trying: npx serve -s -l %PORT%
  echo (Close the server with Ctrl+C)
  npx --yes serve -s -l %PORT%
  if %ERRORLEVEL%==0 goto :end

  echo.
  echo [WARN] Fallback: npx http-server -p %PORT%
  npx --yes http-server -p %PORT%
  if %ERRORLEVEL%==0 goto :end
)

REM Fallback: Python 3 built-in HTTP server
where python >nul 2>nul
if %ERRORLEVEL%==0 (
  echo.
  echo [INFO] Using Python http.server on port %PORT%
  echo (Close the server with Ctrl+C)
  python -m http.server %PORT%
  if %ERRORLEVEL%==0 goto :end
)

echo.
echo [ERROR] Could not find a static server.
echo Install Node.js and run:   npm i -g serve   (then re-run this script)
echo Or ensure Python 3 is available in PATH.
exit /b 1

:end
echo.
echo Server stopped.
endlocal

