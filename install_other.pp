class wp_module::install_other {
$packagenames = ['unzip','mysql-server', 'mysql-client', 'php', 'libapache2-mod-php', 'php-mysql']
$packagenames.each |String $pkg| {
  package {"${pkg}":
    ensure => latest,
  }
}
}
