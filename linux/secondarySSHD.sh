#!/bin/bash

SSHD_SECONDARY_CONFIG="/etc/ssh/sshd-secondary_config"
SSHD_SECONDARY_SERVICE="/usr/lib/systemd/system/sshd-secondary.service"

### Make a copy of the sshd_config file (to be used by the secondary daemon)
sudo cp /etc/ssh/sshd_config ${SSHD_SECONDARY_CONFIG}

sudo sed -i 's/^Port 22/Port 22022/' ${SSHD_SECONDARY_CONFIG}
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' ${SSHD_SECONDARY_CONFIG}
sudo sed -i 's/^RSAAuthentication yes/RSAAuthentication no/' ${SSHD_SECONDARY_CONFIG}
sudo sed -i 's/^PubkeyAuthentication yes/PubkeyAuthentication no/' ${SSHD_SECONDARY_CONFIG}
sudo sed -i '$ a UseDNS no' ${SSHD_SECONDARY_CONFIG}

### Make a copy of the systemd unit file for the sshd service
sudo cp /usr/lib/systemd/system/sshd.service ${SSHD_SECONDARY_SERVICE}

### Modifying the description
#sudo sed -i 's/^Description=OpenSSH server daemon/Description=OpenSSH server secondary instance daemon/' ${SSHD_SECONDARY_SERVICE}

### Add the -f /etc/ssh/sshd_config_secondary option to sshd, so that the alternative configuration file is used
#sudo sed -i 's/^ExecStart=/usr/sbin/sshd_secondary -D -f /etc/ssh/sshd_config_secondary $OPTIONS/ExecStart=/usr/sbin/sshd -D $OPTIONS/' ${SSHD_SECONDARY_SERVICE}

sudo cp sshd_intermediateFile ${SSHD_SECONDARY_SERVICE}

### If using SELinux, add the port for the second instance of sshd to SSH ports, otherwise the second instance of sshd will be rejected to bind to the port
sudo yum -y install policycoreutils-python
sudo semanage port -a -t ssh_port_t -p tcp 22022

### Run a reload so that systemd can pick up the changes
sudo systemctl daemon-reload

### Start sshd_secondary.service and enable the service, so that it starts automatically upon boot
sudo systemctl enable sshd-secondary.service --now
