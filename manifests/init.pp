# Installs and manages D-Bus.
#
# @example Declaring the class
#   include ::dbus
#
# @param conf_dir Top-level configuration directory, usually `/etc/dbus-1`.
# @param local_session_conf The configuration file used to override the default
#   session bus configuration, usually `/etc/dbus-1/session-local.conf`.
# @param local_system_conf The configuration file used to override the default
#   system bus configuration, usually `/etc/dbus-1/system-local.conf`.
# @param package_name The name of the package.
# @param purge_session_dir Whether to purge any unmanaged session bus
#   configuration files.
# @param purge_system_dir Whether to purge any unmanaged system bus
#   configuration files.
# @param service_enable Whether to enable the service or not. On platforms that
#   use systemd, the dbus unit is marked static so can neither be disabled or
#   enabled by the `service` type.
# @param service_name The name of the service.
# @param service_restart The command used to get `dbus-daemon` to reload its
#   configuration, which is usually `dbus-send --system --type=method_call
#   --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig`. On
#   platforms that use systemd, this is what the unit does anyway and so will
#   rely on that where possible.
# @param session_conf The configuration file containing the default session bus
#   configuration, usually `/etc/dbus-1/session.conf`.
# @param session_dir The directory used by applications to add additional
#   session bus configuration, usually `/etc/dbus-1/session.d`.
# @param system_conf The configuration file containing the default system bus
#   configuration, usually `/etc/dbus-1/system.conf`.
# @param system_dir The directory used by applications to add additional system
#   bus configuration, usually `/etc/dbus-1/system.d`.
# @param validate Whether to validate the XML configuration files prior to
#   installing them.
#
# @see puppet_defined_types::dbus::session ::dbus::session
# @see puppet_defined_types::dbus::system ::dbus::system
class dbus (
  Stdlib::Absolutepath $conf_dir           = $::dbus::params::conf_dir,
  Stdlib::Absolutepath $local_session_conf = $::dbus::params::local_session_conf,
  Stdlib::Absolutepath $local_system_conf  = $::dbus::params::local_system_conf,
  String               $package_name       = $::dbus::params::package_name,
  Boolean              $purge_session_dir  = $::dbus::params::purge_session_dir,
  Boolean              $purge_system_dir   = $::dbus::params::purge_system_dir,
  Optional[Boolean]    $service_enable     = $::dbus::params::service_enable,
  String               $service_name       = $::dbus::params::service_name,
  String               $service_restart    = $::dbus::params::service_restart,
  Stdlib::Absolutepath $session_conf       = $::dbus::params::session_conf,
  Stdlib::Absolutepath $session_dir        = $::dbus::params::session_dir,
  Stdlib::Absolutepath $system_conf        = $::dbus::params::system_conf,
  Stdlib::Absolutepath $system_dir         = $::dbus::params::system_dir,
  Boolean              $validate           = $::dbus::params::validate,
) inherits ::dbus::params {

  contain ::dbus::install
  contain ::dbus::config
  contain ::dbus::service

  Class['::dbus::install'] -> Class['::dbus::config']
    ~> Class['::dbus::service']
}
