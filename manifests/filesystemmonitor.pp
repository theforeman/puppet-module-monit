# == Class: monit::filesystemmonitor
#
# This module configures a filesystem to be monitored by Monit
#
# [*path*]            - Path of the filesystem
# [*checks*]          - Array of monit check statements
#
# === Parameters
#
# === Authors
#
# Vincent Robert <vincent.robert@genezys.net>
#
define monit::filesystemmonitor (
  $path = undef,
  $checks  = [],
) {
  include monit::params
  if ($path == undef) {
    fail("Missing path for the filesystem ${name}.")
  }
  if ($checks == []) {
    fail("Missing checks for the filesystem ${name}.")
  }
  file { "${monit::params::conf_dir}/${name}.conf":
    ensure  => $ensure,
    content => template('monit/filesystem.conf.erb'),
    notify  => Service[$monit::params::monit_service],
    require => Package[$monit::params::monit_package],
  }
}
