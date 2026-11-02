@echo off
title ChatGPT 2FA Master Suite
cd /d "%~dp0"
echo Starting ChatGPT 2FA Master Suite...
start http://127.0.0.1:8888
python server.py
pause
