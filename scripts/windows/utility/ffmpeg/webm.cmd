for %%f in (*.webm) do (
    echo file %%f >> list.txt
)
ffmpeg -f concat -safe 0 -i list.txt -c copy output.webm
del list.txt