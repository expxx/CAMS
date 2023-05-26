CHOICE=$(whiptail --menu "What would you like to do?" 18 100 10 \
	"Add a User" "   Add a user to the system" \
	"Remove a User" "   Remove a user from the system" \
	"Drop to Terminal" "   Drop to the terminal, you should rarely need to do this" \
	3>&1 1>&2 2>&3)

if [[ $CHOICE == "Add a User" ]];
then
	exec /ssh_hub/scripts/admin/make-user.sh;
	/ssh_hub/scripts/admin/admin-panel.sh
	exit 500;
elif [[ $CHOICE == "Remove a User" ]]; 
then
	exec /ssh_hub/scripts/admin/remove-user.sh;
	/ssh_hub/scripts/admin/admin-panel.sh
	exit 500;
elif [[ $CHOICE == "Drop to Terminal" ]];
then
	exec /bin/bash
	/ssh_hub/scripts/admin/admin-panel.sh
	exit 500;
else
	/ssh_hub/scripts/main_menu.sh
	exit 500;
fi
