#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install Collision extension for Nautilus
echo "Installing Collision extension for Nautilus"
wget -nv -P /usr/share/nautilus-python/extensions https://github.com/GeopJr/Collision/raw/main/nautilus-extension/collision-extension.py

# Remove temperature units from Weather O'Clock shell extension
echo "Modifying Weather O'Clock shell extension"
sed -i 's|"")|"").replace(/.$/, "")|' /usr/share/gnome-shell/extensions/weatheroclock@CleoMenezesJr.github.io/extension.js
