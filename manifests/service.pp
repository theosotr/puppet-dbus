#
class dbus::service {

  $restart    = $::dbus::service_restart
  $hasrestart = $restart ? {
    undef   => true,
    default => false,
  }

  service { $::dbus::service_name:
    ensure     => running,
    enable     => $::dbus::service_enable,
    hasstatus  => true,
    hasrestart => $hasrestart,
    restart    => $restart,
  }
}
