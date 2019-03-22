#!/bin/bash
set -e
set -x

sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
git clone git@github.com:ggreer/the_silver_searcher.git ~/.ag
cd ~/.ag
./build.sh
sudo make install
