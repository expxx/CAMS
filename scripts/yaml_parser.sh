#!/bin/bash

# Function to extract value for a given YAML key
get_yaml_value() {
    local key="$1"
    local file="$2"
    grep "^$key:" "$file" | awk '{print substr($0, index($0,$2))}' | sed 's/^[ \t]*//;s/[ \t]*$//'
}

# Read and parse YAML configuration file
config_file="/ssh_hub/conf/config.yml"

# Get server information
server_count=$(grep -c "^servers:" "$config_file")
for ((i=1; i<=server_count; i++)); do
    ip=$(get_yaml_value "servers[$i].ip" "$config_file")
    port=$(get_yaml_value "servers[$i].port" "$config_file")

    export SERVER_IP_$i=$ip
    export SERVER_PORT_$i=$port
done
