#
define dbus::system (
  $content,
) {

  if ! defined(Class['::dbus']) {
    fail('You must include the dbus base class before using any dbus defined resources') # lint:ignore:80chars
  }

  validate_string($content)

  $validate_cmd = $::dbus::validate ? {
    true    => '/usr/bin/xmllint --noout --valid %',
    default => undef,
  }

  file { "${::dbus::system_dir}/${name}.conf":
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => $content,
    validate_cmd => $validate_cmd,
    notify       => Class['::dbus::service'],
  }
}
