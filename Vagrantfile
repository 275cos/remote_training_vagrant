Vagrant.configure(2) do |config|
  config.vm.box = "275cos/remote_training_vm"
    config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.cpus = 2
      vb.memory = "4096"
    end
    config.vm.provision "shell", path: "./scripts/provision.sh"

end
