#!/bin/bash

# check color
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

# color output
function colored_output {
    local title="$1"
    local value="$2"
    local bg_title="$3"
    local fg_title="$4"
    local bg_value="$5"
    local fg_value="$6"

    # title color
    tput setab "$bg_title"  
    tput setaf "$fg_title"  
    echo -n "$title"

    # clear color
    tput sgr0  
    
    # not color
    echo -n " = " 

    # value color
    tput setab "$bg_value"
    tput setaf "$fg_value"
    echo " $value"  

    # clear color
    tput sgr0  
}
