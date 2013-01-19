class dokuwiki( $domain, $wiki_email = 'root@${::fqdn}', $wiki_title = 'Wiki' ) {
  package { 'dokuwiki':
    ensure   => present,
    name     => 'dokuwiki',
    provider => 'dpkg',
    source   => '/opt/debs/dokuwiki_0.0.20120125b-1_all.deb',
    require  => File['dokuwiki-package'],
  }

  file { '/opt/debs':
    ensure => 'directory',
  }

  file { 'dokuwiki-package':
    ensure  => 'present',
    path    => '/opt/debs/dokuwiki_0.0.20120125b-1_all.deb',
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    source  => 'puppet:///modules/dokuwiki/dokuwiki_0.0.20120125b-1_all.deb',
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
    path    => '/etc/dokuwiki/local.php',
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    content => template('dokuwiki/local.php.erb'),
  }
  file { 'dokuwiki-acl':
    ensure  => 'present',
    path    => '/var/lib/dokuwiki/acl/users.auth.php',
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    content => template('dokuwiki/users.auth.php.erb'),
  }

  # Create symlinks
  file { '/etc/dokuwiki/users.auth.php':
   ensure  => 'link',
   target  => '/var/lib/dokuwiki/acl/users.auth.php',
   require => File['dokuwiki-acl'],
  }
  file { '/etc/dokuwiki/acl.auth.php':
   ensure => 'link',
   target => '/var/lib/dokuwiki/acl/acl.auth.php',
  }
  file { '/var/lib/dokuwiki/inc':
   ensure => 'link',
   target => '/usr/share/dokuwiki/inc',
  }
}
