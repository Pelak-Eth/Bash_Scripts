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
###### 			Welcome to Fresh Server Setup 	  	  	  ######
######     	     	      Version Beta 0.1  	  	  	  ######
######			         @AUTHOR P	              	  	  ######";
printf "%`tput cols`s"|tr ' ' '#'
echo "This Script will help setup a lot of shit on this machine";
echo "${White}${Bold} Are you running from the correct location?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Good, starting prompts now";
break;;
        No ) exit;;
    esac
done
echo -e "\n\n\n\n"
echo -e "Do you wish to install web server using the newest versions of:
${Normal}--------------------------------------------
php5
apache2
libapache2-mod-php5
mysql-server
php5-mysql
--------------------------------------------"
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
break;;
        No ) break;;
    esac
done
echo -e "Do you wish to install and configure git?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Installing git now" 
sudo apt-get install git
echo "Setting up Git config";
# Set git user info
echo -n "Enter git username and press [ENTER]: ";
read username;
echo -n "Enter git email and press [ENTER]: ";
read email;
sudo git config --global user.name $username
sudo git config --global user.email $email
break;;
        No ) break;;
    esac
done
echo -e "Do you wish to setup a virtual host for your site?";
select yn in "Yes" "No"; do
    case $yn in
        Yes )

echo -n "Enter website directory name without www or .com and press [ENTER]: Default location is /var/www/";
read site;
echo -n "Enter local IP of virtual host server and press [ENTER]: @TODO finish ";
read siteip;
echo -n "Enter IPs allowed to access site, seperate multiple IPs with 1 space only: ";
read ip;
echo -n "Enter email for apache admin section and press [ENTER]: ";
read email;
if [ ! -d "/var/www/$site" ]; then
	sudo mkdir /var/www/$site
fi
echo -n "Enter your linux username and press [ENTER]: ";
read linuxuser;
sudo chown -R www-data:www-data /var/www/$site
sudo usermod -a -G www-data $linuxuser
# Create VirtualHost in default location /etc/apache2/site-available/
echo "<VirtualHost *:80>
        ServerAdmin $email
        ServerName $site.local
        DocumentRoot /var/www/$site/public
        RewriteEngine on
        <Directory /var/www/$site/public>
                Options Indexes FollowSymLinks
                DirectoryIndex index.php
                AllowOverride all
                Order allow,deny
                allow from $ip
        </Directory>
        <Location />
                RewriteEngine on
                RewriteCond %{REQUEST_FILENAME} -s [OR]
                RewriteCond %{REQUEST_FILENAME} -l [OR]
                RewriteCond %{REQUEST_FILENAME} -d
                RewriteRule ^.*$ - [NC,L]
                RewriteRule ^.*$ /index.php [NC,L]
        </Location>
        ErrorLog /var/www/$site/logs/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel debug

        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"  | sudo tee -a /etc/apache2/sites-available/$site.conf;
# Add the host to the hosts file
echo "Adding $site to your hosts file";
echo 127.0.0.1 $site.local | sudo tee -a /etc/hosts;
# Enable the site
echo "Enabling $site now";
sudo a2ensite $site.conf;
# Enable apache rewrite module
echo "Enabling Apache2 Rewrite Module";
sudo a2enmod rewrite;
#restart apache2
echo "Restarting Apache2 for sanity";
sudo service apache2 restart
#new site
echo "Your new site is available at http://$site.local";
break;;
        No ) break;;
    esac
done
#install PHP related packages
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "Do you wish to install PHP related packages for use with NetBeans?
--------------------------------------------
Composer Globally
PHP-Unit Testing\nDoctrine2 Globally
PHP Documentor
PHP Code Sniffer
PHP Mess Detector
API-Gen
PHP Project Wizard
--------------------------------------------"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
#install required packages first
sudo apt-get install php-pear curl php5 php5-cli
sudo pear config-set auto_discover 1
#Global Composer install
echo "Installing Composer Globally";
curl -sS https://getcomposer.org/installer | php;
sudo mv composer.phar /usr/local/bin/composer;
#PHP-UNIT
echo "Installing PHP-UNIT Testing";
sudo pear channel-discover pear.symfony.com;
sudo pear channel-discover pear.phpunit.de;
sudo pear install pear.phpunit.de/PHPUnit;
sudo pear install phpunit/PHPUnit_SkeletonGenerator;
#OR
#http://phpunit.de/manual/current/en/installation.html
#http://pear.phpunit.de/
#wget https://phar.phpunit.de/phpunit.phar;
#chmod +x phpunit.phar;
#mv phpunit.phar /usr/local/bin/phpunit;
#Doctrine
echo "Installing Doctrine Globally";
sudo pear channel-discover pear.doctrine-project.org;
sudo pear install doctrine/DoctrineORM-2.3.3;   
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
sudo pear channel-discover pear.apigen.org
sudo pear install pear.apigen.org/apigen;
#PHP Project Wizard
echo "Installing PHP Project Wizard (PPW)";
sudo pear install phpunit/ppw;
break;;
        No ) break;;
    esac
done
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "Do you wish to install composer dependencies:
--------------------------------------------
Zend Framework 2\ndoctrine-orm-module
bjy-authorize\nzfc-user
zfc-user-doctrine-orm
doctrine-module
zendframeworkzftool
zendpdf
--------------------------------------------"
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
tput setaf 7
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
tput setaf 1
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
sleep 3;
countdown;
sleep 1;
echo -e "\n\n\n\n"
asc3;
sleep 1;
echo -e "\n\n\n\n"
asc2;
sleep 1;
echo -e "\n\n\n\n"
asc1;
sleep 1;
echo -e "\n\n\n\n"
explosion;
sleep 5;
exit;
exit;
