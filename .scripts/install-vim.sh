#!/usr/bin/env bash
[ `whoami` = root ] || exec su -c $0 root
set -e

rm -rf ~/.vim-src
git clone --depth 1 https://github.com/vim/vim.git ~/.vim-src

apt-get install -y libgc-dev

cd ~/.vim-src
./configure

make -j4
make install
mv src/vim /usr/bin/vim

cd -
rm -rf ~/.vim-src



