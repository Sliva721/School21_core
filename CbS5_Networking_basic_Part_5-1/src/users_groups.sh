#!/bin/bash
 
#Debugging
#set -n
#set +x

# Checking root start
if [ "$(whoami)" != "root" ]; then
  echo "Start only root." 
  exit 1
fi


groupadd default_users
useradd -m -G default_users user
passwd -d user

groupadd secret_users
for username in secret_agent secret_spy secret_boss; do
    useradd -m -G secret_users "$username"
    passwd -d "$username"
    # password="1" 
    # echo "$username:$password" | sudo chpasswd
done 

chmod 770 /home/secret_agent
chmod 770 /home/secret_spy
chmod 770 /home/secret_boss

chown :secret_users /home/secret_agent
chown :secret_users /home/secret_spy
chown :secret_users /home/secret_boss

chmod 777 /var

# checking Internet connect
if ! ping -c 1 google.com &> /dev/null; then
  echo "Not connect Inetnet!"
fi

# Installation apache2
apt-get update
apt-get install -y apache2

# Check apache2
   systemctl --no-pager status apache2

# No passwd
echo "%default_users ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/default_users

# Finish
echo "Full complete!"