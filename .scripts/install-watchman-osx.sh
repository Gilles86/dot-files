#! /usr/bin/env bash
set -e
set +x

rm -rf ~/.watchman
git clone https://github.com/facebook/watchman.git ~/.watchman
cd ~/.watchman
git checkout v4.9.0  # the latest stable release
./autogen.sh
./configure --enable-lenient
make
sudo make install
