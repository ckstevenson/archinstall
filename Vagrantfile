Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  ENV['ANSIBLE_CONFIG'] = "./ansible/ansible.cfg"
  # Run Ansible from the Vagrant Host
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./ansible/main.yml"
    ansible.raw_arguments  = [
      "-v"
      ]
  end
end
