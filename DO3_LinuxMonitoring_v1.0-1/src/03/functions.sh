#!/bin/bash

KILOBYTE=1024
MEGABYTE=$(($KILOBYTE * $KILOBYTE))  # 1 MB в KB
GB=1024  # 1 GB в MB

get_hostname() {
    echo "HOSTNAME = $HOSTNAME"
}

get_timezone() {
    echo "TIMEZONE=$(timedatectl | grep 'Time zone' | awk '{print $3, $4,$5}')"
}

get_user() {
    echo "USER=$(whoami)"
}

get_os() {
    echo "OS = $(awk 'NF {print $1, $2, $3}' /etc/issue)"
}

get_date() {
    echo "DATE = $(date +"%d %B %G %T")"
}

get_uptime() {
    echo "UPTIME=$(uptime -p)"
}

get_uptime_seconds() {
    echo "UPTIME_SEC=$(awk '{print $1}' /proc/uptime)"
}

get_ip() {
    echo "IP=$(ip a | grep -m 1 inet | awk '{print $2}')"
}

get_mask() {
    echo "MASK=$(ifconfig | grep -m 1 'netmask' | awk '{print $4}')"
}

get_gateway() {
    echo "GATEWAY=$(ip route | grep default | awk '{print $3}')"
}

get_ram_total() {
    echo "RAM_TOTAL=$(free -m | awk -v GB="$GB" 'NR==2 {printf("%.3f", $2/GB)}') GB"
}

get_ram_used() {
    echo "RAM_USED=$(free -m | awk -v GB="$GB" 'NR==2 {printf("%.3f", $3/GB)}') GB"
}

get_ram_free() {
    echo "RAM_FREE=$(free -m | awk -v GB="$GB" 'NR==2 {printf("%.3f", $4/GB)}') GB"
}

get_space_root() {
    echo "SPACE_ROOT=$(df -P / | awk -v MEGABYTE="$MEGABYTE" 'NR==2 {printf("%.2f", $2/MEGABYTE)}') MB"
}

get_space_root_used() {
    echo "SPACE_ROOT_USED=$(df -P / | awk -v MEGABYTE="$MEGABYTE" 'NR==2 {printf("%.2f", $3/MEGABYTE)}') MB"
}

get_space_root_free() {
    echo "SPACE_ROOT_FREE=$(df -P / | awk -v MEGABYTE="$MEGABYTE" 'NR==2 {printf("%.2f", $4/MEGABYTE)}') MB"
}