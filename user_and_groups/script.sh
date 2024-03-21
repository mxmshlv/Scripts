#!/bin/bash

# Function for preventing running another instance of this script
#prevent_function () {

    # Lock file path
#    LOCK_FILE="/apps/scripts/ug_creation_script.pid"

    # Check if another instance of the script is running
#    if [ -f "$LOCK_FILE" ]; then
#        # Read the PID from the lock file
#        pid=$(cat "$LOCK_FILE")

        # Check if the process corresponding to the PID is running
#        if ps -p "$pid" >/dev/null; then
#            echo "Script is already running with PID $pid. Exiting..."
#            exit 1
#        else
            # Remove stale lock file
#            rm -f "$LOCK_FILE"
#        fi
#    fi
#}

    # Get the current process ID
    current_pid=$$

    # Write the current PID to the lock file
    echo "$current_pid" >"$LOCK_FILE"
}

check_function () {
    # Check if a group or user exists
    if getent "$1" "$2" > /dev/null 2>&1; then
        return 0  # exists
    else
        return 1  # does not exist
    fi
}

create_group_function () {
    # Create a new group
    if ! check_function group "$1"; then
        sudo groupadd "$1"
        echo "Group '$1' created successfully."
    else
        echo "Error: Group '$1' already exists."
    fi
}

create_user_function () {
    # Create a new user and add to a group
    if ! check_function passwd "$1"; then
        sudo useradd -m "$1" -G "$2"
        echo "User '$1' created and added to group '$2' successfully."
    else
        echo "Error: User '$1' already exists."
    fi
}

# Script
# while true; do

read -pr "Put the group name: " group_name
read -pr "Put the username: " user_name

create_group_function "$group_name"
create_user_function "$user_name" "$group_name"

#done