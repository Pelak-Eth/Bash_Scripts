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
printf "${Green}%`tput cols`s"|tr ' ' '#'
echo "
###### 			Welcome to Composer CMD Script 	  	  	  ######
######     	     	      Version Beta 0.1  	  	  	  ######
######			         @AUTHOR P	              	  	  ######";
printf "%`tput cols`s"|tr ' ' '#'
echo -e "Is your site path different than /var/www/sitename?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo -n "${White}${Bold} Enter Your FQDN path to your site root with leading / ONLY:  ";
read sitepath
break;;
        No ) 
echo -n "${White}${Bold} Enter Your Web Site Name With NO /, Default Path is /var/www/";
read defaultsitepath
sitepath=/var/www/$defaultsitepath
break;;
    esac
done
PS3='Please enter your choice: '
options=(
"${Red}${Bold}update:${Normal} Updates your dependencies to the latest version according to composer.json, and updates the composer.lock file." 
"${Red}${Bold}install:${Normal} Installs the project dependencies from the composer.lock file if present, or falls back on the composer.json." 
"${Red}${Bold}create-project:${Normal} Create new project from a package into given directory." 
"${Red}${Bold}diagnose:${Normal} Diagnoses the system to identify common errors."  
"${Red}${Bold}self-update:${Normal} Updates composer.phar to the latest version." 
"${Red}${Bold}require:${Normal} Adds required packages to your composer.json and installs them"  
"${Red}${Bold}Quit:${Normal} Exits Script")
select opt in "${options[@]}"
do
    case $opt in
        "${Red}${Bold}update:${Normal} Updates your dependencies to the latest version according to composer.json, and updates the composer.lock file.")
            echo "Checking for updated packages now"
		php $sitepath/composer.phar update
            ;;
	"${Red}${Bold}install:${Normal} Installs the project dependencies from the composer.lock file if present, or falls back on the composer.json.")
            echo "Installing dependencies now"
		php $sitepath/composer.phar install
            ;;
	"${Red}${Bold}create-project:${Normal} Create new project from a package into given directory.")
	    echo "Creating Project in selected directory"
		php $sitepath/composer.phar create-project
	    ;;
        "${Red}${Bold}diagnose:${Normal} Diagnoses the system to identify common errors.")
            echo "Diagnosing system now"
		php $sitepath/composer.phar diagnose
            ;;
        "${Red}${Bold}self-update:${Normal} Updates composer.phar to the latest version.")
            echo "Updating Composer.phar now"
		php $sitepath/composer.phar self-update
            ;;
        "${Red}${Bold}require:${Normal} Adds required packages to your composer.json and installs them")
            echo "Enter Package name:"
		php $sitepath/composer.phar require
            ;;
        "${Red}${Bold}Quit:${Normal} Exits Script")
            break
            ;;
        *) echo invalid option;;
    esac
done

