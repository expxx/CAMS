#!/bin/bash

# Generate SSH host key pair
ssh-keygen -t rsa -b 2048 -f /tmp/ssh_host_rsa_key -N "" -q

# Provide the echo command to add the public key to the global known_hosts file
echo ""
echo "To setup the system, run the following command as root on all remote servers:"
echo "echo \"$(cat /tmp/ssh_host_rsa_key.pub)\" >> /etc/ssh/ssh_known_hosts"
