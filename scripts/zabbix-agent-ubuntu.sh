#Note - This script takes serverip & metadatastring as input at runtime sh script.sh serverip free(env)-string
#!/bin/bash
serverip=$1 # or server ip you can provide
metadatastring=$2
#hostn=$(curl http://169.254.169.254/latest/meta-data/hostname/) #optinal line
#hostnamectl set-hostname $hostn-discovery
#hostnamectl set-hostname $hostn-$metadatastring #optinal line
apt update -y
apt install zabbix-agent
sed -i -- 's/Server=127.0.0.1/Server='$serverip'/g' /etc/zabbix/zabbix_agentd.conf
sed -i -- 's/ServerActive=127.0.0.1/ServerActive='$serverip'/g' /etc/zabbix/zabbix_agentd.conf
sed -i -- 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf
echo "HostMetadata=$metadatastring" >> /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent
systemctl enable zabbix-agent
systemctl status zabbix-agent
#reboot #optinal line

