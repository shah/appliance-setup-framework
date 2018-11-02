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
sudo ansible-galaxy install bertvv.samba

title "Finish setting up shell"
zsh -i -c setupsolarized dircolors.256dark

export ASF_HOME=/etc/appliance-setup-framework
export PLAYBOOKS_SRC=$ASF_HOME/playbooks
title "Run all numbered playbooks for $(whoami)"
for playbook in `ls $PLAYBOOKS_SRC/*.ansible-playbook.yml | egrep "^$PLAYBOOKS_SRC/[0-9]" | sort -V`; do 
    sudo ansible-playbook -i "localhost," -c local $playbook --extra-vars="asf_user=$(whoami)"
done;
