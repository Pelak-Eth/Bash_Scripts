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
###### 			Welcome to Doctrine CMD Script 	  	  	  ######
######     	     	      Version Beta 0.1  	  	  	  ######
######			         @AUTHOR P	              	  	  ######";
printf "%`tput cols`s"|tr ' ' '#'
echo -e "${White}${Bold} Is your site path different than /var/www/sitename?";
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
cd $sitepath/vendor/doctrine/doctrine-module/bin
PS3='Please enter your choice: '
options=(
"${Red}${Bold}Info:${Normal} Show basic information about all mapped entities."
"${Red}${Bold}Validate-Schema:${Normal} Validate the mapping files." 
"${Red}${Bold}Create-Schema:${Normal} Processes the schema and either create it directly on EntityManager Storage Connection or generate the SQL output." 
"${Red}${Bold}Update-Schema:${Normal} Executes (or dumps) the SQL needed to update the database schema to match the current mapping metadata." 
"${Red}${Bold}Ensure-production-settings:${Normal} Verify that Doctrine is properly configured for a production environment." 
"${Red}${Bold}Drop:${Normal} Drop the complete database schema of EntityManager Storage Connection or generate the corresponding SQL output." 
"${Red}${Bold}Quit:${Normal} Exits Script")
select opt in "${options[@]}"
do
    case $opt in
	"${Red}${Bold}Info:${Normal} Show basic information about all mapped entities.")
		php doctrine-module orm:info
	    ;;
        "${Red}${Bold}Validate-Schema:${Normal} Validate the mapping files.")
            echo "Validating Schema now"
		php doctrine-module orm:validate-schema
            ;;
	"${Red}${Bold}Create-Schema:${Normal} Processes the schema and either create it directly on EntityManager Storage Connection or generate the SQL output.")
            echo "Creating Schema now"
		php doctrine-module orm:schema-tool:create
            ;;
        "${Red}${Bold}Update-Schema:${Normal} Executes (or dumps) the SQL needed to update the database schema to match the current mapping metadata.")
            echo "Updating Schema now"
		php doctrine-module orm:schema-tool:update
            ;;
        "${Red}${Bold}Ensure-production-settings:${Normal} Verify that Doctrine is properly configured for a production environment.")
            echo "you chose choice 3"
		php doctrine-module orm:ensure-production-settings
            ;;
        "${Red}${Bold}Drop:${Normal} Drop the complete database schema of EntityManager Storage Connection or generate the corresponding SQL output.")
            echo "Control C if you did this by accident ASAP!, Dropping Database Schema now"
		php doctrine-module orm:schema-tool:drop
            ;;
        "${Red}${Bold}Quit:${Normal} Exits Script")
            break
            ;;
        *) echo invalid option;;
    esac
done
