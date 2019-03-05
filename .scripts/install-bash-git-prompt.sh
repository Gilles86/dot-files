#!/bin/bash
set -e

rm -rf ~/.bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

CFG="
GIT_PROMPT_ONLY_IN_REPO=1
[[ -s ~/.bash-git-prompt/gitprompt.sh ]] && source ~/.bash-git-prompt/gitprompt.sh
"
grep -qF -- "GIT_PROMPT_ONLY_IN_REPO" ~/.bashrc || echo "$CFG" >> ~/.bashrc 
