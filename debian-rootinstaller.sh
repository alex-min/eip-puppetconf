#!/bin/bash
apt-get install -y puppet rubygems;
gem install puppet-module;
mkdir -p /etc/puppet/modules;
cd modules
puppet module install puppetlabs-concat --force;
puppet module install puppetlabs-stdlib --force;
puppet module install example42/php --force;
puppet module install example42/puppi --force;
puppet module install thias/vsftpd --force;
puppet module install puppetlabs/mysql --force;
puppet module install puppetlabs/apache --force
cp -R * /etc/puppet/modules/
cd ..
puppet apply manifests/init.pp
