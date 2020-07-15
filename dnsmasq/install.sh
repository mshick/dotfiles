#!/bin/sh

source "${ZSH}/util/interactive"

info "running dnsmasq/install"

if ! [ -f $(brew --prefix)/etc/dnsmasq.conf ]; then
  detail "installing local .test and .localhost TLDs"

  mkdir -pv $(brew --prefix)/etc/
  printf "address=/.test/127.0.0.1\naddress=/.localhost/127.0.0.1" > $(brew --prefix)/etc/dnsmasq.conf
  sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
  sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
  sudo mkdir -v /etc/resolver
  sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
  sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/localhost'
fi

success "dnsmasq/install"

exit 0
