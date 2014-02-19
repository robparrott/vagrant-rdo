#!/bin/sh

source /vagrant/bootstrap/common.sh 

yum -y remove puppetlabs-release
yum -y install ${RDO_RPM}
yum -y install ${EPEL_RPM}

#
# intall useful config mgmt tools
#
yum -y install crudini
[ -r /etc/yum/pluginconf.d/priorities.conf ] && crudini --set /etc/yum/pluginconf.d/priorities.conf main enabled 0

yum -y install augeas

#
# Setup hostnames properly & consistently 
#

# Setup hostnames
#
hostname foreman.localnet
augtool -s < /vagrant/bootstrap/hostnames.aug

#
# Update packages
#
#yum -y upgrade 

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

