# The is the main file for the EJBCA, should include all other class for installation.
#
# @summary The class calls all the other sub classes: install, config and service
#
# @example
#   include ejbca
class ejbca (
  Boolean $manage_app_server           = $ejbca::params::manage_app_server,
  Enum['wildfly'] $app_server          = $ejbca::params::app_server,
  String $app_server_version           = $ejbca::params::app_server_version,
  String $app_server_download_url      = $ejbca::params::app_server_download_url,
  String $app_server_jdbc_download_url = $ejbca::params::app_server_jdbc_download_url,
  Stdlib::Unixpath $app_server_homedir = $ejbca::params::app_server_homedir,
  String $app_server_user              = $ejbca::params::app_server_user,
  String $app_server_group             = $ejbca::params::app_server_group,
) inherits ejbca::params {
  if $manage_app_server {
    if $app_server == 'wildfly' {
      class {'ejbca::wildfly':
        before => Class['ejbca::install']
      }
    }
  }

  class {'ejbca::install': }
  -> class {'ejbca::config': }
  -> class {'ejbca::service': }
}
