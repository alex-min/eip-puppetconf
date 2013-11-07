B1;3201;0c#!/bin/bash
apt-get install -y puppet rubygems;
gem install puppet-module;
mkdir -p /etc/puppet/modules;
puppet module install puppetlabs-concat --force;
puppet module install puppetlabs-stdlib --force;
puppet module install example42/php --force;
puppet module install example42/puppi --force;
puppet module install thias/vsftpd --force;
puppet module install puppetlabs/mysql --force;
puppet module install puppetlabs/apache --force
cp -R ./eip-puppetconf/modules/* /etc/puppet/modules/
cd ./eip-puppetconf/manifests && puppet apply init.pp
