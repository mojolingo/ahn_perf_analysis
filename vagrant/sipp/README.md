## SIPp Vagrant Box ##
This Vagrantfile, along with the provided scripts and code, can be used to make a clone of the VM currently used for testing

Steps to use:
1. Clone the repo
2. Open a Terminal window
3. `cd /path/to/repo/vagrant/sipp`
4. `vagrant up`
5. `vagrant ssh`
And you're good to go!
### Notes ###
* You will see a lot of red text while the VM is being provisioned, this is because SIPp generates a _lot_ of compiler warnings.
* Unless the Vagrantfile is changed, SIPp must be directed to use port 8832 (with the `-p 8832` option)
* The testing scenario is located in `~/src/scenarios`
* This box does _not_ include any sort of Adhearsion implementation, you will need to point SIPp at a separate box running Adhearsion
