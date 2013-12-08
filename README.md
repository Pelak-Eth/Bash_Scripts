USEFULL BASH SCRIPTS GO HERE
====================================
Run the runfirst.sh file to add these scripts to /usr/local/bin.  
Allows for calling the script by name from any location.
Scripts are more secure and no longer use su (possible security hole if script was compromised), sudo is used for each command requiring elevated privileges.

#INSTRUCTIONS:

CD to BashScripts directory
sudo chmod a+x runfirst.sh
./runfirst.sh
follow prompt
profit

#SCRIPT DESCRIPTIONS:

#server-install.sh:
  Will setup everything to get a new local hosted virtual host site setup
  @TODO add a few minor things, script is functioning
  Usage: server-install Follow prompts
  
  
#ssh-key.sh:
  Will setup an SSH key using rsa with key size 4096 and then append public key to server
  Usage: ssh-key  Follow prompts
  
#orm.sh:
  Will run Doctrine2 commands with a GUI prompt.  Default run location is /var/www/{YOURSITENAME}/vendor/bin/doctrine-module.  Prompted to change at start if needed.
  Usage: orm  Select numerical option from menu

#c.sh:
  Will run Composer commands with a GUI prompt.  Default run location is /var/www/{sitename}.  Prompted to change at start if needed.
  Usage: orm  Select numerical option from menu

#java7install.sh:
  Will install the newest oracle JDK 7 using repository ppa:webupd8team/java.  Also sets new JDK as default.
  Usage: java7install  Yes or No to install jdk 7
