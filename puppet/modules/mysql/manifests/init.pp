# == Class: mysql
#
# Installs MySQL server, sets config file, and loads database for dynamic site.
#
class mysql {
  package { ['mysql-server']:
    ensure => present;
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }

  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'];
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot status',
    command => "mysqladmin -uroot password root",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  exec { 'load-dynamic-sql':
    command => 'mysql -u root -proot < /vagrant/sites/createDatabase.sql',
    path    => ['/bin', '/usr/bin'],
    require => Exec['set-mysql-password'];
  }
  
  ## Importa bd Drupal Sitio Web
  exec {'import mysql':
    path    => ['/bin', '/usr/bin'],
    command => 'mysql -u root -proot -D cepalweb < /vagrant/sites/bdmysql.sql',
    require => Exec['set-mysql-password'];
  }

}
