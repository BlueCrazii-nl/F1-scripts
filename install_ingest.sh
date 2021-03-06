#!/bin/bash
rm /etc/netplan/*
touch /etc/netplan/10-config.yaml
tee -a /etc/netplan/10-config.yaml <<EOT
network:
  version: 2
  ethernets:
    eth0:
      gateway4: 192.168.1.1
      addresses: [192.168.1.$1/24]
      nameservers:
        search: []
        addresses: [1.1.1.1, 1.0.0.1]
EOT

netplan apply

export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get install -y \
    build-essential \
    git \
    libpcre3-dev \
    libssl-dev \
    zlib1g-dev

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
tee -a /usr/local/nginx/conf/nginx.conf <<EOT

worker_processes 1;
error_log  /var/log/nginx/error.log;
pid        /run/nginx.pid;
worker_rlimit_nofile 8192;

events {
    worker_connections 4096;
}

rtmp {
    server {
        listen 1935;
        application ingest {
            live on;
            interleave on;
        }
    }
}
EOT

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
systemctl enable --now nginx