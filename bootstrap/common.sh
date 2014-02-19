#
# Common tasks across all nodes
#

# Setup up appropriate repos
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
