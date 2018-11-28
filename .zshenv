alias v='nvim'
alias btc='bitcoin-chart-cli'
alias P='ping 8.8.8.8'
alias jtags="ctags -R . && sed -i '' -E '/^(if|switch|function|module\.exports|it|describe).+language:js$/d' tags"
export PATH=~/Library/Android/sdk/platform-tools:$PATH
export PATH=/Applications/calibre.app/Contents/MacOS/:$PATH
export PATH=~/PostgreSQL/pg11/bin:$PATH
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_HOME="/usr/local/share/android-sdk"
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export ANDROID_NDK="/usr/local/share/android-ndk"
export JAVA_HOME='/Library/Java/Home/'

export GOROOT="/usr/local/opt/go/libexec"
export GOPATH="/Users/amin/.go"

export PATH="/Users/amin/projects/emsdk":$PATH
export PATH="/Users/amin/projects/emsdk/emscripten/1.38.20":$PATH
export PATH=$PATH:"/usr/local/opt/go/libexec/bin"
export PATH=$PATH:"/Users/amin/.go/bin"

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gbl='git blame -b -w'
alias gc='git commit'
alias gcb='git checkout -b'
alias gcl='git clone --recursive'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias glg='git log --stat --color'
alias glgg='git log --graph --color'
alias gm='git merge'
alias gp='git push'
alias gs='git status'
alias svg='svgo --pretty --disable=cleanupIDs '
alias gg='git -c color.grep.linenumber="bold yellow" -c color.grep.filename="bold green" grep --break --heading --line-number'
alias ydl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4"'
