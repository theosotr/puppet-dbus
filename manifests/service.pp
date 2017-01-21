# @!visibility private
class dbus::service {

  service { $::dbus::service_name:
    ensure     => running,
    enable     => $::dbus::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
