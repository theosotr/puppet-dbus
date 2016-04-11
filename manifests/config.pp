#
class dbus::config {

  file { $::dbus::conf_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  file { $::dbus::session_conf:
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => template("dbus/${::osfamily}/session.conf.erb"),
    validate_cmd => $::dbus::validate ? { # lint:ignore:selector_inside_resource
      true    => '/usr/bin/xmllint --noout --valid %',
      default => undef,
    },
  }

  file { $::dbus::local_session_conf:
    ensure => absent,
  }

  file { $::dbus::session_dir:
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    recurse => true,
    purge   => $::dbus::purge_session_dir,
  }

  file { $::dbus::local_system_conf:
    ensure => absent,
  }

  file { $::dbus::system_conf:
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => template("dbus/${::osfamily}/system.conf.erb"),
    validate_cmd => $::dbus::validate ? { # lint:ignore:selector_inside_resource
      true    => '/usr/bin/xmllint --noout --valid %',
      default => undef,
    },
  }

  file { $::dbus::system_dir:
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    recurse => true,
    purge   => $::dbus::purge_system_dir,
  }
}
