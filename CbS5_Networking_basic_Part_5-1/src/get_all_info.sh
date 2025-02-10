#!/bin/bash
 
#Debugging

#set -n
#set +x

# Checking root start
if [ "$(whoami)" != "root" ]; then
  echo "Start only root." 
  exit 1
fi

# Info file
INFO_FILE="info"

# 1. Installing packets
{
echo "********************* Packets: **************************" 
dpkg --get-selections | awk '{print $1}'

# 2. Runing processes
echo -e "\n********************* Process: *********************"
ps aux | awk '{print $1, $2, $11}' | column -t

# 3. Open port`s`
echo -e "\n********************* Ports: ************************"
ss -tuln

# 4. Install cowsay и sl
echo -e "\nCowsay и Sl"

# checking Internet connect
if ! ping -c 1 google.com &> /dev/null; then
  echo "Not connect Inetnet!"
fi

# Install packets
apt-get install -y cowsay sl

# 5. Core and system versions
echo -e "\n********************* Core and OS: *********************" 
echo "Core: $(uname -r)"
echo "OS: $(awk 'NF {print $1, $2, $3}' /etc/issue)"
} >> $INFO_FILE

cat $INFO_FILE

# Archive
tar -cvf OS_RESULT.tar "$INFO_FILE"

# Checking arc error and del info
if [[ -f "OS_RESULT.tar" && $? -eq 0 ]]; then
  rm "$INFO_FILE"
else
  echo "Error archive. Abort"
  exit 1
fi

# Finish
echo "Full complete!"