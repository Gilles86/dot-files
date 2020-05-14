source ~/.bashrc

[[ -s ~/.cargo/env ]] && source ~/.cargo/env
set -o vi

export PATH="$HOME/.cargo/bin:$PATH"

export DENO_INSTALL="/Users/amin/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
