#!/bin/bash
# wow this works

video_file="video/britt_1080.mp4"  # Replace with your video filename

# Loop through each clip entry (modify timecodes and names as needed)
clips=(
  
"00:11:34.580 00:11:36.462"  #  look
"00:02:27.814 00:02:28.014"  #  at my
"00:05:24.858 00:05:25.692"  #  kitchen table
"00:02:45.398 00:02:47.900"  #  its truly breath-taking
"00:14:36.909 00:14:40.179"  #  it is worth it
"00:15:38.350 00:15:39.919"  #  and when we gaze upon the
"00:05:24.858 00:05:25.692"  #  kitchen table
"00:11:15.760 00:11:18.711"  #  it conquers America

)

for clip in "${clips[@]}"; do
  start_time=$(echo "$clip" | cut -d ' ' -f 1)
  end_time=$(echo "$clip" | cut -d ' ' -f 2)
  # Extract clip name if desired (optional)
  # clip_name=$(echo "$clip" | cut -d ' ' -f 3)
  
  mpv --autofit-larger=90% --start=$start_time --end=$end_time "$video_file"
done
