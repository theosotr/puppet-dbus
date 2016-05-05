# dbus

Tested with Travis CI

[![Build Status](https://travis-ci.org/bodgit/puppet-dbus.svg?branch=master)](https://travis-ci.org/bodgit/puppet-dbus)
[![Coverage Status](https://coveralls.io/repos/bodgit/puppet-dbus/badge.svg?branch=master&service=github)](https://coveralls.io/github/bodgit/puppet-dbus?branch=master)
[![Puppet Forge](http://img.shields.io/puppetforge/v/bodgit/dbus.svg)](https://forge.puppetlabs.com/bodgit/dbus)
[![Dependency Status](https://gemnasium.com/bodgit/puppet-dbus.svg)](https://gemnasium.com/bodgit/puppet-dbus)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dbus](#setup)
    * [What dbus affects](#what-dbus-affects)
    * [Beginning with dbus](#beginning-with-dbus)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Classes and Defined Types](#classes-and-defined-types)
        * [Class: dbus](#class-dbus)
        * [Defined Type: dbus::session](#defined-type-dbussession)
        * [Defined Type: dbus::system](#defined-type-dbussystem)
    * [Examples](#examples)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages D-Bus.

## Module Description

This module installs and manages the main dbus-daemon service as well as
installing additional system and/or session bus per-application configuration.

## Setup

### What dbus affects

* The package(s) containing D-Bus support.
* The service controlling the dbus-daemon daemon.
* Any system/session bus per-application configuration.

### Beginning with dbus

```puppet
include ::dbus
```

## Usage

### Classes and Defined Types

#### Class: `dbus`

**Parameters within `dbus`:**

##### `conf_dir`

The main configuration directory, usually `/etc/dbus-1`.

##### `local_session_conf`

The configuration file used to override the default session bus configuration,
usually `/etc/dbus-1/session-local.conf`.

##### `local_system_conf`

The configuration file used to override the default system bus configuration,
usually `/etc/dbus-1/system-local.conf`.

##### `package_name`

The name of the package to install that provides the D-Bus applications and
libraries.

##### `purge_session_dir`

Whether to purge any unmanaged session bus per-application configuration files.

##### `purge_system_dir`

Whether to purge any unmanaged system bus per-application configuration files.

##### `service_enable`

Whether to enable the service or not. On platforms that use systemd, the dbus
unit is marked static so can neither be disabled or enabled by the `service`
type.

##### `service_name`

The name of the service managing the `dbus-daemon` daemon.

##### `service_restart`

The command used to get `dbus-daemon` to reload its configuration, which is
usually `dbus-send --system --type=method_call --dest=org.freedesktop.DBus /
org.freedesktop.DBus.ReloadConfig`. On platforms that use systemd, this is what
the unit does anyway and so will rely on that where possible.

##### `session_conf`

The configuration file containing the default session bus configuration,
usually `/etc/dbus-1/session.conf`.

##### `session_dir`

The directory used by applications to add additional session bus configuration,
usually `/etc/dbus-1/session.d`.

##### `system_conf`

The configuration file containing the default system bus configuration,
usually `/etc/dbus-1/system.conf`.

##### `system_dir`

The directory used by applications to add additional system bus configuration,
usually `/etc/dbus-1/system.d`.

##### `validate`

Whether to validate the XML configuration files prior to installing them.

#### Defined Type: `dbus::session`

**Parameters within `dbus::session`:**

##### `content`

The contents of the file.

##### `name`

The name will be used to construct the filename of the form
`${session_dir}/${name}.conf`.

#### Defined Type: `dbus::system`

**Parameters within `dbus::system`:**

##### `content`

The contents of the file.

##### `name`

The name will be used to construct the filename of the form
`${system_dir}/${name}.conf`.

### Examples

To add the oddjob daemon to the system bus:

```puppet
include ::dbus

::dbus::system { 'oddjob':
  content => file('oddjob/oddjob.conf'),
}
```

## Reference

### Classes

#### Public Classes

* [`dbus`](#class-dbus): Main class for installing D-Bus software.

#### Private Classes

* `dbus::config`: Handles D-Bus configuration.
* `dbus::install`: Handles D-Bus installation.
* `dbus::params`: Different configuration data for different systems.
* `dbus::reload`: Handles reloading D-Bus configuration.
* `dbus::service`: Handles starting the dbus-daemon daemon.

### Defined Types

#### Public Defined Types

* [`dbus::session`](#defined-type-dbussession): Handles installing
  session bus per-application configuration.
* [`dbus::system`](#defined-type-dbussystem): Handles installing
  system bus per-application configuration.

### Facts

* `dbus_startup_provider`: Contains the value of the hosts init system.
  `systemd` on such systems, `init` otherwise.

## Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

* RedHat/CentOS Enterprise Linux 5/6/7
* Ubuntu 14.04
* Debian 7
* OpenBSD 5.9

Testing on other platforms has been light and cannot be guaranteed.

## Development

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-dbus).
