# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = 'magento.test'

VAGRANTFILE_API_VERSION = "2"

  githubToken = ""
  
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # box name.  Any box from vagrant share or a box from a custom URL. 
  config.vm.box = "ubuntu/trusty64"
  
  # box modifications, including memory limits and box name. 
  config.vm.provider "virtualbox" do |vb|
     vb.memory = 4096
	 vb.cpus = 2
  end

  ## IP to access box
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder ".", "/vagrant", type: "rsync", :mount_options => ["dmode=777", "fmode=777"]
  
  ## Bootstrap script to provision box.  All installation methods can go here. 
  config.vm.provision "shell" do |s|
    s.path = "bootstrap.sh"
    s.args = HOSTNAME
  end

end
