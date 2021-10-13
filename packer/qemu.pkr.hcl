source "qemu" "arch" {
  communicator      = "none"
  iso_url           = "https://artfiles.org/archlinux.org/iso/2021.10.01/archlinux-2021.10.01-x86_64.iso"
  iso_checksum      = "77a20dcd9d838398cebb2c7c15f46946bdc3855e"
  output_directory  = "/home/cameron/Documents/Development/templates/arch/archinstaller/"
  disk_size         = "20G"
  format            = "qcow2"
  http_directory    = "../configs"
  accelerator       = "kvm"
  vm_name           = "arch_dev.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  headless          = true
  boot_wait         = "2s"
  cpus              = 1
  memory            = 2048
  # uncomment and edit laptop.json to enable EFI
  # cannot snapshot with EFI in use
  #firmware          = "/usr/share/edk2-ovmf/x64/OVMF_CODE.fd"
  boot_command      = [
      "<enter><wait10><wait10><wait10><wait10>",
      "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/laptop.json<enter><wait5>",
      "archinstall --config laptop.json<enter><wait10><enter><wait5m>n<enter>",
      "shutdown now<enter>"
    ]
}

build {
  sources = ["source.qemu.arch"]
}
