#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install Python and Ansible"
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y curl wget ansible git make

title "Install roles from Ansible Galaxy"
sudo ansible-galaxy install viasite-ansible.zsh --force

title "Provision ZSH setup playbook for $(whoami)"
sudo ansible-playbook -i "localhost," -c local playbooks/zsh.ansible-playbook.yml --extra-vars="zsh_user=$(whoami)"
