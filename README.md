# Vagrant Cassandra

This is a sample project to show how to get a simple Cassandra cluster up and running with Vagrant.  It is not secure or production ready.

## Acknowledgement

It is a modified [vagrant-cassandra](https://github.com/dholbrook/vagrant-cassandra) project.

## Prerequisites

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)
* [librarian-chef](https://github.com/applicationsonline/librarian-chef)
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus)

## First usage

    (install latest Ruby)
    vagrant plugin install vagrant-omnibus
    gem install librarian-chef
    librarian-chef install
    vagrant up
    
Instead of `vagrant up` you can use `provision-parallel` script for faster provisioning.
However, sometimes there is a race condition which results in failure in provisioning one of the VMs.
You can then retry provisioning only that failed VM by executing `vagrant up <node> --provision`.
    
After that you should be able to interact with the Cassandra nodes.
 
    vagrant@node2:~$ cqlsh
    Connected to Test Cluster at 127.0.0.1:9042.
    [cqlsh 5.0.1 | Cassandra 2.1.20 | CQL spec 3.2.1 | Native protocol v3]
    Use HELP for help.
    cqlsh>
	
    vagrant@node2:~$ nodetool status
    Datacenter: datacenter1
    =======================
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address         Load       Tokens  Owns (effective)  Host ID                               Rack
    UN  192.168.200.11  54.88 KB   256     65.6%             9d3e59d5-27b8-4d45-9ac1-1e1b3a9c6df1  rack1
    UN  192.168.200.13  111.8 KB   256     66.9%             c8e91f28-42d2-452e-8b27-311e70b34987  rack1
    UN  192.168.200.12  122.65 KB  256     67.4%             f5ceccc8-3e40-406b-9a7c-92c1b6cb4bb5  rack1
    
## Basic Vagrant commands
* `vagrant up` - boots up all VMs (and provisions them if it's their first boot)
* `vagrant up <node>` - boots up only the specified node (there are `node1`, `node2` and `node3`)
* `vagrant halt` - gracefully shutdowns all VMs
* `vagrant halt <node>` - gracefully shutdowns only the specified node
* `vagrant provision` - applies changes from `Vagrantfile`
* `vagrant ssh <node>` - logs to the specified node via SSH

Partitions may be simulated by SSH-ing to particular node(s) and bringing down `eth1` interface. Unplugging the network cable from VirtualBox GUI or VBoxManage should yield the same result.
    
## Changelog

**2018-12-08**

* update Cassandra from 2.1.0 to 2.1.20
* update Oracle JDK7 to Oracle JDK 8
* update java cookbook
* add cassandra binaries to PATH
* add parallel provisioning scripts for Windows and Unix

**2014-10-11**

* upgrade cassandra-chef-cookbook to 2.8.0
* set cassandra version to 2.1.0
* switch back to cassandra::tarball
* remove cassandra restart post provisioner

**2014-09-13**

* upgrade Ubuntu from 12.04 to 14.04
* upgrade Chef to from 11.8.2 to 11.16.0
* upgrade Cassandra from 2.0.3 to 2.0.9
* upgrade java from 1.7.0\_51 to 1.7.0\_67
* increased RAM from 512 to 1024
* switch from cassandra::tarball to cassandra::datastax
* add apache2 license
* add explicit versions to Cheffile
* add `ssl_verify_mode = :verify_peer` configuration to remove chef warning


