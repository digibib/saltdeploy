# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "saucy64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "http://171.23.133.205/vagrant/saucy64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"
  
  config.vm.define "server" do |server|
    server.vm.box = "trusty64"
    server.vm.box_url = "http://datatest.deichman.no/vagrant/trusty64.box"
    #server.vm.network :public_network, :adapter => 1
    server.vm.network :private_network, :ip => "192.168.0.2", :adapter => 2
    server.vm.synced_folder ".", "/srv"

    server.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
      salt.install_type = "stable"
      #salt.always_install = true
      salt.verbose = true
      salt.pillar_data
    end
  end

  config.vm.provider "virtualbox" do |v|
    #v.customize ["natnetwork", "add", "--netname", "cv_ext", "--network", "10.0.0.0/24"]
    #v.customize ["modifyvm", :id, "--nic3", "natnetwork"]
    #v.customize ["modifyvm", :id, "--nat-network3", "cv_ext"]
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  #

end
