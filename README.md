# haproxy

[![Ansible Galaxy](https://img.shields.io/badge/galaxy-diodonfrost.haproxy-660198.svg)](https://galaxy.ansible.com/diodonfrost/haproxy)
[![Build Status](https://travis-ci.org/diodonfrost/ansible-role-haproxy.svg?branch=master)](https://travis-ci.org/diodonfrost/ansible-role-haproxy)

This role provide compliance for install and setup haproxy on your target host.

## Requirements

This role was developed using Ansible 2.4 Backwards compatibility is not guaranteed.
Use `ansible-galaxy install diodonfrost.haproxy` to install the role on your system.

Supported platforms:

```yaml
- name: EL
  versions:
    - 7
    - 6
- name: Fedora
  versions:
    - 29
    - 28
    - 27
    - 26
- name: Debian
  versions:
    - stretch
    - jessie
- name: Ubuntu
  versions:
    - bionic
    - xenial
    - trusty
    - precise
- name: OracleLinux
  versions:
    - 7
    - 6
- name: Amazon
  versions:
    - 2017.12
    - 2016.03
- name: opensuse
  versions:
    - 42.3
    - 42.2
    - 42.1
- name: SLES
  versions:
    - 11
    - 12
    - 15
- name: ArchLinux
  versions:
    - any
- name: Gentoo
  versions:
    - stage3
- name: FreeBSD
  versions:
    - 12.0
    - 11.2
    - 10.4
    - 10.3
- name: OpenBSD
  versions:
    - 6.0
    - 6.4
```

## Role Variables

This role has multiple variables. The defaults for all these variables are the following:

```yaml
---
# Install haproxy
# Default is 'true'
haproxy_install: true

# defaults file for ansible-role-haproxy
haproxy_global_options:
  log: 127.0.0.1 local2
  chroot: /var/lib/haproxy
  pidfile: /var/run/haproxy.pid
  maxconn: 4000
  user: haproxy
  group: haproxy
  daemon:
  stats: socket /var/run/haproxy.socks

haproxy_default_listen:
  - mode                    http
  - log                     global
  - retries                 3
  - maxconn                 3000

haproxy_defaults_options:
  - httplog
  - dontlognull
  - http-server-close
  - forwardfor except 127.0.0.0/8
  - redispatch

haproxy_defaults_timeouts:
  - http-request            10s
  - queue                   1m
  - connect                 10s
  - client                  1m
  - server                  1m
  - http-keep-alive         10s
  - check                   10s

# Add listen configuration
# Examples:
#haproxy_listen_config: |
#  listen app
#      bind        127.0.0.1:80
#      balance     roundrobin
#      option      forwardfor
#      server app1 app1:80 check
#      server app2 app2:80 check
haproxy_listen_config: |
  listen app
      bind 127.0.0.1:8080
      server app1 127.0.0.1:8080 check

# Add frontend configuration
# Examples:
#haproxy_frontend_config: |
#  frontend main
#      bind *:5000
#      default_backend  app
haproxy_frontend_config:

# Add backend configuration
# Examples:
#haproxy_backend_config: |
#  backend app2
#      balance     roundrobin
#      server  app3 127.0.0.1:5003 check
#      server  app4 127.0.0.1:5004 check
haproxy_backend_config:
```

## Dependencies

None

## Example Playbook

This is a sample playbook file for deploying the Ansible Galaxy haproxy role in a localhost and installing haproxy.

```yaml
---
- hosts: localhost
  remote_user: root
  roles:
    - role: diodonfrost.haproxy
```

#### Example with frontend and backend

```yaml
- hosts: localhost
  remote_user: root
  roles:
    - role: diodonfrost.haproxy
  vars:
    haproxy_listen_config:|
      listen int_espaceclient 1.1.1.1:9120
          balance     roundrobin
          option      forwardfor
          server intapp1 intapp1:9020 check
          server intapp2 intapp2:9020 check
```

## Local Testing

The preferred way of locally testing the role is to use Docker. You will have to install Docker on your system.

You can also use vagrant and Virtualbox with vagrant to run tests locally. You will have to install Virtualbox and Vagrant on your system.
 For all our tests we use test-kitchen.

Next install test-kitchen:

```shell
# Install dependencies
gem install bundler
bundle install
```

### Testing with Docker

```shell
# List all tests with kitchen
kitchen list

# fast test on one machine
kitchen test default-centos-7

# test on all machines
kitchen test

# for development, create environment
kitchen create default-centos-7

# Apply ansible playbook
kitchen converge default-centos-7

# Apply inspec tests
kitchen verify default-centos-7
```

### Testing with Virtualbox

```shell
# Specify kitchen
set KITCHEN_YAML=.kitchen-vagrant.yml

# fast test on one machine
kitchen test default-centos-7
```

### Testing Solaris

Solaris can only be test with Virtualbox provider,do not use 'kitchen test' command for testing. There 5 steps you will be using with test-kitchen as part of your workflow.

```shell
# Specify kitchen
set KITCHEN_YAML=.kitchen-solaris.yml

#  Deploy environment
kitchen create

# Apply playbook on Solaris
kitchen converge

# Apply inspec tests on Solaris
kitchen verify

# Destroy environment
kitchen destroy
```

## License

Apache 2

## Author Information

This role was created in 2018 by diodonfrost.
