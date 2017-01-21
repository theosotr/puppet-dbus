# dbus

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-dbus.svg?branch=master)](https://travis-ci.org/bodgit/puppet-dbus)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-dbus/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-dbus?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/dbus.svg)](https://forge.puppetlabs.com/bodgit/dbus)
[![Dependency Status](https://gemnasium.com/bodgit/puppet-dbus.svg)](https://gemnasium.com/bodgit/puppet-dbus)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dbus](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dbus](#beginning-with-dbus)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages D-Bus.

RHEL/CentOS, Ubuntu, Debian and OpenBSD are supported using Puppet 4.4.0 or
later.

## Setup

### Setup Requirements

You will need pluginsync enabled.

### Beginning with dbus

In the very simplest case, you can just include the following:

```puppet
include ::dbus
```

## Usage

To add the oddjob daemon to the system bus:

```puppet
include ::dbus

::dbus::system { 'oddjob':
  content => file('oddjob/oddjob.conf'),
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-dbus/](https://bodgit.github.io/puppet-dbus/).

## Limitations

This module has been built on and tested against Puppet 4.4.0 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6/7
* Ubuntu 14.04/16.04
* Debian 7/8
* OpenBSD 6.0

## Development

The module has both [rspec-puppet](http://rspec-puppet.com) and
[beaker-rspec](https://github.com/puppetlabs/beaker-rspec) tests. Run them
with:

```
$ bundle exec rake test
$ PUPPET_INSTALL_TYPE=agent PUPPET_INSTALL_VERSION=x.y.z bundle exec rake beaker:<nodeset>
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-dbus).
