#!/bin/bash
# References:
# Lecture 6 Array control flow 
# Lecture 7 string manipulation for handling string operations
# Lecture 9 Sed

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <folder_path> <pattern>"
  exit 1
fi

folder_path=$1
pattern=$2
match_files=() 

# Verify the folder exists
if [ ! -d "$folder_path" ]; then
  echo "Folder does not exist: $folder_path"
  exit 2
fi

# Iterate through files in the specified folder
for file in "$folder_path"/*; do
  if [ -f "$file" ]; then 
    file_name=$(basename "$file")
    pattern_count=$(grep -o -i "$pattern" "$file" | wc -l) 
    
    # Store files with at least two occurrences of the pattern
    if [ "$pattern_count" -ge 2 ]; then
      echo "File: $file_name, Pattern Count: $pattern_count"
      match_files+=("$file_name")
    fi
  fi
done

# Output matched file names to terminal and write to report.txt
echo "Matched Files:" > report.txt
for file_name in "${match_files[@]}"; do
  echo "$file_name"
  echo "$file_name" >> report.txt
done
