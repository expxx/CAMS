#!/bin/bash

if id -nG $(whoami) | grep -qw "hub-admin";
then
	CHOICE=$(whiptail --menu "What would you like to do?" 18 100 10 \
		"SSH" "   Get into a Node" \
		"Admin Panel" "   Access the Administrative Panel" \
		"Exit" "   Terminate your Session safely" \
		3>&1 1>&2 2>&3)
else
        CHOICE=$(whiptail --menu "What would you like to do?" 18 100 10 \
                "SSH" "   Get into a Node" \
                "Exit" "   Terminate your Session safely" \
                3>&1 1>&2 2>&3)
fi

if [[ -z "$CHOICE" ]];
then
	echo "Failure. Terminating."
	exit 500;
fi


if [[ $CHOICE == "SSH" ]];
then
	exec /ssh_hub/scripts/node_select.sh
elif [[ $CHOICE == "Admin Panel" ]];
then
	exec /ssh_hub/scripts/admin/admin-panel.sh;
fi

