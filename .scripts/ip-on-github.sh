#! /bin/bash

set -x

cd ~/
while true; do
    curl -s ifconfig.me > ~/.ip
    git add -f ./.ip
    git commit -q -m "update ip"
    git push
    sleep 10
done
