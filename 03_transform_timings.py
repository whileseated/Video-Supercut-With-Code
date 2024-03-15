def transform_line(input_line):
	# Splitting the input line into components
	timing_part, word = input_line.strip().split(']  ')
	# Removing the leading '[' from the timing part and replacing '-->' with a space
	timing = timing_part[1:].replace(' --> ', ' ')
	# Formatting the output string
	output_line = f'"{timing}"  # {word}'
	return output_line

def transform_multiple_lines_from_file(file_path):
	with open(file_path, 'r') as file:
		input_lines = file.readlines()
	transformed_lines = [transform_line(line) for line in input_lines if line.strip()]
	return transformed_lines

# Provide the path to your file containing the input lines
file_path = '03_transform_timings_input_lines.txt'

# Transform the lines read from the file
output_lines = transform_multiple_lines_from_file(file_path)

# Print each transformed line
for line in output_lines:
	print(line)
