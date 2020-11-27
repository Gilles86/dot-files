#!/usr/bin/env bash
set -e

rm -rf ~/.vim-src
git clone --depth 1 https://github.com/vim/vim.git ~/.vim-src

sudo apt-get udpate
sudo apt-get install -y libgc-dev libncurses5-dev libncursesw5-dev curl

cd ~/.vim-src
./configure

make -j6
sudo make install
sudo mv src/vim /usr/bin/vim

cd -
rm -rf ~/.vim-src
curl https://raw.githubusercontent.com/aminroosta/dot-files/master/.vimrc  > ~/.vimrc
