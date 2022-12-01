source "qemu" "arch" {
  communicator     = "none"
  #ssh_username     = "cameron"
  #ssh_password     = "changeme"
  iso_url          = "https://artfiles.org/archlinux.org/iso/2021.11.01/archlinux-2021.11.01-x86_64.iso"
  iso_checksum     = "e42e562dd005fbe15ade787fe1ddba48"
  output_directory = "./packer/vm/"
  disk_size        = "20G"
  format           = "qcow2"
  http_directory   = "./configs"
  accelerator      = "kvm"
  vm_name          = "archinstall.qcow2"
  net_device       = "virtio-net"
  disk_interface   = "virtio"
  headless         = false
  boot_wait        = "2s"
  cpus             = 1
  memory           = 2048
  # uncomment and edit laptop.json to enable EFI
  # cannot snapshot with EFI in use
  #firmware          = "/usr/share/edk2-ovmf/x64/OVMF_CODE.fd"
  boot_command = [
    "<enter><wait45>",
    "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/qemu.json<enter><wait5>",
    "archinstall --config qemu.json<enter><wait10><enter><wait5m>n<enter>",
    "cp /var/log/archinstall -ra /mnt/<enter><wait5>",
    "shutdown now<enter>"
  ]
}

build {
  sources = ["source.qemu.arch"]
  #  provisioner "ansible" {
  #    playbook_file = "../ansible/main.yml"
  #    user = "user"
  #    #use_proxy = false
  #    extra_arguments = [
  #        "-b",
  #        "--extra-vars",
  #        #"ansible_become_password=changeme",
  #        #        "--vault-password-file",
  #        #        "${ var.ansible_playbooks }/vault_pwd"
  #        #"-vvv"
  #    ]
  #}
}
