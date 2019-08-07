#!/bin/bash
set -e

sudo apt-get -y install build-essential debhelper pandoc shunit2 xdotool
rm -rf ~/.jumpapp
git clone https://github.com/mkropat/jumpapp.git ~/.jumpapp
cd ~/.jumpapp
make deb
sudo dpkg -i jumpapp*all.deb
sudo apt-get install -f
