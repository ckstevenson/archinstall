# Packer Templates
This repository contains the QEMU builder Packer Templates I use for my local development machine.

### TODO
- [ ] Qemu Arch install could use Arch's new installer
- [ ] Windows templates

## Environment Variables
All provisioning is done by Ansible and a few environment variables must be set globally or locally. Local is best on shared machines. Use either ~/.profile or ~/.bash\_profile or perhaps whatever shell you choose to use. A good way to do this is to have everythin in ~/.profile and have your shell of choice source that. exporting the variables in the current shell is also an option,
* export PKR\_VAR\_ansible\_playbooks=
* export PKR\_VAR\_connection\_username=

## Usage
* All below templates can be deployed with --force to overwrite the existing template
* All variable declarations are in variables.pkr.hcl
* All sources are in qemu.pkr.hcl
* All Autounattend, preseed or kickstart files are in boot\_config direectory


### Linux
#### Debian 10
```
packer build --only qemu.linux --var-file=centos.pkrvars.hcl .
```

#### CentOS Stream 8
```
packer build --only qemu.linux --var-file=debian.pkrvars.hcl .
```
#### Arch Linux
```
packer build --only qemu.arch --var-file=arch.pkrvars.hcl .
```

### Windows
#### Server 2019
```
```

#### Server 2012
```
```
#### Server 2016
```
```
