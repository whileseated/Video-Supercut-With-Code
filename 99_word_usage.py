import re
from collections import Counter

def process_transcript(input_file, output_file):
	# Regular expression to match words (including those with apostrophes)
	word_pattern = re.compile(r"\b[\w']+\b")

	word_counts = Counter()

	with open(input_file, 'r', encoding='utf-8') as file:
		for line in file:
			# Extract the text part after the timings
			text = line.split(']')[-1].strip()
			# Find all words in the text part, including those with apostrophes
			words = word_pattern.findall(text.lower())  # Convert to lower case to count all variations of a word the same
			word_counts.update(words)

	# Sort words first by their count (descending) and then alphabetically
	sorted_words = sorted(word_counts.items(), key=lambda x: (-x[1], x[0]))

	# Write the sorted words and their counts to the output file
	with open(output_file, 'w', encoding='utf-8') as file:
		for word, count in sorted_words:
			file.write(f"{word}: {count}\n")

input_file = 'output/britt_audio_sow.txt'
output_file = 'output/britt_audio_sow_usage.txt'

# Process the file
process_transcript(input_file, output_file)

print("Processing complete. Check the output file for results.")