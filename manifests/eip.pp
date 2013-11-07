import 'syspackage.pp'

class deps {
	require syspackage::update
	$svnaddr = ''

	package { "python-tornado": ensure => installed,}
	package { "python-setuptools": ensure => installed,}
	package { "python-mysqldb": ensure => installed,}
	package { "python-psycopg2": ensure => installed,}

	package { "redis-server": ensure => installed,}

	package { "libsqlite3-dev": ensure => installed,}
	package { "libncurses5-dev": ensure => installed,}
	package { "libgdbm-dev": ensure => installed,}
	package { "libbz2-dev": ensure => installed,}
	package { "libmysqlclient-dev": ensure => installed,}


	#package { "libreadline5-dev": ensure => installed,}
	package { "libdb-dev": ensure => installed,}	
	package { "python-virtualenv": ensure => installed,}	
}

class django {
		## virtualenv stuff
		exec {'virtualenv_website':
			command=>'virtualenv /root/eip_website_venv --no-site-packages',
			path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			timeout=> -1,
			creates => '/root/eip_website_venv'
		}
		exec {'install_django':
			command => '/root/eip_website_venv/bin/pip install "django==1.4.2"',
			timeout => 10000,
		}

		exec {'install_django_mptt':
			command => '/root/eip_website_venv/bin/pip install "django-mptt==0.6.0"',
			timeout => 10000,
		} 
		# django-tagging
		exec {'install_django_tagging':
			command => '/root/eip_website_venv/bin/pip install "django-tagging==0.3.1"',
			timeout => 10000,
		} 
		# xmlrpc
		exec {'install_django_xmlrpc':
			command => '/root/eip_website_venv/bin/pip install "django-xmlrpc==0.1.5"',
			timeout => 10000,
		} 
		# django-registration
		exec {'install_django_registration':
			command => '/root/eip_website_venv/bin/pip install "django-registration"',
			timeout => 10000,
		} 
		# django-blog-zinnia
		exec {'install_django_blog_zinnia':
			command => '/root/eip_website_venv/bin/pip install "django-blog-zinnia"',
			timeout => 10000,
		} 
		# pil
		exec {'install_pil':
			command => '/root/eip_website_venv/bin/pip install "pil"',
			timeout => 10000,
		} 

		exec {'install_distribute':
			command => '/root/eip_website_venv/bin/pip install "distribute" --upgrade',
			timeout => 10000,
		} 

		exec {'install_python_mysql':
			command => '/root/eip_website_venv/bin/pip install "mysql-python"',
			timeout => 10000,
		} 

		exec {'install_tornado':
			command => '/root/eip_website_venv/bin/pip install "tornado"',
			timeout => 10000,
		} 




		Exec['virtualenv_website']
		-> Exec['install_django']
		-> Exec['install_django_mptt']
		-> Exec['install_django_tagging']
		-> Exec['install_django_xmlrpc']
		-> Exec['install_django_registration']
		-> Exec['install_django_blog_zinnia']
		-> Exec['install_pil']
		-> Exec['install_distribute']
		-> Exec['install_python_mysql']
		-> Exec['install_tornado']
		-> Exec['eip_web_syncdb']

}

class eip {
	  require syspackage::update
	  require deps
	  require django

		  exec {"mysql_change_password_anyway2": 
		  		command => "mysqladmin -u root -p'' password 'wb9rbuay' || /bin/true",
		  		path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		  		onlyif => '/usr/bin/test -f /usr/bin/mysqladmin',
		  		creates => '/root/server_installed'
		  } ->
		  exec {"mysql_change_password_anyway3": 
		  		command => "mysqladmin -u root -p'eipbilantech' password 'wb9rbuay' || /bin/true",
		  		path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		  		onlyif => '/usr/bin/test -f /usr/bin/mysqladmin',
		  		creates => '/root/server_installed'
		  } ->
		  class { '::mysql::server':
		  	root_password => 'wb9rbuay',
		  } ->
		   mysql_database { 'manhunt':
			  ensure  => 'present',
			  charset => 'utf8',
		  }

		notify {"checkout eip webservice":}
		notify {"checkout eip web":}
		notify {"Creating virtualenv...":}
		notify {"Installing django...":}

		exec {'checkout_svn_webservice':
			command => 'svn checkout --non-interactive --username eipwebservices --password eipwebservices42 svn://91.121.12.93/eip_webservices /root/eip_webservices || true',
			path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			timeout => -1,
			#creates => '/root/server_installed',
		}

		exec {'checkout_svn_web':
			command => 'svn checkout --non-interactive --username eipwebsite --password eipwebsite42 svn://91.121.12.93/eip_website /root/eip_website || true',
			path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
			timeout => 0,
			#creates => '/root/server_installed',
		}
}