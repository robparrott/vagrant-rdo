# Vagrant RDO

This repo sets up a Vagrant environment for Red Hat's OpenStack, built with the Foreman, from the [RDO](http://openstack.redhat.com/Main_Page) repositories here:

-  http://repos.fedorapeople.org/repos/openstack/

It can be used to deploy from the latest installer code released by RDO, or can use a bleeding edge deployment codebase from the astapor project:

- https://github.com/redhat-openstack/astapor

in the current working directory.

To get a Foreman-built OpenStack environment from upstream RDO packages based on Havana (the default) just cd into the repo directory and run vagrant

```bash
cd vagrant-rdo
vagrant up
```
To change to Icehouse, or some other RDO release of OpenStack, edit the `bootstrap/common.sh` file to point to a different release RPM.

Once run, you'll have 4 running hosts within VirtualBox (or your provider of choice), one for the Foreman, one as the OpenStack controller, a Compute node and a Networking node.

If you'd rather build from the openstack installer repo, clone the repo into the current directory, or create a symlink, and run the installer. If there's a directory named `astapor` in the current directory, it will run the installer from there, instead of the RPM-packaged installer.
