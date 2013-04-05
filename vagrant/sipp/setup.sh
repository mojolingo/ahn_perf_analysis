#!/bin/bash
echo "Making sources directory..."
mkdir src
cd src
echo "Installing required packages..."
sudo apt-get -qq install build-essential libncurses-dev libpcap-dev
echo "Unpacking SIPp"
cp /vagrant/sipp-trunk.tar.gz .
cp /vagrant/sipp-patch.bin .
tar -xzf sipp-trunk.tar.gz
mv trunk sipp
cd sipp
echo "Patching SIPp..."
patch < ../sipp-patch.bin
echo "Installing SIPp..."
make pcapplay -ws
sudo ln ./sipp /usr/local/bin
echo "Importing default scenario..."
mkdir /home/vagrant/src/scenarios
cd /home/vagrant/src/scenarios
cp /vagrant/scenario1.xml .
cp -rp ../sipp/pcap .
echo "Setup Complete! Use 'vagrant ssh' to access the box."
