#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "hosts" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms . ~
  cat hosts /etc/hosts | sort -u > /tmp/hosts ; sudo cp /tmp/hosts /etc/hosts
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
source ~/.bash_profile

