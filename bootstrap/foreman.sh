#!/bin/sh

# Read in env variables and run common tasks
source /vagrant/bootstrap/localrc
source /vagrant/bootstrap/common.sh

#
# Set my hostname
#
hostname foreman.localnet

#
# Install required packages
#
RPMS="augeas mysql-server packstack-modules-puppet \
      foreman-installer foreman foreman-plugin-simplify "

yum -y install ${RPMS}

#
# Run the foreman installer, or install the installer RPM from RDO
#
chmod -R a+rX /vagrant

if [ -d astapor ]; then
    cd /vagrant/astapor/
else 
	yum -y install openstack-foreman-installer
	cd /usr/share/openstack-foreman-installer/
fi

export FOREMAN_PROVISIONING=true # Will foreman be used for provisioning? true or false
export FOREMAN_GATEWAY=false      # The gateway set up for foreman provisioning
cd bin

#
# Let's tweak the settings to make our lives easier ...
#
perl -i -p -e 's/172\.16\.0\.1/192.168.1.3/g' seeds.rb
perl -i -p -e 's/172\.16\.1\.1/127.0.0.1/g' seeds.rb
perl -i -p -e 's/192\.168\.203\.1/192.168.1.3/g' seeds.rb

echo "" | bash -x ./foreman_server.sh

