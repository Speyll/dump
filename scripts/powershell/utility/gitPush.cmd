@echo off
set /P commit=commit: 
git add -A
git commit -m "%commit%"
git push