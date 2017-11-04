docker-proxy-relay
==================

A docker container to forward traffic to an NTLM HTTP proxy.

## Why?

To use linux behind http proxy at work.

1. start the container with [cntlm](http://cntlm.sourceforge.net/) and [redsocks](https://github.com/darkk/redsocks) inside
2. set up an iptable rules to redirect traffic to the container

## How to use it?

Download / clone the repository to build the container:

    docker build . -t docker-proxy-relay:1.0

Create _ntlm_proxy.config_ file with the set of parameters as below:

    domain=DOMAIN
    proxy_host=proxy.company.com
    proxy_port=8080
    proxy_user=username

Redirect outgoing HTTP traffic to the container, _iptables.sh_ contains very minimal setup for clean Centos 7 installation:

    ./iptables.sh
    
Start the container:

    ./docker_proxy.sh start

To stop the container:

    ./docker_proxy.sh stop
    ./iptables-clean.sh

To get status:

    ./docker_proxy.sh status

## Alternatives

[go-any-proxy](https://github.com/ryanchapman/go-any-proxy) may be an alternative.