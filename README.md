USEFULL BASH SCRIPTS GO HERE
====================================
Run the runfirst.sh file to add these scripts to /usr/local/bin.  
Allows for calling the script by name from any location.
Scripts are more secure and no longer use su (possible security hole if script was compromised), sudo is used for each command requiring elevated privileges.

INSTRUCTIONS:

CD to BashScripts directory
./runfirst.sh
follow prompt
profit

SCRIPT DESCRIPTIONS:

server-install.sh:
  Will setup everything to get a new local hosted virtual host site setup
  @TODO add a few minor things, script is functioning
  
  
ssh-key:
  Will setup an SSH key using rsa with key size 4096 and then append public key to server
  
orm.sh:
  Will run Doctrine2 commands with a GUI prompt.  Commands are run from /var/www/<YOURSITENAME>/vendor/bin/doctrine-module
