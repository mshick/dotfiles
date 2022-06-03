#!/bin/sh

source "${ZSH}/util/interactive"

info "running dnsmasq/install"

brew_prefix="$(brew --prefix)"
dnsmasq_conf_file="${brew_prefix}/etc/dnsmasq.conf"
dnsmasq_plist="/Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"
test_address="address=/.test/127.0.0.1"
localhost_address="address=/.localhost/127.0.0.1"

if ! [ -f "${brew_prefix}/etc/dnsmasq.conf" ]; then
  detail "creating dnsmasq.conf files and directories"
  mkdir -p "${brew_prefix}/etc/"
  touch "${dnsmasq_conf_file}"
  sudo mkdir /etc/resolver
fi

if ! [ "$(grep -q "^${test_address}" ${dnsmasq_conf_file})" ]; then
  detail "creating .test TLD"
  printf "\n${test_address}\n" >>"${dnsmasq_conf_file}"
  sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
else
  detail ".test TLD already exists, skipping"
fi

if ! [ "$(grep -q "^${localhost_address}" ${dnsmasq_conf_file})" ]; then
  detail "creating .localhost TLD"
  printf "\n${localhost_address}\n" >>"${dnsmasq_conf_file}"
  sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/localhost'
else
  detail ".localhost TLD already exists, skipping"
fi

if ! [ -f "${dnsmasq_plist}" ]; then
  detail "installing LaunchDaemon"
  sudo cp $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
  sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
fi

success "dnsmasq/install"

exit 0
