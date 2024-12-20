#!/bin/bash

# Define source and destination directories
SOURCE="/Confidential"
DESTINATION="/Backup"

# Get the current date in YYYY-MM-DD format
DATE=$(date +%F)

# Create the backup directory for today's date if it doesn't exist
BACKUP_DIR="$DESTINATION/$DATE"

# Check if the source directory exists
if [ ! -d "$SOURCE" ]; then
  echo "Error: Source directory $SOURCE does not exist."
  exit 1
fi

# Check if the destination directory exists, create it if not
if [ ! -d "$DESTINATION" ]; then
  mkdir -p "$DESTINATION"
  echo "Destination directory $DESTINATION did not exist and was created."
fi

# Check if the backup directory for today's date already exists
if [ -d "$BACKUP_DIR" ]; then
  echo "Backup directory $BACKUP_DIR already exists. Skipping creation."
else
  mkdir -p "$BACKUP_DIR"
  echo "Created backup directory: $BACKUP_DIR"
fi

# Perform the backup using rsync with logging
LOGFILE="$BACKUP_DIR/backup.log"

echo "Starting backup of $SOURCE to $BACKUP_DIR at $(date)" >> "$LOGFILE"
rsync -avh --delete "$SOURCE/" "$BACKUP_DIR/" 2>&1 | tee -a "$LOGFILE"

# Check the exit status of rsync
if [ $? -eq 0 ]; then
  echo "Backup of $SOURCE completed successfully to $BACKUP_DIR" >> "$LOGFILE"
  echo "Backup of $SOURCE completed successfully to $BACKUP_DIR"
else
  echo "Backup of $SOURCE failed." >> "$LOGFILE"
  echo "Backup of $SOURCE failed."
  exit 1
fi
