import 'syspackage.pp'


class securitypackages {
		require syspackage::update

		notify {"Installing security packages":} 

	    case $operatingsystem {
	    	/(?i)(ubuntu|debian)/: {	
	    		# denyall
	    		package { "rkhunter": ensure => installed, }
	    		package { "chkrootkit": ensure => installed, }
	    		package { "denyhosts": ensure => installed, }
	    		package { "fail2ban": ensure => installed, }
	    		package { "tiger": ensure => installed, }

	    	}
	    }
}