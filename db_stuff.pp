class wp_module::db_stuff {
exec {"/usr/bin/mysqladmin -u root password rootpassword && /usr/bin/touch /tmp/mysqladmin_login.txt" :
creates => '/tmp/mysqladmin_login.txt',
}

exec {"/usr/bin/wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands":
cwd => "/tmp/",
creates => '/tmp/mysqlcommands',
}

exec {"/usr/bin/mysql -uroot -prootpassword < /tmp/mysqlcommands && /usr/bin/touch /tmp/mysqlcommands_execution.txt" :
creates => '/tmp/mysqlcommands_execution.txt',
}
}
