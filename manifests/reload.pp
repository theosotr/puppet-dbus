#
class dbus::reload {

  exec { $::dbus::service_restart:
    path        => $::path,
    refreshonly => true,
  }
}
