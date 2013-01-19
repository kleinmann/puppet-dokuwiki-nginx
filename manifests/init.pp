class dokuwiki( $domain, $wiki_email = 'root@${::fqdn}', $wiki_title = 'Wiki' ) {
  package { 'dokuwiki':
    ensure   => present,
    name     => 'dokuwiki',
    provider => 'dpkg',
    source   => '/opt/debs/dokuwiki_0.0.20121013_all.deb',
    require  => File['dokuwiki-package'],
  }

  file { '/opt/debs':
    ensure => 'directory',
  }

  file { 'dokuwiki-package':
    ensure  => 'present',
    path    => '/opt/debs/dokuwiki_0.0.20121013_all.deb',
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    source  => 'puppet:///modules/dokuwiki/dokuwiki_0.0.20121013_all.deb',
    require => File['/opt/debs'],
  }

  file { 'dokuwiki-nginx-vhost':
    ensure  => 'present',
    path    => '/etc/nginx/conf.d/dokuwiki_vhost.conf',
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    content => template('dokuwiki/nginx_vhost.erb'),
  }

  file { 'dokuwiki-local-configuration':
    ensure  => 'present',
    path    => '/var/www/dokuwiki/conf/local.php',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 0644,
    content => template('dokuwiki/local.php.erb'),
    require => Package['dokuwiki'],
  }
  file { 'dokuwiki-users':
    ensure  => 'present',
    path    => '/var/www/dokuwiki/conf/users.auth.php',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 0600,
    content => template('dokuwiki/users.auth.php.erb'),
    require => Package['dokuwiki'],
  }
  file { 'dokuwiki-acl':
    ensure  => 'present',
    path    => '/var/www/dokuwiki/conf/acl.auth.php',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 0600,
    content => template('dokuwiki/acl.auth.php.erb'),
    require => Package['dokuwiki'],
  }
}
