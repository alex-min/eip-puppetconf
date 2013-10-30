class apacheconfig {
  class { 'apache':
    service_enable => true,
    mpm_module => 'prefork'
  } ->
  case $operatingsystem {
      /(?i)(ubuntu|debian)/: {
        file { "/etc/apache2/conf.d/security.conf":
            mode => 440,
            notify  => Service["apache2"],
            owner => root,
            group => root,
            source => "puppet:///modules/apache_files/security.conf"
        }
      }
  }

  apache::mod { 'rewrite': }

  apache::mod { 'php5': }

  class { 'php': }

  php::module { 'cli': } ->
  php::module { 'curl': } ->
  php::module { 'intl': } ->
  php::module { 'mcrypt': } ->
  php::module { 'mysql': }	
}