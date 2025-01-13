#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Hide desktop entries
apps=(
  /usr/share/applications/btop.desktop
  /usr/share/applications/fish.desktop
  /usr/share/applications/yelp.desktop
)
echo "Hiding desktop entries"
for desktop_entry in "${apps[@]}"
do
  printf "NoDisplay=true\n" >> "$desktop_entry"
done

# Enable automatic updates for rpm-ostree
echo "Enabling automatic updates for rpm-ostree"
sed -i -e '/AutomaticUpdatePolicy/s!^#!!' -e 's/none/stage/' /etc/rpm-ostreed.conf

# Remove GNOME Software from startup applications
echo "Removing GNOME Software from startup applications"
rm /etc/xdg/autostart/org.gnome.Software.desktop
