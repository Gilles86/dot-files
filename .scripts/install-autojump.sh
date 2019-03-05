#!/bin/bash
set -e

mkdir -p ~/.tmp/
cd ~/.tmp/
rm  -rf autojump
git clone git://github.com/wting/autojump.git
cd autojump
./install.py
echo "[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh" >> ~/.bash_profile
# to uninstall run ./uninstall.py or ...
# rm -rf ~/.autojump

