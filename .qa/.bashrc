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
    watchman-make -p "binary-websocket-api/**/*.pm" -t websocket -p "bom-rpc/**/*.(pm|pl)" "bom-pricing/**/*.pm" "bom/**/*.pm" "bom-market/**/*.pm" -t rpc_and_pricer -p "binary-backoffice/**/*.(pm|pl|t|cgi)" -t bo
}
alias dummy="node /home/git/regentmarkets/dummy-pr.js"

export SQL_CREATE_APP="insert into oauth.apps (name, binary_user_id, active, redirect_uri, scopes, verification_uri) values ('QA app', 1, true, 'https://staging.binary.com/en/logged_inws.html', '{read,admin,trade,payments}','https://staging.binary.com/en/redirect.html');"

openmutt() {
    mutt -f /tmp/default.mailbox
}

export GIT_PROMPT_ONLY_IN_REPO=1
[[ -s ~/.bash-git-prompt/gitprompt.sh ]] && source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"                                                                               
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm                                        
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

set -o vi
