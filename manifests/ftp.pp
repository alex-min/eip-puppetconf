import 'syspackage.pp'

class ftp {
	require syspackage::update
	class { 'vsftpd':
	  anonymous_enable  => 'NO',
	  write_enable      => 'YES',
	  ftpd_banner       => 'Marmotte FTP Server',
	  chroot_local_user => 'YES',
	}
}