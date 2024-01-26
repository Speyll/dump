@echo off
mkdir encVids 2>nul

for %%i in (*.mp4 *.mkv *.ts *.mov *.avi) do (
    if not exist "encVids\%%~ni.mp4" (
        ffmpeg -hwaccel auto -i "%%i" -vf "scale=-1:720,fps=30" -c:v hevc_amf -b:v 4500k -preset faster -profile:v main -level:v 4.0 -c:a libopus -tile-columns 3 -g 240 -threads 7 -sws_flags lanczos -movflags +faststart -color_primaries bt709 -color_trc bt709 -colorspace bt709 "encVids\%%~ni.mp4"
    )
)


:: Wait for 1 minute before shutting down
ping -n 61 127.0.0.1 > nul

:: Shutdown the PC
:: shutdown /s /f /t 0