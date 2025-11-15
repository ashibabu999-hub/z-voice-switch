@echo off
REM Z Voice Switch Windows Installer

REM --- Node.js Check/Install ---
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed. Downloading installer...
    powershell -Command "Start-Process 'https://nodejs.org/dist/v18.20.2/node-v18.20.2-x64.msi' -Wait"
    echo Please install Node.js and rerun this installer.
    pause
    exit /b
) else (
    echo Node.js found: 
    node -v
)

REM --- NPM Check ---
where npm >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo npm is not available. Please ensure Node.js install has npm included.
    pause
    exit /b
) else (
    echo npm found: 
    npm -v
)

REM --- MySQL Check ---
where mysql >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo MySQL client is not installed or not in PATH.
    echo Please install MySQL Server (https://dev.mysql.com/downloads/installer/) and ensure mysql.exe is in your PATH.
    pause
    exit /b
) else (
    echo MySQL found: 
    mysql --version
)

REM --- Redis Check ---
where redis-server >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Redis is not installed or not in PATH.
    echo You can download Redis for Windows from https://github.com/microsoftarchive/redis/releases
    echo Please install Redis and make sure redis-server.exe is accessible from PATH.
    pause
    exit /b
) else (
    echo Redis server found: 
    redis-server --version
)

REM --- Environment Setup ---
echo Creating folder structure...
mkdir src\modules
mkdir src\config
mkdir database
mkdir logs

REM --- Copy configuration templates ---
echo Creating example .env file...
echo PORT=3000>NUL
echo NODE_ENV=production>>.env.example
echo DB_HOST=localhost>>.env.example
echo DB_USER=root>>.env.example
echo DB_PASSWORD=your_password>>.env.example
echo DB_NAME=voip>>.env.example
echo REDIS_URL=redis://localhost:6379>>.env.example
echo DINSTAR_IP=192.168.1.100>>.env.example
echo DINSTAR_PORT=8000>>.env.example
echo DINSTAR_USER=admin>>.env.example
echo DINSTAR_PASS=admin>>.env.example
echo SIP_PORT=5060>>.env.example
echo SIP_HOST=0.0.0.0>>.env.example

REM --- NPM dependency install ---
echo Installing project dependencies via npm...
npm install

REM --- MySQL schema import ---
if exist "database\schema.sql" (
    echo Importing MySQL schema (enter password if prompted)...
    mysql -u root -p < database\schema.sql
) else (
    echo No database\schema.sql file found; skipping DB import.
)

echo.
echo ------- Installation Complete -------
echo Configure your .env file in the project root before starting
echo To launch the application:
echo    npm start
echo Or for development mode:
echo    npm run dev
echo -------------------------------------
pause
