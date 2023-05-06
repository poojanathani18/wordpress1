class wp_module::install_run_apache {
package {"apache2":
ensure => latest,
}
service {"apache2":
ensure => running,
}
}
