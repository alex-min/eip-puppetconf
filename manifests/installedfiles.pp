class installedfiles {
    file {'/root/server_installed':
      ensure  => present,
      mode    => 0640,
      owner => root,
      group => root,
      content => "installed",
    } -> notify {"Server installed.":}
}