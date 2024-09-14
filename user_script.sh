#!/bin/bash
# User account management script

# Lecture 5: user input and control flow
# Lecture 06: enforving root user privs

# Function to create user accounts
create_user() {
  if ! id "$1" &>/dev/null; then
    useradd -m "$1"
    echo "User $1 created."
  else
    echo "User $1 already exists."
  fi
}

# Function to delete user accounts
delete_user() {
  userdel -r "$1"
  echo "User $1 deleted."
}

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Check for the user list file argument and its content
user_list="$1"
if [ -z "$user_list" ] || [ ! -s "$user_list" ]; then
  echo "Usage: $0 <user_list_file>"
  exit 1
fi

# Create user accounts from the list
while IFS= read -r user; do
  create_user "$user"
done < "$user_list"

# Show /etc/passwd and /home directory for verification
cat /etc/passwd
ls /home

# Prompt to delete accounts
echo "Do you want to delete the created user accounts? [y/N]"
read -r answer

if [ "$answer" = "y" ]; then
  while IFS= read -r user; do
    delete_user "$user"
  done < "$user_list"
  cat /etc/passwd
  ls /home
else
  echo "Script terminated without deleting accounts."
fi
