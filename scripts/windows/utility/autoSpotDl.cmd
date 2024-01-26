@echo off
set /P ytb=youtube url:
set /P spot=spotify url:
spotdl download "%ytb%|%spot%"