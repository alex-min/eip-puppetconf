class installedfiles {
		exec {'eip_web_syncdb':
			command => '/root/eip_website_venv/bin/python  /root/eip_website/manage.py syncdb --noinput',
			timeout => 10000,
		} ->
		exec {'eip_web_setconfprod': 
			command => 'cp /root/eip_website/app/settings_prod.py /root/eip_website/app/settings.py',
			path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		}
		


    file {'/root/server_installed':
      ensure  => present,
      mode    => 0640,
      owner => root,
      group => root,
      content => "installed",
    } -> notify {"Server installed.":}
}