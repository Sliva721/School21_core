#!/bin/bash

source ./functions.sh
source ./colored_output.sh

# check input only 4 numbers arguments
if [ "$#" -ne 4 ]; then
    echo "Error: 4 numeric arguments are required (1-6)"
    exit 1
fi

# chech input numbers 1-6
for arg in "$@"; do
    if ! [[ "$arg" =~ ^[1-6]$ ]]; then
        echo "Error: only numbers from 1 to 6."
        exit 1
    fi
done

# check colors bg and fnt
if [[ "$1" == "$2" || "$3" == "$4" ]]; then
    echo "Error: The background and font colors should not match."
    exit 1
fi 

# save colors to array
colors=()
colors+=("$(set_color "$1")")
colors+=("$(set_color "$2")")
colors+=("$(set_color "$3")")
colors+=("$(set_color "$4")")

# name array
names=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SECONDS" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")

# cycle cut output string and colored
for name in "${names[@]}"; do
    value="$(get_"${name,,}" | cut -d'=' -f2 | xargs)" 
    colored_output "$name" "$value" "${colors[@]}"
done
