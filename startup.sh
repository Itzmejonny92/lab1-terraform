#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y ufw fail2ban unattended-upgrades

ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw --force enable

dpkg-reconfigure -f noninteractive unattended-upgrades

systemctl enable fail2ban
systemctl restart fail2ban

echo "Startup script completed at $(date)" > /var/log/startup-complete.log
