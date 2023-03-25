#!/bin/bash
# This script aims to find broken hardlinks between a given directory and a source directory, which is
# /mnt/r/Radio/everything in this case. The assumption is that /mnt/r/Radio/everything is the reference, 
# that all files in the working directory should have a hardlink pointing to the source directory, and the files
# have the same name (this is important to speed up the script). If the hardlink is broken, the file in the working 
# directory is deleted, so that it can be re-linked properly later.
# Explanation from ChatGPT: first creates an associative array radio_files that maps file names (without the path) to their full
# paths in /mnt/r/Radio/everything directory. It uses a while loop with read command to read the output 
# of the find command that finds all audio files in /mnt/r/Radio/everything directory and its subdirectories. 
# For each file, it extracts the file name using the basename command and adds it to the radio_files array with its full path as the value.
# The script then uses another find command to find all audio files in the current directory and its subdirectories. 
# For each file, it extracts the file name using basename command and checks if there is a matching file 
# with the same name in the radio_files array. If there is no matching file, it echoes "No match for $file". 
# If there is a matching file, it uses the stat command to compare the inode numbers of the two files. 
# If the inode numbers are different, it echoes "$file has a match but NOT hardlinked" and deletes the file.


for dir in "/mnt/r/Radio/genre-based/" \
           "/mnt/r/Radio/soundtracks/" \
           "/mnt/r/Radio/region-based/" \
           "/mnt/r/Radio/soundtracks/" \
           "/mnt/r/Radio/decades/"; do 
  echo "Processing directory: $dir"
  cd "$dir"

  declare -A radio_files

  # Create a list of all files in /mnt/r/Radio/everything directory (including subdirectories)
  while IFS= read -r -d '' file; do
    if [[ -f "$file" ]]; then
      name=$(basename "$file")
      radio_files["$name"]="$file"
    fi
  done < <(find /mnt/r/Radio/everything -type f \( -name "*.flac" -o -name "*.mp3" -o -name "*.ogg" -o -name "*.m4a" -o -name "*.ac3" \) -print0)

  # Check if each audio file in the current directory and its subdirectories has a matching file in /mnt/r/Radio/everything directory
  find . -type f \( -name "*.flac" -o -name "*.mp3" -o -name "*.ogg" -o -name "*.m4a" -o -name "*.ac3" \) -print0 |
  while read -r -d '' file; do
    name=$(basename "$file")
    if [[ "${radio_files["$name"]}" == "" ]]; then
      echo "No match for $file"
    elif [[ "$(stat -c '%i' "$file")" -ne "$(stat -c '%i' "${radio_files["$name"]}")" ]]; then
      echo "$file match but NOT hardlinked, deleting"
      rm "$file"
    fi
  done
done
