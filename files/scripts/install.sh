#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

os_version=$(awk -F= '/^VERSION_ID/ {print $2}' /etc/os-release)

# Replace default kernel with kernel-blu
wget -nv https://copr.fedorainfracloud.org/coprs/sentry/kernel-blu/repo/fedora-$os_version/sentry-kernel-blu-fedora-$os_version.repo -O /etc/yum.repos.d/kernel-blu.repo
rpm-ostree override replace \
  --experimental \
  --freeze \
  --from repo='copr:copr.fedorainfracloud.org:sentry:kernel-blu' \
    kernel \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra

# Replace multimedia packages to enable patent-encumbered codecs
rpm-ostree override replace \
  --experimental \
  --from repo=fedora-multimedia \
    libheif \
    libva \
    libva-intel-media-driver \
    mesa-dri-drivers \
    mesa-filesystem \
    mesa-libEGL \
    mesa-libGL \
    mesa-libgbm \
    mesa-libglapi \
    mesa-va-drivers \
    mesa-vulkan-drivers

# Install 7-Zip
echo "Installing 7-Zip"
api_url=https://api.github.com/repos/ip7z/7zip/releases/latest
download_url=$(curl -fsS $api_url | grep -o "https.*x64.*xz")
curl -fsSL "$download_url" | tar -xJf - -C /usr/bin 7zz

# Install chezmoi
echo "Installing chezmoi"
wget -nv https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-linux-amd64 -O /usr/bin/chezmoi
chmod 755 /usr/bin/chezmoi

# Install The Logfile Navigator
echo "Installing lnav"
api_url=https://api.github.com/repos/tstack/lnav/releases/latest
download_url=$(curl -fsS $api_url | grep -o "https.*x86_64.zip")
wget -nv -P /dev/shm/lnav "$download_url"
unzip -jqd /usr/bin /dev/shm/lnav/\* \*/lnav
