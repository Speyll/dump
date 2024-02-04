import os
import subprocess

target_fps = 30

# Create the 'encVids' directory if it doesn't exist
os.makedirs("encVids", exist_ok=True)

for file in os.listdir("."):
    if file.endswith((".mp4", ".mkv", ".ts", ".mov", ".avi")):
        output = os.path.join("encVids", os.path.splitext(file)[0] + ".mp4")

        if not os.path.exists(output):
            print(f"Encoding {file} to {output}...")

            # Get the input video frame rate
            fps = subprocess.check_output(["ffprobe", "-v", "error", "-select_streams", "v:0", "-show_entries", "stream=r_frame_rate", "-of", "default=noprint_wrappers=1:nokey=1", file], text=True).strip()

            # Calculate the actual frame rate (float) by dividing the numerator by denominator
            actual_fps = "{:.2f}".format(float(fps.split("/")[0]) / float(fps.split("/")[1]))

            if float(actual_fps) > target_fps:
                subprocess.run(["ffmpeg", "-i", file, "-c:v", "libx265", "-r", str(target_fps), "-vf", f"scale='if(gt(ih,iw),min(720,iw),min(1280,iw))':'if(gt(ih,iw),min(1280,ih),min(720,ih))':force_original_aspect_ratio=decrease:force_divisible_by=2", "-preset", "faster", "-profile:v", "main", "-level:v", "4.0", "-c:a", "libopus", "-tile-columns", "3", "-g", "240", "-threads", "8", "-sws_flags", "lanczos", "-movflags", "+faststart", "-color_primaries", "bt709", "-color_trc", "bt709", "-colorspace", "bt709", output])
            else:
                subprocess.run(["ffmpeg", "-i", file, "-c:v", "libx265", "-r", str(actual_fps), "-vf", f"scale='if(gt(ih,iw),min(720,iw),min(1280,iw))':'if(gt(ih,iw),min(1280,ih),min(720,ih))':force_original_aspect_ratio=decrease:force_divisible_by=2", "-preset", "faster", "-profile:v", "main", "-level:v", "4.0", "-c:a", "libopus", "-tile-columns", "3", "-g", "240", "-threads", "8", "-sws_flags", "lanczos", "-movflags", "+faststart", "-color_primaries", "bt709", "-color_trc", "bt709", "-colorspace", "bt709", output])
        else:
            print(f"Output file {output} already exists. Skipping encoding for {file}.")

# Shut down the computer when the script finishes
# os.system("shutdown /s /t 1")
