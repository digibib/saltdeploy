saltdeploy
==========

deploy states for SaltStacks

for more info on SaltStack: [http://saltstack.com/community.html](http://saltstack.com/community.html)
Salt is a master-minion system to setup servers and workstations to specified states, defined in yaml files.

Incredibly handy for setting up once for testing, development and production.

## Install (ubuntu)

    sudo add-apt-repository ppa:saltstack/salt

(if using Saucy 13.10):

    sudo add-apt-repository ppa:saltstack/salt-daily

vagrant
=======

Vagrant is a virtual deploy and setup tool that can use Salt as provisioner to setup a machine in Virtualbox.
All you need is a Vagrantfile and the salt config files. You don't need to install salt to use, it will be installed on virtual image.

## Install

* download from [http://downloads.vagrantup.com/](http://downloads.vagrantup.com/) and install.

Typical structure:

```
── koha                             ( root dir, often shared dir in Vagrant and including Vagrantfile )
   ├── pillar
   │   ├── koha
   │   │   └── init.sls
   │   └── top.sls
   ├── salt
   │   ├── koha
   │   │   ├── files                ( files exposed to salt, accessible by salt://koha/files)
   │   │   │   ├── sample_template.tmpl
   │   │   │   ├── any_file_really.sh
   │   │   │   ├── ...
   │   │   ├── init.sls
   │   │   ├── examplestate.sls     ( example state - can be loaded on start or manually )
   │   │   ├── ...
   │   ├── minion                   ( minion settings, can include variables, etc. )
   │   └── top.sls                  ( top state file - loads when booting image)
   └── Vagrantfile                  ( Vagrant setup file, virtualbox image, provisioner, forwarded ports, etc.)
```

Vagrantfile
===========

The core config file for Vagrant. Any commands to Vagrant must be run from dir with Vagrantfile.

NB! For running 64bit virtual images, the processor needs to support virtualization:

check with:

    grep --color vmx /proc/cpuinfo

if there is output with `vmx` it's Yay!

Usually, the commands are:

    vagrant up        ( builds virtualbox from net image or uses previous one located in .vagrant, 
                        boots virtualbox and runs state.highstate (=top.sls) if given in Vagrantfile)

    vagrant halt/reload  (stops/reboots virtualbox)

    vagrant destroy      ( deletes virtualbox entirely )

    vagrant provision    ( forces running state.highstate )

    vagrant ssh          ( log into virtualbox and do whatever as sudo! )

To run individual states, run e.g.:

    echo "sudo salt-call state.sls examplestate" | vagrant ssh

Or do it from within the Virtualbox