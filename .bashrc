
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

# BAT_THEME
export BAT_THEME=ansi-light

# don't put duplicate lines in the history 
# ignore lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# append to history instead of overwriting it
shopt -s histappend
PROMPT_COMMAND='history -a' 

if [ -n "$PS1" ]; then
    NEW_PROMPT_COMMAND='
        TRIMMED_PWD=${PWD: -40};
        TRIMMED_PWD=${TRIMMED_PWD:-$PWD}
    '

    if [ -n "$PROMPT_COMMAND" ]; then
        PROMPT_COMMAND="$PROMPT_COMMAND;$NEW_PROMPT_COMMAND"
    else
        PROMPT_COMMAND="$NEW_PROMPT_COMMAND"
    fi

    unset NEW_PROMPT_COMMAND

	# PS1='\[\033[1;30m\]\u:\[\033[1;32m\]$TRIMMED_PWD\[\033[1;30m\] $ '
	PS1='\[\033[1;32m\]$TRIMMED_PWD\[\033[1;30m\] $ '
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
