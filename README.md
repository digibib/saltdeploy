saltdeploy
==========

deploy states for SaltStacks

for more info on SaltStack: [http://saltstack.com/community.html](http://saltstack.com/community.html)
Salt is a master-minion system to setup servers and workstations to specified states, defined in yaml files.

Incredibly handy for setting up once for testing, development and production.

## Install (ubuntu)

    sudo add-apt-repository ppa:saltstack/salt

(if using Raring 13.04 or Saucy 13.10):

    sudo add-apt-repository ppa:saltstack/salt-daily

vagrant
=======

Vagrant is a virtual deploy and setup tool that can use Salt as provisioner to setup a machine in Virtualbox.
All you need is a Vagrantfile and the salt config files. You don't need to install salt to use, it will be installed on virtual image.

## Install

* download from [http://downloads.vagrantup.com/](http://downloads.vagrantup.com/) and install.

Typical structure:

```
── koha
   ├── salt
   │   ├── minion                            ( minion settings, variables, etc. )
   │   └── roots                             ( root dir of salt, often shared dir in Vagrant )
   │       └── salt                
   │           ├── files                     ( files exposed to salt )
   │           │   ├── sample_template.tmpl
   │           │   ├── any_file_really.sh
   │           ├── top.sls                   ( top state file - loads when booting image)
   │           ├── examplestate.sls          ( example state - can be loaded on start or manually )
   └── Vagrantfile                           ( Vagrant setup file, virtualbox image, provisioner, ports, etc.)
```

NB! For running 64bit virtual images, the processor needs to support virtualization:

check with:

    grep --color vmx /proc/cpuinfo

if there is output with `vmx` it's Yay!