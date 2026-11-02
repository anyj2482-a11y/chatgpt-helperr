@echo off
title ChatGPT 2FA Master Suite - Public Server
cd /d "%~dp0"

echo =======================================================
echo   ChatGPT 2FA Master Suite - Live Public Server
echo =======================================================
echo.
echo 1. Checking local FastAPI engine...
tasklist /fi "imagename eq python.exe" 2>nul | findstr /i "python.exe" >nul
if errorlevel 1 (
    echo Starting Python server in background...
    start /b python server.py
    timeout /t 3 /nobreak >nul
) else (
    echo Python server is already running!
)

echo.
echo 2. Creating public web URL (No Cloudflare blocks, No proxies needed)...
echo =======================================================
echo   YOUR PUBLIC LINK IS GENERATING BELOW:
echo   Look for the URL ending with .trycloudflare.com
echo =======================================================
echo.

cloudflared.exe tunnel --url http://127.0.0.1:8888
pause
