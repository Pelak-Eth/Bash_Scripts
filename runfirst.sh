#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "You are located in $DIR"
echo "Do you want to create Symlinks to /usr/local/bin for all scripts?
This will allow you to call the script using just the name from anywhere"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
echo "Creating Symlinks Now.....";
# Array of scripts to be symlinked to /usr/local/bin
script_names=(

orm
server-install
ssh-key
c
java7install

)
#symlink all names listed in script_names array
for scriptname in "${script_names[@]}"
do
	echo "Making $scriptname executable"
	sudo chmod a+x $DIR/$scriptname.sh
	sudo ln -s $DIR/$scriptname.sh /usr/local/bin/$scriptname
done
echo "Symlinking Complete
You may now call each script from anywhere!
Example type: orm [ENTER]"
break;;
        No ) exit;;
    esac
done
