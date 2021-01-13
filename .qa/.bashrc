alias ll='ls -al'
alias v='vim'
alias P='ping 8.8.8.8'

export EDITOR=vim
export PGHOST=localhost
export PGPORT=5435
export PGUSER=postgres
export PGDATABASE=auth

psqlgrep() {
    local DBNAME="$(cat /home/nobody/.pg_service.conf | grep $1 | tr -d '[]')"
    psql service=${DBNAME}
}
restart_rpc() {                              
    sudo service bom_ropc restart            
    tail -f /var/log/httpd/bom-rpc_trace.log 
}

# top-up CR90000000 BTC 10
top-up () {
perl -MTest::MockTime=set_fixed_time -MBOM::User::Client -e '
    @ARGV==3 or die "top-up loginid currency amount\n";
    set_fixed_time(split /, */, $ENV{FIXED_TIME}) if $ENV{FIXED_TIME};
    my $trx=BOM::User::Client::get_instance({loginid=>$ARGV[0]})
    ->payment_legacy_payment(
        currency=>$ARGV[1],
        amount=>$ARGV[2],
        payment_type=>"ewallet",
        remark=>"tf",
        staff=>"tf",
    );
    print "your balance is now $ARGV[1] ".$trx->balance_after."\n";
' "$@"
}

tailit() {
    tail -f $(find /var/log/httpd/ | grep -v crypto | grep .log$) | sed -r 's/^\[.*?\]//'
}
watchit() {
    cd /home/git/regentmarkets/
    watchman-make -p "binary-websocket-api/**/*.pm" -t ws -p "bom-rpc/**/*.(pm|pl)" "bom-pricing/**/*.pm" "bom/**/*.pm" "bom-market/**/*.pm" -t rpcp -p "binary-backoffice/**/*.(pm|pl|t|cgi)" -t bo
}
alias dummy="node /home/git/regentmarkets/dummy-pr.js"

openmutt() {
    mutt -f /tmp/default.mailbox
}

install_k8s() {
    # install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    # install minikube
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    # install helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh && rm ./get_helm.sh
}


path_to_kubectl=$(which kubectl)
if [ -x "$path_to_kubectl" ] ; then
    alias k=kubectl
    source <(kubectl completion bash)
    source <(kubectl completion bash | sed s/kubectl/k/g)
fi

path_to_helm=$(which helm)
if [ -x "$path_to_helm" ] ; then
    alias h=helm
    source <(helm completion bash)
    source <(helm completion bash | sed s/helm/h/g)
fi

export GIT_PROMPT_ONLY_IN_REPO=1
[[ -s ~/.bash-git-prompt/gitprompt.sh ]] && source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"                                                                               
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm                                        
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -o vi

export PATH=$PATH:/home/git/regentmarkets/environment-manifests-qa/bin

