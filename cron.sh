#!/bin/bash

# Define the cron job command
cron_command="30 10 * * 1 /home/kali/Desktop/backup_script.sh"

# Add the cron job to the user's crontab
(crontab -l -u kali 2>/home/kali/null; echo "$cron_command") | crontab -u kali -

# Check if the cron job was successfully added
if [ $? -eq 0 ]; then
    echo "Cron job added successfully."
else
    echo "Failed to add cron job."
fi

