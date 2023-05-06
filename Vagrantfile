Vagrant.configure(2) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.include_offline = true
  config.vm.provision :hostmanager, run: 'always'
  config.vm.define "puppetserver" do |puppetserver|
    puppetserver.vm.box = "ubuntu/bionic64"
    puppetserver.vm.hostname = "puppetserver.example.com"
    puppetserver.vm.network "private_network", ip: "192.168.33.10"
    puppetserver.vm.provider :virtualbox do |vb|
      vb.memory = "5128"
      vb.cpus = "2"
    end
    puppetserver.disksize.size = '120GB'
    #vagrant plugin install vagrant-disksize
	puppetserver.vm.provision "shell", inline: <<-SHELL
     echo "enabling password authentication for root user as per bionic configuration"
     sudo sed -i '32s/#/ /' /etc/ssh/sshd_config
     sudo sed -i '32s/prohibit-password/yes/' /etc/ssh/sshd_config
     echo "enabling password authentication in general for ssh"
     sudo sed -i '56s/no/yes/' /etc/ssh/sshd_config
     echo "restarting SSH"
     sudo service ssh restart
     echo "setting up hostname in hosts file"
     sudo echo "127.0.0.1  puppetserver.example.com  puppetserver  puppet localhost localhost.localdomain" > /etc/hosts
     echo "starting the download of puppet master"
     sudo wget https://d2getqyrpmrvl0.cloudfront.net/released/2023.0.0/puppet-enterprise-2023.0.0-ubuntu-18.04-amd64.tar.gz -O /root/puppetserver.tar.gz
     echo "download complete. kept it in /root/puppetserver.tar.gz"
     echo "taking a backup in windows folder"
     sudo cp /root/puppetserver.tar.gz /vagrant/puppetserver.tar.gz
     echo "backup complete"
     echo "setting root password"
     sudo /usr/bin/passwd root <<EOF
12345678
12345678
EOF
     echo "root password set as 12345678"
   SHELL

  end
  config.vm.define "puppetnode" do |puppetnode|
    puppetnode.vm.box = "ubuntu/bionic64"
    puppetnode.vm.hostname = "puppetnode.example.com"
    puppetnode.vm.network "private_network",ip:"192.168.33.11"
    puppetnode.vm.provider :virtualbox do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end
  config.vm.define "puppetworkstation" do |puppetworkstation|
    puppetworkstation.vm.box = "ubuntu/bionic64"
    puppetworkstation.vm.hostname = "puppetworkstation.example.com"
    puppetworkstation.vm.network "private_network",ip:"192.168.33.12"
    puppetworkstation.vm.provider :virtualbox do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
	puppetworkstation.vm.provision "shell", inline: <<-SHELL
     wget https://apt.puppetlabs.com/puppet6-release-bionic.deb     
	 sudo dpkg -i puppet6-release-bionic.deb
	 sudo apt-get update
	 sudo apt-get -y install puppet-agent
	 sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
	SHELL
  end
    config.vm.define "puppetsandbox" do |puppetsandbox|
    puppetsandbox.vm.box = "ubuntu/bionic64"
    puppetsandbox.vm.hostname = "puppetsandbox.example.com"
    puppetsandbox.vm.network "private_network",ip:"192.168.33.13"
    puppetsandbox.vm.provider :virtualbox do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
        puppetsandbox.vm.provision "shell", inline: <<-SHELL
     wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
         sudo dpkg -i puppet6-release-bionic.deb
         sudo apt-get update
         sudo apt-get -y install puppet-agent
         sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
        SHELL
  end
end
