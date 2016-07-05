#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

if ! [ -f $(brew --prefix)/etc/dnsmasq.conf ]
then
  echo "  Installing local .dev for you."
  mkdir -pv $(brew --prefix)/etc/
  echo 'address=/.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
  sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
  sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
  sudo mkdir -v /etc/resolver
  sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
fi

exit 0
