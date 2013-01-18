class dokuwiki( $domain, $wiki_email = 'root@${::fqdn}', $wiki_title = 'Wiki' ) {
  package { 'dokuwiki':
    name    => 'dokuwiki',
    ensure  => present,
    require => Exec['preseed debconf'],
  }

  file { 'debconf-settings-dokuwiki':
    ensure  => 'present',
    path    => '/tmp/debconf-settings-dokuwiki.cfg',
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    content => template('dokuwiki/debconf.erb'),
  }

  exec { 'preseed debconf':
    command => 'debconf-set-selections /tmp/debconf-settings-dokuwiki.cfg',
    require => File['debconf-settings-dokuwiki'],
    path    => '/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin'
  }

  nginx::resource::vhost { $domain:
    ensure   => present,
    www_root => '/usr/share/dokuwiki',
  }
}
