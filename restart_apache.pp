class wp_module::restart_apache {
exec { "/bin/systemctl restart apache2" :
}                                                                                                                                
}
