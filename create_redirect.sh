#!/usr/bin/env zsh
set -x
set -e

DIR=/home/saul/git/www.bluebird.sh
cd $DIR
git pull --rebase
echo "/$1\t$2" >> redirects.tsv
git add redirects.tsv
git commit -m "[redirects] add $1"
git push
