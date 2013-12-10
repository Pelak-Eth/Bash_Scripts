#!/bin/bash
echo -e "Do you wish to install Java 7 in place of openjdk?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Adding Repository";
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
echo "Setting New Java as default";
sudo apt-get install oracle-java7-set-default
break;;
        No ) exit;;
    esac
done
exit;
