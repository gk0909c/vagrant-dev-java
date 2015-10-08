Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu14.04"

  config.vm.network "forwarded_port", guest: 8080, host: 18080
  config.vm.network "forwarded_port", guest: 3306, host: 13306

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    vb.memory = "1024"
    #vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end
  
  #config.vm.network "private_network", ip: "192.168.33.10"
  
  config.proxy.http     = ENV['http_proxy']
  config.proxy.https    = ENV['http_proxy']
  config.proxy.no_proxy = ENV['NO_PROXY']
  
  config.vm.synced_folder "share", "/host_share"
  
  # provision for init
  config.vm.provision "docker"
  config.vm.provision :shell, :path => "init-install-root.sh"
  config.vm.provision :shell, privileged: false, :path => "init-install-user.sh"
  
  # provision always
  config.vm.provision :shell, run: "always", privileged: false, :path => "start-eclim.sh"
end
