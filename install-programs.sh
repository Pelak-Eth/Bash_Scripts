#!/bin/bash
#Variables for INLINE text styling
Black=`tput setaf 0`
Red=`tput setaf 1`
Green=`tput setaf 2`
Yellow=`tput setaf 3`
Blue=`tput setaf 4`
Magenta=`tput setaf 5`
Cyan=`tput setaf 6`
White=`tput setaf 7`
Normal=`tput sgr0`
Underline=`tput smul`
Nounderline=`tput rmul`
Bold=`tput bold`
#End Variables for text styling
tput setaf 2
printf "%`tput cols`s"|tr ' ' '#'
echo "
###### 			Welcome to Fresh Mint Install 	  	  	  ######
######     	     	      Version Beta 0.1  	  	  	  ######
######			         @AUTHOR P	              	  	  ######";
printf "%`tput cols`s"|tr ' ' '#'
echo -e "\n\n\n\n"
echo -e "${Bold}${White} Do you wish to install the following programs?
--------------------------------------------
unetbootin
filezilla
transmission
gparted
--------------------------------------------${Normal}"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
# Array of apt-get shit to be installed
install_names=(

unetbootin
filezilla
transmission
gparted

)
#install from array, with default yes to prompts
for name in "${install_names[@]}"
do
	echo "${Bold}${Red} Installing $name ${Normal}"
        sudo apt-get install $name -y
done
break;;
        No ) break;;
    esac
done
#Install Dropbox
echo -e "\n\n\n\n"
echo -e "${Bold}${White} Do you wish to install Dropbox?${Normal}"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Installing python-gpgme to verify dropbox binary signatures"
sudo apt-get install python-gpgme
cd ~/Downloads
wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb
wait
echo "Download Complete, Installing Now"
sudo dpkg -i dropbox.deb
dropbox start
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd
break;;
        No ) break;;
    esac
done
#Install Truecrypt
echo -e "\n\n\n\n"
echo -e "${Bold}${White} Do you wish to install Truecrypt for uber security?${Normal}"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
cd ~/Downloads
wget -O - http://www.truecrypt.org/download/truecrypt-7.1a-linux-x64.tar.gz | tar xvz -C ~/Downloads
sudo ./truecrypt-7.1a-setup-x64
break;;
        No ) break;;
    esac
done
#Install Java 7 using webupd8team ppa
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
