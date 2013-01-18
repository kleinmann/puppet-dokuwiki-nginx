class dokuwiki( $domain ) {
  package { 'dokuwiki':
    name   => 'dokuwiki',
    ensure => present,
  }

  nginx::resource::vhost { $domain:
    ensure   => present,
    www_root => '/usr/share/dokuwiki',
  }
}
