Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"
    # # Display the VirtualBox GUI when booting the machine
    # am.vm.provider "virtualbox" do |vb|
    #   vb.gui = true
    # end
    config.vm.provision :shell, path: "bootstrap.sh"
  end