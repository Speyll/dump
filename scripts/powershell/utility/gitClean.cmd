@echo off
set /P commit=commit: 
git checkout --orphan test
git add -A
git commit -am "%commit%"
git branch -D main
git branch -m main
git push -f origin main
git gc --aggressive --prune=all
git push --set-upstream origin main