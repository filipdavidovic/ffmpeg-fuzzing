Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"
    config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      # vb.gui = true
      # Configure the number of cores the VM has (useful for parallel fuzzing with AFL)
      vb.cpus = 4
    end
    config.vm.provision :shell, path: "bootstrap.sh"
  end