#!/bin/bash

# Step 1: Get the names of the critical files to be backed up
FILES=("new" )

# Step 2: Establish a TFTP connection with the local file server
#Variables
TFTP_SERVER="192.168.1.3" #the ip changes with every connection attempt

LOCAL_PATH="/home/kali/Desktop"


# Loop through files and upload to TFTP server
for FILE in "${FILES[@]}"
do
   tftp $TFTP_SERVER <<EOF
    put $LOCAL_PATH/$FILE  $FILE
    quit
EOF
done

# Step 3: Send the critical files to the file server
Absolute=`readlink -f new`

    if [[ $? -eq 0 ]]; then
      echo "File '$File' successfully backed up to TFTP server."
    else
        echo "Failed to backup file '$File' to TFTP server." >>  /home/kali/backup.log
        echo "Absolute path of file: $Absolute" >>  /home/kali/backup.log
        logger -p local0.error -t BackupScript "Failed to backup file '$File' to TFTP server. Check log file for details."
   fi


# Step 4: Push the critical files to a remote repository
# Navigate to the root directory of your local repository
#git_path= "/home/kali/admin"
#cp $Local_path/$FILE  $git_path
cd /home/kali/admin

# Add the files you want to push to the staging area
git add .

# Commit the changes to the local Git repository
git commit -m "Commit message"

# Push the changes to the remote repository
git push origin main


# Step 5: Generate a syslog message to inform the administrator about the backup status
logger -p local0.info -t BackupScript "Backup process completed successfully."



# Step 6: Kill the backup process if it exceeds the predefined time limit
upper_time_limit=3600 # in seconds
backup_pid=$!

sleep $upper_time_limit && kill -9 $backup_pid

#crontab -e -u administrator
#30 10 * * 1 /home/kali/Desktop/backup_script.sh


