# Load Testing Adhearsion

## What You'll need
* [Vagrant](http://vagrantup.com)
* [FreeSWITCH](http://wiki.freeswitch.org/wiki/Installation_Guide), 
  [Asterisk](http://www.asterisk.org/downloads), and/or 
  [PRISM](http://voxeolabs.com/prism/)
* [RVM](https://rvm.io), or another Ruby version manager
* Ruby 1.9.3, 2.0.0, and JRuby 1.7.2

### Getting Ruby With RVM
1. Install RVM (`\curl -L https://get.rvm.io | bash -s head`)
2. `rvm autolibs enable`
3. `rvm install 1.9.3`
4. `rvm install 2.0.0`
5. `rvm install jruby-1.7.2`
  * Protip: Do __not__ `rvm install` JRuby without specifying 1.7.2, as this             causes issues with Adhearsion

## Setting Up
1. Clone the repo
2. Copy the repo's `ahn/` directory to the machine that will be running the Adhearsion server
3. Change `ahn/config/adhearsion.rb` to connect to your telephony platform of choice (instructions for 
[Asterisk](http://adhearsion.com/docs/getting-started/asterisk), 
[FreeSWITCH](http://adhearsion.com/docs/getting-started/freeswitch), and [PRISM](http://adhearsion.com/docs/getting-started/prism))
4. `bundle install`
5. Make sure your telephony platform will either
  * Accept any inboud call from your local network, or
  * Accept a call from sipp@*your sipp ip* 
6. Back on the machine that will be used for your Vagrant VM, go to the `vagrant/sipp` directory of the repository
7. `vagrant up` (See the 
[README](https://github.com/mojolingo/ahn_perf_analysis/blob/master/vagrant/sipp/README.md) 
in the `vagrant/sipp/` directory for caveats and known issues)
8. `vagrant ssh`
9. `cd src/scenarios/`

## Running the Tests
* On your Adhearsion server:
  1. Start up your telephony backend
  2. Go to your `ahn/` directory
  3. `rvm use`*ruby\_version* (Pick one of the above-mentioned versions)
  3. `bundle exec ahn -`
  4. Ensure Adhearsion starts up properly (An error complaining about lack of libreadline may appear on JRuby, but this is normal)
* In your SIPp Vagrant VM
  1. `cd src/scenarios`, if you're not already there
  2. `sudo sipp -i` _ip\_of\_vm_ `-sf scenario1.xml -l` _concurrent\_calls_ `-m` _total\_calls_ `-r` _calls\_per\_second_ `-s 1 -p 8836` _ip\_of\_adhearsion\_box_
  3. Let the tests run 

Repeat the steps above for all versions of Ruby you're using.