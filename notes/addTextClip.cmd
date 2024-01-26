@echo off
setlocal EnableDelayedExpansion

:: Get clipboard content
for /f "delims=" %%A in ('powershell.exe -Command "Get-Clipboard"') do set "clipboard_text=%%A"

if not defined clipboard_text (
    echo No text found in the clipboard.
    exit /b 1
)

:: Save the clipboard content to a text file
echo !clipboard_text! >> trash.md

:: Initialize git if not already done
if not exist ".git" (
    git init
)

:: Add the changes
git add -A

:: Commit and push
git commit -m "Added clipboard text"
git push

endlocal
