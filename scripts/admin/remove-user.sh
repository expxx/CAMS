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
salt '*' cmd.run "killall -u $NAME"
echo "- Remove User (BACKEND)"
salt '*' user.delete $NAME remove=True force=True
echo "- Removing Home Dir (BACKEND)"
salt '*' cmd.run "rm -rf /home/$NAME"

dialog --backtitle "User Removal" \
    --msgbox "Done!" 10 100

/ssh_hub/scripts/main_menu.sh
exit 500