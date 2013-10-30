import 'syspackage.pp'

class svn {
	require syspackage::update

	file { "/var/svn":
    	ensure => "directory",
	}
	package {"subversion":
		ensure => installed,
	}
}