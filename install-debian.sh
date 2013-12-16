#!/bin/bash
apt-get install -y git;
git clone https://github.com/alex-min/eip-puppetconf.git ./eip-puppetconf;
cd ./eip-puppetconf
bash ./debian-rootinstaller.sh
