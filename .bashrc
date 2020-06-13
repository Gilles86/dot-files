
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_alias ] && source ~/.bash_alias

[[ -s ~/.cargo/env ]] && source ~/.cargo/env
set -o vi

export VISUAL=vim
export EDITOR="$VISUAL"

# brew install bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

d() {
    w3m "https://www.vocabulary.com/dictionary/$1" | tail -n +13 | less
}

# expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# don't put duplicate lines in the history 
# ignore lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# append to history instead of overwriting it
shopt -s histappend
PROMPT_COMMAND='history -a' 
