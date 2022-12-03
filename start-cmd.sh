#!/bin/sh

echo "[i] Running this script as ROOT shell"

echo "[i] Configuring SSHD to listen on port 60400"
sed -i 's/#Port 22/Port 60400/g' /etc/ssh/sshd_config

echo "[i] Disable Root SSH login"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config

echo "[i] Putting SSHD demon on login"
systemctl enable ssh

echo "[i] Starting SSHD demon"
systemctl start ssh

echo "[i] SSH Started"

echo "[i] Updating and upgrading Kali (this will take a while)"
apt-get update
apt-get dist-upgrade -y

echo "[i] Installing xrdp (this will take a while as well)"
apt-get install -y xorg xrdp

echo "[i] Configuring xrdp to listen to port 60600 (but not starting the service)"
sed -i 's/port=3389/port=60600/g' /etc/xrdp/xrdp.ini

echo "[i] Putting XRDP demon on login"
systemctl enable xrdp

echo "[i] Starting XRDP demons"
systemctl start xrdp
systemctl start xrdp-sesman

echo "[i] Done!!!"