#!/bin/bash
echo "################################################################################
###### 			Welcome to Fresh Server Setup 	  	  	  ######
######     	     	      Version Beta 0.1  	  	  	  ######
######			         @AUTHOR P	              	  	  ######
################################################################################";
echo -e "\n\n\n"
echo -e "Do you wish to install:\n--------------------------------------------\ngit\ncurl\nphp5\napache2\nlibapache2-mod-php5\nphp-pear\nmysql-server\nphp5-mysql?\n--------------------------------------------\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
# Array of apt-get shit to be installed
install_names=(

git
curl
php5
apache2
libapache2-mod-php5
php-pear
mysql-server
php5-mysql

)
#install from array, with default yes to prompts
for name in "${install_names[@]}"
do
        sudo apt-get install $name -y
done
echo -e "\n"
# Enable apache rewrite module
echo "Enabling Apache2 Rewrite Module";
sudo a2enmod rewrite
echo "Setting up Git config";
# Set git user info
echo -n "Enter git username and press [ENTER]: ";
read username;
echo -n "Enter git email and press [ENTER]: ";
read email;
sudo git config --global user.name $username
sudo git config --global user.email $email
echo -n "Enter and press [ENTER]: ";
read site_name;
#restart apache2
echo "Restarting Apache2 for sanity";
sudo service apache2 restart
break;;
        No ) break;;
    esac
done
#install PHP related packages
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "Do you wish to install PHP related packages:\n--------------------------------------------\nComposer Globally\nPHP-Unit Testing\nDoctrine2 Globally\nPHP Documentor\nPHP Code Sniffer\nPHP Mess Detector\nAPI-Gen\nPHP Project Wizard?\n--------------------------------------------"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
#Global Composer install
echo "Installing Composer Globally";
curl -sS https://getcomposer.org/installer | php;
sudo mv composer.phar /usr/local/bin/composer;
#PHP-UNIT
echo "Installing PHP-UNIT Testing";
sudo pear channel-discover pear.phpunit.de;
sudo pear install pear.phpunit.de/PHPUnit;
#OR
#http://phpunit.de/manual/current/en/installation.html
#http://pear.phpunit.de/
#wget https://phar.phpunit.de/phpunit.phar;
#chmod +x phpunit.phar;
#mv phpunit.phar /usr/local/bin/phpunit;
#Doctrine
echo "Installing Doctrine Globally";
sudo pear channel-discover pear.doctrine-project.org;
sudo pear install doctrine/DoctrineORM-2.3.4;   
echo "maybe 2.3.3";
#PHP Documentor
echo "Installing PHP Documentor";
sudo pear channel-discover pear.phpdoc.org;
sudo pear install phpdoc/phpDocumentor;
#PHP Code Sniffer
echo "Installing PHP Code Sniffer";
sudo pear install PHP_CodeSniffer;
#PHP Mess Detector
echo "Installing PHP Mess Detector";
sudo pear channel-discover pear.phpmd.org;
sudo pear channel-discover pear.pdepend.org;
sudo pear install --alldeps phpmd/PHP_PMD;
#API-GEN
echo "Installing Api-Gen";
sudo pear install pear.apigen.org/apigen;
#PHP Project Wizard
echo "Installing PHP Project Wizard (PPW)";
sudo pear install phpunit/ppw;
break;;
        No ) break;;
    esac
done
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "Do you wish to install composer dependencies:\n--------------------------------------------\nZend Framework 2\ndoctrine-orm-module\nbjy-authorize\nzfc-user\nzfc-user-doctrine-orm\ndoctrine-module\nzendframeworkzftool\nzendpdf?\n--------------------------------------------\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
echo -e "\n"
echo "Install Directory | Blank or error will install to current directory";
echo -e "\n"
echo -n "Enter FQDN directory to install dependencies and press [ENTER]: ";
read name;
cd $name;
php composer.phar self-update
php composer.phar require zendframework/zendframework:2.2.*
php composer.phar require doctrine/doctrine-module:0.*
php composer.phar require doctrine/doctrine-orm-module:0.*
php composer.phar require bjyoungblood/bjy-authorize:1.4.*
php composer.phar require zf-commons/zfc-user:dev-master
php composer.phar require zf-commons/zfc-user-doctrine-orm:~0.1,
php composer.phar require zendframework/zftool:dev-master
php composer.phar require zendframework/zendpdf:*
#php composer.phar require zendframework/zend-developer-tools:dev-master
php composer.phar install;
break;;
        No ) break;;
    esac
done;
hacked() {
cat <<"EOT"

 _   _   ____  _  ___  _______     _   _  __   __  _ _______________ 
| | | | / __ \| |/ / |/ /___ /  __| | | |_\ \ / / / |___ /___ /___  |
| |_| |/ / _` | ' /| ' /  |_ \ / _` | | '_ \ V /  | | |_ \ |_ \  / / 
|  _  | | (_| | . \| . \ ___) | (_| | | |_) | |   | |___) |__) |/ /  
|_| |_|\ \__,_|_|\_\_|\_\____/ \__,_| |_.__/|_|   |_|____/____//_/   
        \____/                                                       
 _   _   ____  _  ___  _______        ____  
| | | | / __ \| |/ / |/ /___ / _ __  |  _ \ 
| |_| |/ / _` | ' /| ' /  |_ \| '__| | |_) |
|  _  | | (_| | . \| . \ ___) | |    |  __/ 
|_| |_|\ \__,_|_|\_\_|\_\____/|_|    |_|    
        \____/                              


EOT
}
asd
countdown() {
cat <<"EOT"
  ____                            _             __        ___ _ _ 
 / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __  \ \      / (_) | |
| |   / _ \| '_ ` _ \| '_ \| | | | __/ _ \ '__|  \ \ /\ / /| | | |
| |__| (_) | | | | | | |_) | |_| | ||  __/ |      \ V  V / | | | |
 \____\___/|_| |_| |_| .__/ \__,_|\__\___|_|       \_/\_/  |_|_|_|
                     |_|                                          
 ____       _  __   ____            _                   _     _         _____ 
/ ___|  ___| |/ _| |  _ \  ___  ___| |_ _ __ _   _  ___| |_  (_)_ __   |___ / 
\___ \ / _ \ | |_  | | | |/ _ \/ __| __| '__| | | |/ __| __| | | '_ \    |_ \ 
 ___) |  __/ |  _| | |_| |  __/\__ \ |_| |  | |_| | (__| |_  | | | | |  ___) |
|____/ \___|_|_|   |____/ \___||___/\__|_|   \__,_|\___|\__| |_|_| |_| |____/ 
                                                                              
                              _       
 ___  ___  ___ ___  _ __   __| |___ _ 
/ __|/ _ \/ __/ _ \| '_ \ / _` / __(_)
\__ \  __/ (_| (_) | | | | (_| \__ \_ 
|___/\___|\___\___/|_| |_|\__,_|___(_)
                                     
EOT
}
asc3() {
cat <<"EOT"
 _____ 
|___ / 
  |_ \ 
 ___) |
|____/ 
      
EOT
}
asc2() {
cat <<"EOT"
 ____  
|___ \ 
  __) |
 / __/ 
|_____|
     
EOT
}
asc1() {
cat <<"EOT"
 _ 
/ |
| |
| |
|_|
   
EOT
}
explosion() {
cat <<"EOT"
                             ____                              
               ____  , -- -        ---   -.                    
            (((   ((  ///   //   '  \\-\ \  )) ))              
        ///    ///  (( _        _   -- \\--     \\\ \)         
     ((( ==  ((  -- ((             ))  )- ) __   ))  )))       
      ((  (( -=   ((  ---  (          _ ) ---  ))   ))         
         (( __ ((    ()(((  \\  / ///     )) __ )))            
                \\_ (( __  |     | __  ) _ ))                  
                          ,|  |  |                             
                         `-._____,-'                           
                         `--.___,--'                           
                           |     |                             
                           |    ||                             
                           | ||  |                             
                 ,    _,   |   | |                             
        (  ((  ((((  /,| __|     |  ))))  )))  )  ))           
      (()))       __/ ||(    ,,     ((//\     )     ))))       
---((( ///_.___ _/    ||,,_____,_,,, (|\ \___.....__..  ))--ool
           ____/      |/______________| \/_/\__                
          /                                \/_/|               
         /  |___|___|__                        ||     ___      
         \    |___|___|_                       |/\   /__/|     
         /      |   |                           \/   |__|/     
                                                               
EOT
}
hacked;
countdown;
asc3;
sleep 1;
asc2;
sleep 1;
asc1;
sleep 1;
explosion;
exit;
