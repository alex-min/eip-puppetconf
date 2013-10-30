class syspackage::update {
    
    notify {"Updating packages":}
    case $operatingsystem {
    	/(?i)(ubuntu|debian)/: {
			 	exec { 'apt-get update':
				  command => 'apt-get update',
				  path    => '/usr/bin/',
				  tries   => 3,
				}
		}
    }
}