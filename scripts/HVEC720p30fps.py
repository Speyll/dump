import os
import ffmpy
from pymediainfo import MediaInfo

# Create the "encVids" directory if it doesn't exist
if not os.path.exists("encVids"):
    os.makedirs("encVids")

# Create the "reqMet" directory if it doesn't exist
if not os.path.exists("reqMet"):
    os.makedirs("reqMet")

# List of video file extensions to process
video_extensions = [".mp4", ".mkv", ".ts", ".mov", ".avi"]

# Loop through video files in the current directory
for filename in os.listdir():
    if filename.endswith(tuple(video_extensions)):
        input_file = filename
        output_file = os.path.join("encVids", os.path.splitext(filename)[0] + ".mp4")

        # Check if the output file already exists in "encVids" or "reqMet" directories
        if os.path.exists(output_file):
            print(f"Skipping: {input_file} (Already encoded)")
            continue

        try:
            # Use MediaInfo to retrieve video properties
            media_info = MediaInfo.parse(input_file)
            video_track = media_info.tracks[0]  # Assuming the first track is the video

            codec_name = video_track.codec_name
            width = video_track.width
            height = video_track.height
            fps = video_track.frame_rate
        except Exception as e:
            print(f"Error retrieving video information for: {input_file}")
            print(str(e))
            continue

        # Check if the video meets the encoding requirements
        if codec_name != 'HEVC' or height != '720 pixels' or float(fps) > 30:
            # Construct the ffmpeg command
            ff = ffmpy.FFmpeg(
                inputs={input_file: None},
                outputs={output_file: [
                    '-pix_fmt', 'yuv420p',
                    '-c:v', 'hevc_amf',
                    '-b:v', '2000k',
                    '-profile:v', 'main',
                    '-level:v', '4.0',
                    '-c:a', 'libopus',
                    '-tile-columns', '3',
                    '-g', '240',
                    '-threads', '7',
                    '-sws_flags', 'lanczos',
                    '-movflags', '+faststart',
                    '-color_primaries', 'bt709',
                    '-color_trc', 'bt709',
                    '-colorspace', 'bt709'
                ]}
            )

            # Execute the ffmpeg command using ffmpy
            ff.run()

            print(f"Encoding: {input_file}")
        else:
            # Move the video to the "reqMet" directory since it meets the requirements
            os.rename(input_file, os.path.join("reqMet", input_file))
            print(f"Moved to reqMet: {input_file}")

print("Encoding complete.")
