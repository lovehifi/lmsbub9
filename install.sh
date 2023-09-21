#!/bin/bash

hostname=$(hostname)
replacement="http://${hostname}"

tar -xzvf menu-mat.tgz -C /opt/logitechmediaserver-git/prefs/
tar -xzvf switchserver.tgz -C /opt/logitechmediaserver-git/HTML/EN/
tar -xzvf bub-v9.tgz -C /srv/http/

if [ -f "/srv/http/assets/js/main.js" ]; then
sed -i "s|https://github.com/rern/rAudio/discussions|${replacement}:9000|g" /srv/http/assets/js/main.js
sed -i "s|http://raudio.local|${replacement}|g" /opt/logitechmediaserver-git/prefs/material-skin/actions.json
echo "Completed."
else
echo "File not found. Skipping..."
fi

systemctl daemon-reload
systemctl restart logitechmediaserver-git.service

