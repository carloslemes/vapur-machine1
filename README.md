# Vapur-machine1

This is a Virtual Machine template created using Vagrant and Puppet. The main goal is to automate the creation of Virtual Machines (VM's),
which will be used as isolated enviroments for developing web applications using Linux, Apache and Ruby.

It's named Vapur:

Va - from Vagrant.
Pu - from Puppet.
R - from Ruby.

## Getting Started

* Install [Vagrant](http://www.vagrantup.com).
* Clone the repo: `git clone git://github.com/marcosbrigante/vapur-machine1`.
* Start the VM with `vagrant up`.

## What the VM template contains

The VM template is defined by a Vagrant base box and additional packages and configuration.

### Base Box
The Vagrant base box is currently, [Ubuntu Server  12.04.2	x64	Virtualbox 4.2.10](http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box) but you can change it to match your needs.

### Additional Packages
As of today the VM's created using these scripts contains the following packages:

* Apache (last version from Ubuntu's Repository)
* Ruby 1.9.1
* Passenger 3.0.12
* Sinatra Gem

These packages are installed using PuppetLab's modules.
