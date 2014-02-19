#!/bin/sh

# Read in env variables and run common tasks
source /vagrant/bootstrap/localrc
source /vagrant/bootstrap/common.sh

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
echo "" | bash -x ./foreman_server.sh

