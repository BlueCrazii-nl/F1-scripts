#!/bin/bash
rm /etc/netplan/*
touch /etc/netplan/10-config.yaml
tee -a /etc/netplan/10-config.yaml <<EOT
network:
  version: 2
  ethernets:
    eth0:
      gateway4: 10.10.0.1
      addresses: [10.10.4.$1/16]
      nameservers:
        addresses: [10.10.0.1]
EOT

netplan apply

export DEBIAN_FRONTEND=noninteractive
apt update -y && apt-get install -y \
    ffmpeg \
    build-essential \
    git \
    libpcre3-dev \
    libssl-dev \
    zlib1g-dev

mkdir -p /opt/nvidia
cd /opt/nvidia

wget https://us.download.nvidia.com/XFree86/Linux-x86_64/455.28/NVIDIA-Linux-x86_64-455.28.run
chmod +x NVIDIA-Linux-x86_64-455.28.run
./NVIDIA-Linux-x86_64-455.28.run --no-kernel-module --disable-nouveau --ui=none --no-questions

git clone https://github.com/keylase/nvidia-patch.git /opt/nvidia-patch/
cd /opt//nvidia-patch
chmod +x patch.sh
./patch.sh

mkdir -p /opt/nginx-rtmp
cd /opt/nginx-rtmp

git clone https://github.com/arut/nginx-rtmp-module.git rtmp
git clone https://github.com/nginx/nginx.git nginx

cd nginx
./auto/configure --add-module=../rtmp
make
make install

cp /opt/nginx-rtmp/nginx/objs/nginx /usr/local/bin/nginx

rm -f /usr/local/nginx/conf/nginx.conf
mkdir -p /usr/local/nginx/conf/
mkdir -p /var/log/nginx
touch /usr/local/nginx/conf/nginx.conf

rm -f /etc/systemd/system/nginx.service
tee -a /etc/systemd/system/nginx.service <<EOT
[Unit]
Description=NGINX RTMP Server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/local/bin/nginx -t
ExecStart=/usr/local/bin/nginx
ExecReload=/usr/local/bin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
