#!/bin/bash
# Check if any .tgz files exist in /root/
if ls /root/*.tgz 1> /dev/null 2>&1; then
  # Remove each .tgz file
  for file in /root/*.tgz; do
    rm -f "$file"
  done
fi

echo "Download"
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/menu-mat.tgz
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/switchserver.tgz
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/bub-v9.tgz
wget https://raw.githubusercontent.com/lovehifi/lmsbub9/main/css.tgz

echo "Install"
mkdir -p /opt/logitechmediaserver-git/prefs/material-skin
tar -xzvf menu-mat.tgz -C /opt/logitechmediaserver-git/prefs/
tar -xzvf switchserver.tgz -C /opt/logitechmediaserver-git/HTML/EN/
tar -xzvf bub-v9.tgz -C /srv/http/
tar -xzvf css.tgz -C /srv/http/bub/

hostname=$(hostname)
replacement="http://${hostname}"
if [ -f "/srv/http/assets/js/main.js" ]; then
sed -i "s|https://github.com/rern/rAudio/discussions|${replacement}:9000|g" /srv/http/assets/js/main.js
sed -i "s|http://rAudio|${replacement}|g" /opt/logitechmediaserver-git/prefs/material-skin/actions.json
echo "Completed."
else
echo "File not found. Skipping..."
fi

echo "Restart LMS"
systemctl daemon-reload
systemctl restart logitechmediaserver-git.service

echo "Install Finished"
echo "--------------------"
echo "NAS connection config: username, password, connect URL"
echo "To change with nano: nano /srv/http/bub/config.inc.php"

# wget -O - https://raw.githubusercontent.com/lovehifi/lmsbub9/main/install.sh | sh
