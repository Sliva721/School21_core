#!/bin/bash

source ./functions.sh

get_hostname
get_timezone
get_user
get_os
get_date
get_uptime
get_uptime_seconds
get_ip
get_mask
get_gateway
get_ram_total
get_ram_used
get_ram_free
get_space_root
get_space_root_used
get_space_root_free

read -r -p "Save data to file (Y/N): " answer

if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
  filename=$(date +"%d_%m_%y_%H_%M_%S.status")
  {
    get_hostname
    get_timezone
    get_user
    get_os
    get_date
    get_uptime
    get_uptime_seconds
    get_ip
    get_mask
    get_gateway
    get_ram_total
    get_ram_used
    get_ram_free
    get_space_root
    get_space_root_used
    get_space_root_free
  } > "$filename"

echo "Data save to file: $filename"
else
  echo "Data is not saved"
fi