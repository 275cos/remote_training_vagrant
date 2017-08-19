#!/bin/bash

# Installing tools 
yum makecache fast
yum install -y epel-release
yum repolist
yum install -y mlocate nmap openvpn vim net-tools htop tcpdump wget
updatedb


# install Anaconda from vagrant folder to a global directory for all users
#bash /vagrant/Anaconda3-4.4.0-Linux-x86_64.sh -bf -p /opt/anaconda
#echo 'export PATH="/opt/anaconda/bin:$PATH"' >> /etc/profile


# disable vagrant user and add assessor user, addgroups for openvpn and anaconda	
useradd nouser
groupadd nogroup
groupadd anaconda
passwd vagrant -d
useradd -d /home/assessor -m assessor -G wheel,anaconda -p be@stmodeeng@ge


#copy file form host into vm, set permissions for anaconda directory
cp /vagrant/{assessor.ovpn,connect.sh} /home/assessor &&
chown assessor:assessor /home/assessor/assessor.ovpn
chown assessor:assessor /home/assessor/connect.sh
chmod +x /home/assessor/connect.sh


cp /vagrant/update-resolv-conf /etc/openvpn
chmod +x /etc/openvpn/update-resolv-conf


#allow no password sudo for assessor
sudo cp /etc/sudoers.d/vagrant /etc/sudoers.d/assessor
sed -i 's/vagrant/assessor/g' /etc/sudoers.d/assessor


#clear bash history
history -c


# Start Vagrant with a Gui
systemctl set-default graphical.target
sudo reboot
