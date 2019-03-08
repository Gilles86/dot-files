#!/bin/bash
set -e

rm -rf ~/.git-so-fancy
git clone https://github.com/so-fancy/diff-so-fancy.git ~/.git-so-fancy
git config --global core.pager "~/.git-so-fancy/diff-so-fancy | less --tabs=4 -RFX"

# Improved colors for the highlighted bits
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
