#!/usr/bin/env bash

# Internal function to check for necessary dependencies.
_check_dependencies() {
	if ! command -v ffmpeg &> /dev/null; then
		echo "ffmpeg could not be found"
		return 1
	fi

    if ! command -v ffprobe &> /dev/null; then
		echo "ffprobe could not be found"
		return 1
    fi
	return 0
}

# Internal function to perform the video compression.
_perform_compression() {
	local input_file="$1"
	local output_dir="$2"
	local filename

	# Check if the output directory exists
	if [[ ! -d "$output_dir" ]]; then
		echo "The specified output directory does not exist: $output_dir"
		return 1
	fi

	local dir_location
	dir_location=$(realpath "$output_dir")
	printf "dir_location: %s\n" "$dir_location"
	# printf "Compressing video %s and saving to %s\n" "$input_file" "$dir_location"

	# check the width and height of the video
	local width
	width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$input_file")

	if [[ -z "$width" ]]; then
		echo "Could not retrieve video width for $input_file."
		return 1
	fi

	# substitute .mp4 with _compressed.mp4
	filename="$dir_location/$(basename "$input_file" .mp4)_compressed.mp4"
	printf "Output file will be: %s\n" "$filename"

	if [[ "$width" -gt 720 ]]; then
		echo "Resizing video to 720p and compressing..."
		ffmpeg -i "$input_file" -vf "scale=720:-2" -vcodec libx264 -crf 28 -c:a copy "$filename"
	else
		echo "Compressing video..."
		ffmpeg -i "$input_file" -vcodec libx264 -crf 28 -c:a copy "$filename"
	fi

	if [[ $? -eq 0 ]]; then
		echo "Video compressed successfully and saved to $filename"
		return 0
	else
		echo "Failed to compress video: $input_file"
		return 1
	fi
}

# Compresses a single video file.
compress_video() {
	_check_dependencies || return 1

	# Check if the user provided a video file and an output directory
	if [[ $# -ne 2 ]]; then
		echo "Usage: compress_video <video_file> <output_directory>"
		return 1
	fi

	# Check if the provided file exists
	if [[ ! -f "$1" ]]; then
		echo "The specified file does not exist: $1"
		return 1
	fi

	_perform_compression "$1" "$2"
}

# Compresses all mp4 videos in the specified directory.
compress_videos() {
	_check_dependencies || return 1

	# Check if the user provided a directory
	if [[ $# -ne 1 ]]; then
		echo "Usage: compress_videos <directory>"
		return 1
	fi

	# Check if the provided directory exists
	if [[ ! -d "$1" ]]; then
		echo "The specified directory does not exist: $1"
		return 1
	fi

	local search_dir
	search_dir=$(realpath "$1")
	local output_dir="$search_dir/compressed"
	mkdir -p "$output_dir"

	local files
	files=()

	# Find all mp4 files, sort them by title, and store in files array
	while IFS= read -r -d $'\0' file; do
		files+=("$file")
	done < <(find "$search_dir" -maxdepth 1 -type f -name "*.mp4" -print0 | sort -z)

	local file_count=${#files[@]}
	if [[ $file_count -eq 0 ]]; then
		echo "No mp4 files found in the directory: $search_dir"
		return 0
	fi

	echo "Found $file_count mp4 files in $search_dir. Compressing..."

	local current_file
	current_file=1	

	for file in "${files[@]}"; do
		printf "Processing file %d of %d: %s\n" "$current_file" "$file_count" "$(basename "$file")"
		_perform_compression "$file" "$output_dir"
		((current_file++))
		if [[ $? -ne 0 ]]; then
			echo "Error compressing file: $file"
			continue
		fi
	done
}