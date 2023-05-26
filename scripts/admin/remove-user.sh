#!/bin/bash

NAME=$(dialog --backtitle "User Removal" \
    --inputbox "Please enter the name of the user you'd like to remove:" 10 100 3>&1 1>&2 2>&3)

if [[ $NAME == "" ]]; then
    echo "Failure."
    /ssh_hub/scripts/main_menu.sh
    exit 500
fi

usehub=false
if dialog --backtitle "User Removal" \
    --yesno "Does this user use the Hub System?" 10 100; then
    rm -rf /ssh_hub/keys/$NAME
    usehub=true
fi

clear
killall -u $NAME

if [[ $usehub == true ]]; then
    echo "- Remove User (HUB)"
    userdel $NAME
    echo "- Removing Home Dir (HUB)"
    rm -rf /home/$NAME
    echo ""
    echo " --- HUB COMPLETE --- "
    echo ""
fi

echo "- Terminating anything run by user (BACKEND)"
# Execute the command on each remote system using SSH
for remote_system in "${REMOTE_SYSTEMS[@]}"; do
    ssh "$remote_system" "killall -u $NAME"
done

echo "- Remove User (BACKEND)"
# Execute the command on each remote system using SSH
for remote_system in "${REMOTE_SYSTEMS[@]}"; do
    ssh "$remote_system" "userdel $NAME"
done

echo "- Removing Home Dir (BACKEND)"
# Execute the command on each remote system using SSH
for remote_system in "${REMOTE_SYSTEMS[@]}"; do
    ssh "$remote_system" "rm -rf /home/$NAME"
done

dialog --backtitle "User Removal" \
    --msgbox "Done!" 10 100

/ssh_hub/scripts/main_menu.sh
exit 500
