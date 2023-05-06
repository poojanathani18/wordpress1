class wp_module::wp_stuff {
exec {"/usr/bin/wget https://wordpress.org/latest.zip":                                                                              
cwd => "/tmp/",                                                                                                                      
creates => "/tmp/latest.zip",                                                                                                        
}                                                                                                                                    
                                                                                                                                     
exec {"/usr/bin/unzip /tmp/latest.zip -d /var/www/html/":                                                                            
creates => "/var/www/html/wordpress/index.php",                                                                                               
}                                                                                                                                    

file  { '/var/www/html/wordpress/wp-config-sample.php':
          ensure => absent
}
                                                                                                                                     

exec {"/usr/bin/wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php": 
cwd => "/var/www/html/wordpress/",                                                                                                   
creates => "/var/www/html/latest/wp-config-sample.php",                                                                              
notify => File['/var/www/html/wordpress/wp-config.php']
}                                                                                                                                    
                                                                                                                                     
file { '/var/www/html/wordpress/wp-config.php':                                                                                      
          ensure => present,                                                                                                         
          source => "/var/www/html/wordpress/wp-config-sample.php",                                                                  
}                                                                                                                                    
                                                                                                                                     
file { '/var/www/html/wordpress':                                                                                                    
          mode => '775',                                                                                                             
          owner => 'www-data',                                                                                                       
          group => 'www-data',                                                                                                       
          recurse => true,                                                                                                           
}                                                                                                                                    
}
