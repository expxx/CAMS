#!/bin/bash

source /ssh_hub/scripts/ini_parser.sh
process_ini_file /ssh_hub/conf/nodes.conf
SECTIONS=$(crudini --get /ssh_hub/conf/nodes.conf | sed 's/:.*//')

array=()

for section in $SECTIONS
do
	name=$(get_value $section 'name')
	desc=$(get_value $section 'description')
	array+=("$name" "")
done

CHOICE=$(whiptail --title "Select a Machine" --menu "Select" 16 78 10 "${array[@]}" 3>&1 1>&2 2>&3)

if [[ $CHOICE == "" ]];
then
	echo "Cancelled."
	/ssh_hub/scripts/main_menu.sh
	exit 500;
fi

clear
echo "Working..."

for section in $SECTIONS
do
	name_file=$(get_value $section 'name')
	name_sel=$CHOICE
	if [[ $name_file == $name_sel ]];
	then
		IP=$(get_value $section 'ip')
		break;
	fi
done

exec /ssh_hub/scripts/connect_ssh.sh $IP $(whoami)
