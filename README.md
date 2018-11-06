# Welcome to the Appliance Setup Framework (ASF)

## Server software requirements

Ubuntu [18.04 LTS minimal](https://help.ubuntu.com/community/Installation/MinimalCD) server or similar Linux distribution on a virtual or physical machine is required. Unless you're an expert Linux admin with [Ansible](https://www.ansible.com/) skills, use the [64-bit Ubuntu 18.04 "Bionic Beaver" mini.iso](http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso) netboot image or [64-bit Ubuntu 18.04 Server](https://www.ubuntu.com/download/server) image in case netboot will not work in your environment. The mini.io netboot creates the smallest footprint server so it's the most secure and requires minimal hardening for security.

Setup a Windows Hyper-V, VMware, VirtualBox, or other hypervisor VM:

* RAM: minimum 2048  megabytes, preferably **4096 megabytes**
* Storage: minimum 32 gigabytes, preferably **256 gigabytes**
* Network: **Accessible outbound to the Internet** (both IPv4 and IPv6), inbound access not required
* Firewall Route: The publically accessible IP should point to this server, a Linux firewall is automatically managed by the appliance

## Setup the operating system

First, install Ubuntu 18.04.1 LTS or above *minimal server* on your preferred hypervisor. The smaller the footprint, the safer and more secure the appliance. You can use most of the defaults, but provide the following defaults when you are asked to make choices:

* Hostname: **sandbox** (devl), **validate** (QA) or **appliance** (production).
* Default User Full Name: **Admin User**
* Default User Name: **admin**
* Default User Password: **adminDefault!**
* Disk Partitioning: **Guided - use entire disk**
* PAM Configuration: **Install security updates automatically**
* Software Packages: *OpenSSH is the only package that must be installed by default*

NOTE: the user you create is called the *admin user* below. 

## Prepare your appliance for software

After Ubuntu operating system installation is completed, log into the server as the *admin user* (see above).

Bootstrap the core utilities:

    sudo apt update && sudo apt install net-tools curl -y && \
    curl https://raw.githubusercontent.com/shah/appliance-setup-framework/master/bin/bootstrap.sh | bash

After bootstrap.sh is complete, exit the shell.

## Review your specific appliance variables

After you've exited, log back in as the *admin user* and review the appliance.secrets.ansible-vars.yml file to customize it for your installation. 

    cd /etc/appliance-setup-framework/conf
    sudo vi appliance.secrets.ansible-vars.yml

The **appliance.secrets-tmpl.ansible-vars.yml** file is a template (sample), and the **appliance.secrets.ansible-vars.yml** is what will be used by the Ansible and related setup utilities.

If you have any custom playbooks, add them to /etc/appliance-setup-framework/playbooks. The bin/setup.sh utility will run all numbered playbooks in numerical order. 

## Install software

    cd /etc/appliance-setup-framework
    bash bin/setup.sh

After setup is completed, reboot the server (Docker setup will be incomplete without a reboot):

    sudo reboot

## Batteries Included

The ASF comes with everything you need to run a secure, minimally hardended, appliance for custom on-premise or cloud software. That includes:

* Base Ubuntu 18.04 LTS with automatic security updates turned on
* UFW and fail2ban
* OpenSSH
* ZSH with Oh My ZSH! and Antigen
* Ansible and ARA
* Docker with [Container Configuration Framework](/shah/container-config-framework) and [docker-gen](https://github.com/jwilder/docker-gen)
* osQuery
* Outbound SMTP relay via DragonFly MTA (dma) and mailutils, no incoming e-mails are allowed though
* Python and PIP
* Samba with admin home available as a share
* prometheus-node-exporter
* prometheus-osquery-exporter
* htop, jsonnet, jq

## TODO

* ARA doesn't seem to be recording Ansible Playbook output, need to check out why
