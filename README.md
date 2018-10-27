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

NOTE: the user you create is called the *admin user* below. 

## Prepare your appliance for software

After installation is completed, log into the server as the *admin user* (see above).

Install the following core utilities:

    sudo apt update
    sudo apt install openssh-server net-tools curl wget git -y

## Download the core software and prepare for containers

    sudo git clone --recurse https://github.com/shah/appliance-setup-framework /etc/appliance-setup-framework

## Setup your account-specific appliance variables

As the *admin user*:

    cd /etc/appliance-setup-framework/conf
    sudo cp appliance.secrets.conf-tmpl.yml appliance.secrets.conf.yml
    sudo vi appliance.secrets.conf.yml

Now enter all the secrets variables based on instructions provided. Once you've done that, the /etc/appliance-setup-framework/conf will look something like this:

    > ls -al /etc/appliance-setup-framework/conf
    drwxr-xr-x 1 appliance appliance  512 Oct 22 13:41 .
    drwxr-xr-x 1 appliance appliance  512 Oct 22 13:44 ..
    -rwxr--r-- 1 appliance appliance 1388 Oct 22 13:15 appliance.common.conf.yml
    -rwxr--r-- 1 appliance appliance  230 Oct 22 13:14 appliance.secrets.conf-tmpl.yml
    -rwxr--r-- 1 appliance appliance  213 Oct 22 13:14 appliance.secrets.conf.yml

The **appliance.secrets.conf-tmpl.yml** file is a template (sample), and the **appliance.secrets.conf.yml** is what will be used by the Ansible and related setup utilities.

## Setup the core software and prepare for containers

    cd /etc/appliance-setup-framework 
    bash bin/bootstrap.sh

After bootstrap.sh is complete, exit the shell and restart it.

Once you've logged in again as *admin user*, resume the setup:

    cd /etc/appliance-setup-framework 
    bash bin/setup.sh

After setup is completed, reboot the server (Docker setup will be incomplete without a reboot):

    sudo reboot

