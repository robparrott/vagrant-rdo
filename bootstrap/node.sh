#!/bin/sh

# host name
name=${1}

# Read in env variables and run common tasks
source /vagrant/bootstrap/localrc
source /vagrant/bootstrap/common.sh


#
# Upgrade or install some target packages ... needs to go away into puppet.
#
UP_RPMS="iproute"
RPMS="sheepdog python-cinderclient"
yum -y upgrade ${IP_RPMS}
yum -y install ${RPMS}

#
# Configure puppet and register
#
yum install -y augeas puppet nc

augtool -s <<EOA
set /files/etc/puppet/puppet.conf/agent/server    foreman.localnet 
set /files/etc/puppet/puppet.conf/agent/ca_server foreman.localnet 
set /files/etc/puppet/puppet.conf/main/pluginsync true
EOA

[ -d /var/lib/puppet/ssl ] && rm -rf /var/lib/puppet/ssl

puppet agent --test; sleep 1; puppet agent --test

#service puppet restart
#chkconfig puppet on




