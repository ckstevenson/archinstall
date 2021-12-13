ANSIBLE_HOST_KEY_CHECKING=False 
.PHONY: init
init:
	pipenv install
	#pipenv run ansible-galaxy install -r ../../ansible/requirements.yml --force

.PHONY: compose
compose: 
	#cat ../configs/core.json > ../configs/${profile}.json
	jq '.packages |= .+ ["open-vm-tools"]' <./configs/core.json >./configs/${profile}.json
	sed -e 's/sda/vda/g' \
		-e 's/systemd-bootctl/grub-install/g' \
		-e 's/core/qemu/g' \
		-e 's/enp0s31f6/enp1s0/g' -i ./configs/${profile}.json 
	packer build --color=true -force ./packer/qemu.pkr.hcl

.PHONY: ansible
ansible: 
	ansible-playbook -i ./ansible/hosts.yml -Kk --ask-vault-pass ./ansible/main.yml

.PHONY: destroy
destroy: 
	virsh destroy --domain archinstall
	virsh undefine --domain archinstall --remove-all-storage

.PHONY: import
import: 
	virt-install \
		-n archinstall \
		--description "Test VM for archinstall" \
		--os-type=Linux \
		--os-variant=archlinux \
		--ram=2048 \
		--vcpus=2 \
		--disk path=./packer/vm/archinstall.qcow2 \
		--network default \
		--import

		#--graphics none \
.PHONY: qemu
qemu: profile=qemu
.PHONY: qemu
qemu: compose

.PHONY: p51
p51: profile=p51
.PHONY: p51
p51: compose

.PHONY: x1
x1: profile=x1
.PHONY: x1
x1: 
	cat ./configs/core.json > ./configs/${profile}.json
	sed -e 's/sda/nvme0n1/g' \
		-e 's/core/${profile}/g' \
		-e 's/enp0s31f6/wlan0/g' -i ./configs/${profile}.json 
	# lib32-mesa
	# xf86-video-intel
	# vulkan-intel
	# sof-firmware
	#

#.PHONY: p51
#p51: 
#	cat ../configs/core.json > ../configs/p51.json
#	sed -e 's/sda/vda/g' \
#		-e 's/systemd-bootctl/grub-install/g' \
#		-e 's/core/qemu/g' \
#		-e 's/enp/enp1s0/g' -i ../configs/p51.json 
#	packer build --color=true -force .
#
#.PHONY: x1
#x1: 
#	cat ../configs/core.json > ../configs/x1.json
#	sed -e 's/sda/vda/g' \
#		-e 's/systemd-bootctl/grub-install/g' \
#		-e 's/core/qemu/g' \
#		-e 's/enp/enp1s0/g' -i ../configs/x1.json 
#	packer build --color=true -force .

