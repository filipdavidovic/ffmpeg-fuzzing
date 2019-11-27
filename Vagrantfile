Vagrant.configure("2") do |config|
    config.vm.define "sixtyfour" do |sixtyfour|
      sixtyfour.vm.box = "hashicorp/bionic64"
      sixtyfour.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        # vb.gui = true
        # Configure the number of cores the VM has (useful for parallel fuzzing with AFL)
        vb.cpus = 4
      end
      sixtyfour.vm.provision :shell, path: "sixtyfour/bootstrap.sh"
    end

    config.vm.define "thirtytwo" do |thirtytwo|
      thirtytwo.vm.box = "hashicorp/precise32"
      thirtytwo.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        # vb.gui = true
        # Configure the number of cores the VM has (useful for parallel fuzzing with AFL)
        vb.cpus = 4
      end
      thirtytwo.vm.provision :shell, path: "thirtytwo/bootstrap.sh"
    end
  end