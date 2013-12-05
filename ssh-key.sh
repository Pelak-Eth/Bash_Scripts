#!/bin/bash
echo -e "Do you wish to create an SSH-Key and upload it to your server?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Creating SSH Key with rsa and 4096 bit key";
ssh-keygen -t rsa -b 4096;
echo -n "Enter your SSH username and press [ENTER]: ";
read username;
echo -n "Enter IP of the SSH server you are connecting to and press [ENTER]: ";
read server;
echo "Enter your SSH login password to upload key to server";
ssh-copy-id $username@$server;
#echo "Removing .pub file for security";
#sudo rm /home/.ssh/id_rsa.pub
break;;
        No ) break;;
    esac
done
echo -e "Do you wish to edit the configuration of OPENSSH";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Change Password Authentication to no";
sudo nano /etc/ssh/sshd_config;
break;;
        No ) break;;
    esac
done
exit;
