#!/bin/bash
set -e

mkdir -p ~/.amin
wget --no-check-certificate https://github.com/neovim/neovim/archive/master.zip -O ~/.amin/nvim.zip

apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip python python-pip
unzip -x ~/.amin/nvim.zip -d ~/.amin

(cd ~/.amin/neovim-master && make CMAKE_BUILD_TYPE=Release)
mkdir -p ~/.amin/neovim-master/nvim
wget --no-check-certificate -O ~/.amin/neovim-master/nvim/init.vim  https://raw.githubusercontent.com/aminroosta/dot-files/master/.config/nvim/init2.vim

pip install neovim
echo "alias vv='VIMRUNTIME=~/.amin/neovim-master/runtime  ~/.amin/neovim-master/build/bin/nvim -u ~/.amin/neovim-master/nvim/init.vim'" >> ~/.bashrc 
source ~/.bashrc

VIMRUNTIME=~/.amin/neovim-master/runtime  ~/.amin/neovim-master/build/bin/nvim -u ~/.amin/neovim-master/nvim/init.vim
VIMRUNTIME=~/.amin/neovim-master/runtime  ~/.amin/neovim-master/build/bin/nvim -u ~/.amin/neovim-master/nvim/init.vim -c q "helptags ~/.amin/neovim-master/runtime/doc/"

~/.amin/neovim-master/nvim/plugged/YouCompleteMe/install.py --clang-completer
