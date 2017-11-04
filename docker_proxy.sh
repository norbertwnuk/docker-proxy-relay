#!/bin/bash

set -e

# defaults
domain=
proxy_user=
proxy_pass=
proxy_host=
proxy_port=

test -f ntlm_proxy.config && . ntlm_proxy.config

case "$1" in
start)
  read -p "$proxy_host:$proxy_port username: ($proxy_user) " input && proxy_user="${input:-$proxy_user}"
  read -s -p "$proxy_user@$proxy_host:$proxy_port password: " proxy_pass && echo

  docker run --name docker-proxy -d --net=host \
      -e username=$proxy_user \
      -e domain=$domain \
      -e password=$proxy_pass \
      -e proxy=$proxy_host:$proxy_port \
      docker-proxy-relay:1.0
  ;;
stop)
  docker stop docker-proxy || docker kill docker-proxy
  docker rm docker-proxy
  ;;
status)
  docker ps | head -1
  docker ps | grep docker-proxy
  ;;
*)
  cat <<EOF
Usage: $0 start
       $0 stop
       $0 status
EOF
  ;;
esac
