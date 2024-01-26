import os
import shutil
import subprocess

# Create the "notThirty" directory
if not os.path.exists("notThirty"):
    os.mkdir("notThirty")

# Supported video file extensions
video_extensions = ['.mp4', '.mkv', '.mov', '.ts', '.avi']

# Function to get the frame rate of a video file using mediainfo
def get_frame_rate(filename):
    result = subprocess.run(['mediainfo', '--Output=Video;%FrameRate%', filename], stdout=subprocess.PIPE)
    frame_rate = result.stdout.decode().strip()
    return frame_rate

# Iterate through the files in the current directory
for filename in os.listdir():
    if filename.endswith(tuple(video_extensions)):
        frame_rate = get_frame_rate(filename)
        try:
            frame_rate = float(frame_rate)
            if frame_rate > 30:
                shutil.move(filename, os.path.join("notThirty", filename))
        except ValueError:
            pass
