# @!visibility private
class dbus::service {

  service { $::dbus::service_name:
    ensure     => running,
    enable     => $::dbus::service_enable,
    restart    => $::dbus::service_restart,
    hasstatus  => true,
    hasrestart => true,
  }
}
