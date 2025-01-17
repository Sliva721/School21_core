#!/bin/bash

# set color
function set_color {
    case "$1" in
        1) echo 7 ;;  # белый
        2) echo 1 ;;  # красный
        3) echo 2 ;;  # зеленый
        4) echo 4 ;;  # синий
        5) echo 5 ;;  # фиолетовый
        6) echo 0 ;;  # черный
        *) echo "Error: incorrect color." ; exit 1 ;; 
    esac
}

# colored output
function colored_output {
    local title="$1"
    local value="$2"
    local bg_title="$(set_color "$3")"
    local fg_title="$(set_color "$4")"
    local bg_value="$(set_color "$5")"
    local fg_value="$(set_color "$6")"

# color title
tput setab "$bg_title"  
tput setaf "$fg_title"  
echo -n "$title"

# clear color
tput sgr0  

# not color
echo -n " = " 

# color value 
tput setab "$bg_value"
tput setaf "$fg_value"
echo "$value"  

# clear color
tput sgr0
}