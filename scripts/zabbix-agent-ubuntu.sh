#Note - This script takes serverip & metadatastring as input at runtime sh script.sh serverip free(env)-string
#!/bin/bash
serverip=$1 # or server ip you can provide
metadatastring=$2
tlspskid=$3
tslpskval=$4
wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.2+ubuntu24.04_all.deb
apt update -y
apt install zabbix-agent2 zabbix-agent2-plugin-*
sed -i -- 's/Server=127.0.0.1/Server='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/ServerActive=127.0.0.1/ServerActive='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agent2.conf
sed -i '/'Hostname=Zabbix server'/Hostname=' 
sed -i '/# TLSAccept=unencrypted/a TLSAccept=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSConnect=unencrypted/a TLSConnect=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKIdentity=/a TLSPSKIdentity=$pskidentity' /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKFile=/a TLSPSKFile=$pskfile' /etc/zabbix/zabbix_agent2.conf
echo "HostMetadata=$metadatastring" >> /etc/zabbix/zabbix_agent2.conf
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
systemctl status zabbix-agent2
