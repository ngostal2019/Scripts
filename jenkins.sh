#!/bin/bash

# Author: Staline Ngoma
# Date:  Nov 23 03:24:54 EST 2017
# Purpose: This Script setups Jenkins on centOS/RHEL 6.x.
# Code Version:
# Modified:
# By:
# Reason:
# Company's name:


echo
echo "installing Java8..."
sleep 3

yum install java-1.8* -y
echo "checking the java version, please wait"

echo

sleep 2

java -version

sleep 2

echo "Downloading & Creating jenkins repository..."

sleep
 4
echo

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
echo

sleep 2

echo -e "\n Importing the jenkins key \n"

rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

echo

echo "Installing jenkins..."

echo

sleep 2

yum install jenkins -y

echo "Start jenkins services"
sleep 3

service jenkins start


chkconfig jenkins on

echo

echo "Configuring the port 8080 on the firewall for jenkins server"
sleep 3
sed -i '/:OUTPUT ACCEPT/a \-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT' /etc/sysconfig/iptables
echo
echo "Restart iptables services "

service iptables restart
sleep 2

echo "done"

echo
echo
echo " Use this link to access your jenkins server. http://$(ifconfig |grep Bcast |awk '{print $2}' |awk -F":" '{print $2}'):8080"
echo
