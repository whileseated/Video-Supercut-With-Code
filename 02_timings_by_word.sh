#!/bin/bash

input_folder="audio"
output_folder="output"

# Ensure the output folder exists
mkdir -p "$output_folder"

# Iterate through all files in the input folder
for input_file in "$input_folder"/*.wav; do
  # Get the base filename without the .wav extension
  base_filename=$(basename "$input_file" .wav)

  # Define output filenames with different suffixes
  output_file_sow="$output_folder/${base_filename}_level_sow.txt"
  output_file_level_01="$output_folder/${base_filename}_level_01.txt"
  output_file_level_16="$output_folder/${base_filename}_level_16.txt"

  # Run the command with different parameters and output files
  /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/main -m /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/models/ggml-base.en.bin -f "$input_file" -sow > "$output_file_sow"
  /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/main -m /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/models/ggml-base.en.bin -f "$input_file" -ml 1 > "$output_file_level_01"
  /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/main -m /LOCATION_OF_YOUR_WHISPER_INSTALL/whisper/whisper.cpp/models/ggml-base.en.bin -f "$input_file" -ml 16 > "$output_file_level_16"

done

echo "Batch transcription complete."
