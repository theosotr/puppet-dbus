#
class dbus (
  $conf_dir           = $::dbus::params::conf_dir,
  $local_session_conf = $::dbus::params::local_session_conf,
  $local_system_conf  = $::dbus::params::local_system_conf,
  $package_name       = $::dbus::params::package_name,
  $purge_session_dir  = $::dbus::params::purge_session_dir,
  $purge_system_dir   = $::dbus::params::purge_system_dir,
  $service_enable     = $::dbus::params::service_enable,
  $service_name       = $::dbus::params::service_name,
  $service_restart    = $::dbus::params::service_restart,
  $session_conf       = $::dbus::params::session_conf,
  $session_dir        = $::dbus::params::session_dir,
  $system_conf        = $::dbus::params::system_conf,
  $system_dir         = $::dbus::params::system_dir,
  $validate           = $::dbus::params::validate,
) inherits ::dbus::params {

  validate_absolute_path($conf_dir)
  validate_absolute_path($local_session_conf)
  validate_absolute_path($local_system_conf)
  validate_string($package_name)
  validate_bool($purge_session_dir)
  validate_bool($purge_system_dir)
  if $service_enable {
    validate_bool($service_enable)
  }
  validate_string($service_name)
  validate_string($service_restart)
  validate_absolute_path($session_conf)
  validate_absolute_path($session_dir)
  validate_absolute_path($system_conf)
  validate_absolute_path($system_dir)
  validate_bool($validate)

  include ::dbus::install
  include ::dbus::config
  include ::dbus::service
  include ::dbus::reload

  anchor { 'dbus::begin': }
  anchor { 'dbus::end': }

  Anchor['dbus::begin'] -> Class['::dbus::install'] ~> Class['::dbus::service']
    -> Class['::dbus::reload'] -> Anchor['dbus::end']
  Class['::dbus::install'] -> Class['::dbus::config']
    ~> Class['::dbus::reload']
}
