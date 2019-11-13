# ONE-TIME SECRET - v0.10.1 (2018-06-27)

*Keep sensitive info out of your email & chat logs.*

## What is a One-Time Secret? ##

A one-time secret is a link that can be viewed only one time. A single-use URI.

## Why would I want to use it? ##

When you send people sensitive info like passwords and private links via email or chat, there are copies of that information stored in many places. If you use a one-time link instead, the information persists for a single viewing which means it can't be read by someone else later. This allows you to send sensitive information in a safe way knowing it's seen by one person only. Think of it like a self-destructing message.

## Dependencies

* Any recent Linux (I'm using CentOS 7)
* Ruby 2.4+
* Redis 2.6+

## Install Dependencies

    $ sudo yum install gcc gcc-c++ make libtool git ntp openssl-devel
    $ sudo yum install readline-devel libevent-devel libyaml-devel zlib-devel gmp-devel
    $ sudo yum install ruby ruby-devel redis

Build ruby from source because rhel/centos only has ruby 2.0.0 (ancient!)
https://www.ruby-lang.org/en/documentation/installation/#building-from-source
https://www.ruby-lang.org/en/downloads/

## Install One-Time Secret

    $ sudo adduser ots
    $ sudo mkdir /etc/onetime /var/log/onetime /var/run/onetime /var/lib/onetime
    $ sudo chown ots /etc/onetime /var/log/onetime /var/run/onetime /var/lib/onetime

    $ sudo su - ots
    $ gem install bundler -v '~>1'
    $ git clone https://github.com/btilton/onetimesecret.git
    $ cd onetimesecret
    $ bundle install --frozen --deployment --without=dev
    $ bin/ots init
    $ cp -R etc/* /etc/onetime/
    $ [edit settings in /etc/onetime/config]
    $ [edit settings in /etc/onetime/redis.conf]

    $ redis-server /etc/onetime/redis.conf
    $ bundle exec thin -e dev -R config.ru -p 7143 start


## Generating a global secret

We include a global secret in the encryption key so it needs to be long and secure. One approach for generating a secret:

    dd if=/dev/urandom bs=20 count=1 | openssl sha1

