#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install osQuery"
export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $OSQUERY_KEY
sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
sudo apt-get update
sudo apt-get install -y osquery

title "Install roles from Ansible Galaxy"
sudo ansible-galaxy install geerlingguy.docker
sudo ansible-galaxy install geerlingguy.postfix
sudo ansible-galaxy install bertvv.samba

title "Finish setting up shell"
zsh -i -c setupsolarized dircolors.256dark

title "Provision CHIE for $(whoami)"
sudo ansible-playbook -i "localhost," -c local playbooks/01_initial.ansible-playbook.yml
sudo ansible-playbook -i "localhost," -c local playbooks/02_docker.ansible-playbook.yml
sudo ansible-playbook -i "localhost," -c local playbooks/03_mail.ansible-playbook.yml
sudo ansible-playbook -i "localhost," -c local playbooks/04_samba.ansible-playbook.yml

