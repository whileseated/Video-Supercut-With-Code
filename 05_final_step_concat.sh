#!/bin/bash

convert_to_seconds() {
	hms=$1
	h=$(echo $hms | cut -d: -f1)
	m=$(echo $hms | cut -d: -f2)
	s=$(echo $hms | cut -d: -f3)
	echo | awk -v h=$h -v m=$m -v s=$s 'BEGIN{print h*3600 + m*60 + s}'
}

input_video="video/britt_1080.mp4"

segments=(
	"00:11:34.580 00:11:36.462"
	"00:02:27.814 00:02:28.014"
	"00:05:24.858 00:05:25.692"
	"00:02:45.398 00:02:47.900"
	"00:14:36.909 00:14:40.179"
	"00:15:38.350 00:15:39.919"
	"00:05:24.858 00:05:25.692"
	"00:11:15.760 00:11:18.711"
)

# Reset or rewrite the file list each time the script runs
file_list="file_list.txt"
echo "" > "$file_list"

for i in "${!segments[@]}"; do
	IFS=' ' read -r start end <<< "${segments[i]}"
	output_segment="segment_${i}.mp4"
	
	ffmpeg -i "$input_video" -ss "$start" -to "$end" -map 0:v:0 -map 0:a:0 -c:v libx264 -c:a aac -crf 17 -preset veryslow "$output_segment"
	
	echo "file '$output_segment'" >> "$file_list"
done

# Concatenate all segments with high-quality re-encoding
ffmpeg -f concat -safe 0 -i "$file_list" -c:v libx264 -c:a aac -crf 17 -preset veryslow "video/final_output.mp4"

# Delete the individual segment files after successful concatenation
while IFS= read -r line
do
	# Extract the segment file path
	segment_file=$(echo $line | cut -d"'" -f2)
	# Check if file exists and delete
	[[ -f "$segment_file" ]] && rm "$segment_file"
done < "$file_list"

echo "Concatenation complete. The output file is video/final_output.mp4."
