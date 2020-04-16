#!/usr/bin/env bash
set -e


rm -rf ~/.w3m-source
git clone --depth 1 git@github.com:tats/w3m.git ~/.w3m-source

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "installing libgc on Linux ..."
    sudo apt-get install -y libgc-dev
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "installing libgc on MacOs ..."
    brew reinstall libgc
else
    echo "Unsupported OS" && exit 1
fi

cd ~/.w3m-source
./configure
make
echo "copying w3m on /usr/local/bin ..."
sudo cp ~/.w3m-source/w3m /usr/local/bin/
cd -
rm -rf ~/.w3m-source
