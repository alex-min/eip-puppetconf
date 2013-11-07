#!/bin/bash
apt-get install git;
git clone https://github.com/alex-min/eip-puppetconf.git ./eip-puppetconf;
bash ./eip-puppetconf/debian-rootinstaller.sh
