#!/bin/bash
# Interactive Menu Script for File Queries and Operations
#References lecture 06 for arrays and lecture 7 for string manipluation.


# Function for Cork Query
cork_query() {
  echo "Towns from countyCork  starting with 'B' and ending with 'y', or starting with 'M' and ending with 'n':"
  grep -E '^(B.*y|M.*n)$' countyCork.txt
}

# Function for Advert Query
advert_query() {
  echo "Enter your budget (800-1300):"
  read -r budget
  if [[ $budget -ge 800 && $budget -le 1300 ]]; then
    grep -E "^$budget" adverts.txt
  else
    echo "Budget must be between 800 and 1300."
  fi
}

# Function to write to a file
write_to_file() {
  echo "Enter the file name:"
  read -r file_name
  touch "$file_name"
  echo "Type content to write (type 'stop' on a line to finish):"
  while IFS= read -r line; do
    [[ $line == "stop" ]] && break
    echo "$line" >> "$file_name"
  done
  echo "Content written to $file_name."
}

# Main menu
while true; do
  echo "Menu Options:"
  echo "1) Cork Query"
  echo "2) Advert Query"
  echo "3) Write to a File"
  echo "4) Terminate Script"
  read -r option
  
  case $option in
    1)
      [[ -f countyCork.txt ]] && cork_query || echo "countyCork.txt not found."
      ;;
    2)
      [[ -f adverts.txt ]] && advert_query || echo "adverts.txt not found."
      ;;
    3)
      write_to_file
      ;;
    4)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
done
