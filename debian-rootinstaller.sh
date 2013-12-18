#!/bin/bash
apt-get install -y rubygems;
apt-get remove puppet
apt-get remove facter
gem install puppet-module;
gem install facter
mkdir -p /etc/puppet/modules;
cd modules
alias puppet='/usr/local/bin/puppet';
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
