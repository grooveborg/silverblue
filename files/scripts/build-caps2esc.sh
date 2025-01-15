#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

dnf -y install \
  boost-devel \
  cmake \
  gcc-c++ \
  git \
  libevdev-devel \
  systemd-devel \
  yaml-cpp-devel

# Build interception-tools
git clone --depth 1 https://gitlab.com/interception/linux/tools.git interception-tools
cd interception-tools && cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build
mkdir /out && mv build/{intercept,mux,udevmon,uinput} /out

# Build caps2esc
git clone --depth 1 https://gitlab.com/interception/linux/plugins/caps2esc.git
cd caps2esc && cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build
mv build/caps2esc /out
