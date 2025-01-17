#!/bin/bash

source ./functions.sh
source ./colored_output.sh

# default colors
DEFAULT_COLUMN1_BACKGROUND=1  # фон: белый
DEFAULT_COLUMN1_FONT_COLOR=6   # шрифт: черный
DEFAULT_COLUMN2_BACKGROUND=3   # фон: зеленый
DEFAULT_COLUMN2_FONT_COLOR=4   # шрифт: синий

# color names to output
declare -A COLOR_NAMES
COLOR_NAMES[1]="white"
COLOR_NAMES[2]="red"
COLOR_NAMES[3]="green"
COLOR_NAMES[4]="blue"
COLOR_NAMES[5]="purple"
COLOR_NAMES[6]="black"

# read cgf
config_file="config.cfg"

if [[ -f "$config_file" ]]; then
    source "$config_file"
else
    echo "Warning: config.cfg not found, using default colors."
fi

# Color matching check
if [[ "$column1_background" == "$column1_font_color" || "$column2_background" == "$column2_font_color" ]]; then
    echo "Error: The background color and the font color for the columns match. Fix it in config.cfg."
    exit 1
fi

# set colors (cfg or default)
bg1=${column1_background:-$DEFAULT_COLUMN1_BACKGROUND}
fg1=${column1_font_color:-$DEFAULT_COLUMN1_FONT_COLOR}
bg2=${column2_background:-$DEFAULT_COLUMN2_BACKGROUND}
fg2=${column2_font_color:-$DEFAULT_COLUMN2_FONT_COLOR}

# checking color value 
use_default_colors=false

if [[ -z "$column1_background" || -z "$column1_font_color" || -z "$column2_background" || -z "$column2_font_color" ]]; then
    use_default_colors=true
fi

# apply colors default
if $use_default_colors; then
    bg1=$DEFAULT_COLUMN1_BACKGROUND
    fg1=$DEFAULT_COLUMN1_FONT_COLOR
    bg2=$DEFAULT_COLUMN2_BACKGROUND
    fg2=$DEFAULT_COLUMN2_FONT_COLOR
fi

# save colors to array
colors=()
colors+=("$bg1")
colors+=("$fg1")
colors+=("$bg2")
colors+=("$fg2")

# names array to output
names=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SECONDS" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")

# cycle coloring value to output 
for name in "${names[@]}"; do
    value="$(get_"${name,,}" | cut -d'=' -f2 | xargs)" 
    colored_output "$name" "$value" "${colors[@]}"
done

# output text colors_shema cfg or defaults
if $use_default_colors; then
    echo -e "\nColumn 1 background = default (${COLOR_NAMES[$DEFAULT_COLUMN1_BACKGROUND]})"
    echo "Column 1 font color = default (${COLOR_NAMES[$DEFAULT_COLUMN1_FONT_COLOR]})"
    echo "Column 2 background = default (${COLOR_NAMES[$DEFAULT_COLUMN2_BACKGROUND]})"
    echo "Column 2 font color = default (${COLOR_NAMES[$DEFAULT_COLUMN2_FONT_COLOR]})"
else
    echo -e "\nColumn 1 background = $bg1 (${COLOR_NAMES[$bg1]})"
    echo "Column 1 font color = $fg1 (${COLOR_NAMES[$fg1]})"
    echo "Column 2 background = $bg2 (${COLOR_NAMES[$bg2]})"
    echo "Column 2 font color = $fg2 (${COLOR_NAMES[$fg2]})"
fi