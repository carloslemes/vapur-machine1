# -*- mode: ruby -*-
# vi: set ft=ruby :
# vapur-machine1 - vagrant file.

Vagrant::Config.run do |config|
  config.vm.box = "pplabs_ubuntu12.04.2"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080
  
  # Set host_name to avoid fqdn fact warnings
  config.vm.host_name = "example.dev.com"

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder "v-data", "/vagrant_data", "./data"

  # Enable puppet provisioning
  config.vm.provision :puppet do |puppet|
     puppet.module_path = "puppet/modules"
     puppet.manifests_path = "puppet"
     puppet.manifest_file = "vapur-machine1.pp"
     puppet.options = "--hiera_config /vagrant/hiera.yaml"
  end  
end
