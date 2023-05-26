#!/bin/bash
CHOICE=$(whiptail --menu "What would you like to do?" 18 100 10 \
	"SSH" "   Get into a Node" \
	"Exit" "   Terminate your Session safely" \
	3>&1 1>&2 2>&3)

if [[ -z "$CHOICE" ]];
then
	echo "Failure. Terminating."
	exit 500;
fi


if [[ $CHOICE == "SSH" ]];
then
	exec /ssh_hub/scripts/node_select.sh
fi

