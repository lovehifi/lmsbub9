#!/bin/bash

hostname=$(hostname)
replacement="http://${hostname}"

tar -xzvf menu-mat.tgz -C /opt/logitechmediaserver-git/prefs/
tar -xzvf switchserver.tgz -C /opt/logitechmediaserver-git/HTML/EN/

if [ -f "/srv/http/assets/js/main.js" ]; then
    sed -i "s|https://github.com/rern/rAudio/discussions|${replacement}:9000|g" /srv/http/assets/js/main.js
	sed -i "s|http://raudio.local|${replacement}|g" /opt/logitechmediaserver-git/prefs/material-skin/actions.json
    echo "Completed."
else
    echo "File not found. Skipping..."
fi

# directory="/opt/logitechmediaserver-git/cache/InstalledPlugins/Plugins/MaterialSkin"
# if [ -d "$directory" ]; then
	# tar -xzvf menu-mat.tgz -C /opt/logitechmediaserver-git/prefs/
# else
    # echo "None"
# fi
