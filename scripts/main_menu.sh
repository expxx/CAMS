#!/bin/bash

if id -nG $(whoami) | grep -qw "hub-admin"; then
    CHOICE=$(dialog --backtitle "Menu" \
        --title "What would you like to do?" \
        --menu "Choose an option:" 18 100 10 \
        "SSH" "Get into a Node" \
        "Admin Panel" "Access the Administrative Panel" \
        "Setup the System" "Run the setup script" \
        "Exit" "Terminate your Session safely" \
        3>&1 1>&2 2>&3)
else
    CHOICE=$(dialog --backtitle "Menu" \
        --title "What would you like to do?" \
        --menu "Choose an option:" 18 100 10 \
        "SSH" "Get into a Node" \
        "Setup the System" "Run the setup script" \
        "Exit" "Terminate your Session safely" \
        3>&1 1>&2 2>&3)
fi

if [[ -z "$CHOICE" ]]; then
    echo "Failure. Terminating."
    exit 500
fi

if [[ $CHOICE == "SSH" ]]; then
    exec /ssh_hub/scripts/node_select.sh
elif [[ $CHOICE == "Admin Panel" ]]; then
    exec /ssh_hub/scripts/admin/admin-panel.sh
elif [[ $CHOICE == "Setup the System" ]]; then
    exec /ssh_hub/scripts/encryption_runner.sh
fi
