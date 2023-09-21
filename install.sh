#!/bin/bash
if [ -e /root/*.tgz ]; then
rm -f /root/*.tgz
fi

echo "Download"
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/menu-mat.tgz
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/switchserver.tgz
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/bub-v9.tgz

echo "Install"
tar -xzvf menu-mat.tgz -C /opt/logitechmediaserver-git/prefs/
tar -xzvf switchserver.tgz -C /opt/logitechmediaserver-git/HTML/EN/
tar -xzvf bub-v9.tgz -C /srv/http/

hostname=$(hostname)
replacement="http://${hostname}"
if [ -f "/srv/http/assets/js/main.js" ]; then
sed -i "s|https://github.com/rern/rAudio/discussions|${replacement}:9000|g" /srv/http/assets/js/main.js
sed -i "s|http://raudio.local|${replacement}|g" /opt/logitechmediaserver-git/prefs/material-skin/actions.json
echo "Completed."
else
echo "File not found. Skipping..."
fi

echo "Restart LMS"
systemctl daemon-reload
systemctl restart logitechmediaserver-git.service

echo "Do you want to change your NAS connection config immediately with nano edit?"
read -p "Enter 'Yes' or 'No': " answer

echo "Do you want to change your NAS connection config immediately with nano edit?"
read -p "Enter 'Yes' or 'No': " answer

if [ "$answer" == "Yes" ]; then
    nano /srv/http/bub/config.inc.php
elif [ "$answer" == "No" ]; then
    echo "Continuing execution without changing the NAS connection config."
else
    echo "Invalid choice. Please enter 'Yes' or 'No'."
fi

echo "Install Finished"

# wget -O - https://raw.githubusercontent.com/lovehifi/lmsbub9/main/install.sh | sh
