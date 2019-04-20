#!/bin/bash
set -e

cd ~/
rm -rf ~/.nvim/
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz
rm nvim-macos.tar.gz
mv nvim-osx64 ~/.nvim
grep -q 'nvim/bin' ~/.bashrc || echo 'export PATH="~/.nvim/bin:$PATH"' >> ~/.bashrc
grep -q 'alias v=nvim' ~/.bashrc || echo 'alias v=nvim' >> ~/.bashrc
brew install python
brew install python@2
pip install pynvim
pip3 install pynvim

