#!/bin/bash

IP=$1
USER=$2

KEY_PRIV_FILE="/ssh_hub/keys/$USER"
if [[ ! -f $KEY_PRIV_FILE ]];
then
	whiptail --msgbox "Somehow, your SSH Key Pair doesn't exist! Contact an Administrator." 10 100
	/ssh_hub/scripts/main_menu.sh
	exit 500;
fi

echo "Connecting."

ssh $USER@$IP -i $KEY_PRIV_FILE
#echo "ssh $USER@$IP -i $KEY_PRIV_FILE"
/ssh_hub/scripts/node_select.sh
exit 500;
