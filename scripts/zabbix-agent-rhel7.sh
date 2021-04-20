#Note - This script takes serverip & metadatastring as input at runtime sh script.sh internal-dns-name free(env)-string
#!/bin/bash
serverip=$1
metadatastring=$2
#hostn=$(curl http://169.254.169.254/latest/meta-data/hostname/) #optional line
#hostnamectl set-hostname $hostn-$metadatastring #optional line
rpm -Uvh https://repo.zabbix.com/zabbix/5.2/rhel/7/x86_64/zabbix-release-5.2-1.el7.noarch.rpm
yum clean all
yum install zabbix-agent -y
sed -i -- 's/Server=127.0.0.1/Server='$serverip'/g' /etc/zabbix/zabbix_agentd.conf
sed -i -- 's/ServerActive=127.0.0.1/ServerActive='$serverip'/g' /etc/zabbix/zabbix_agentd.conf
sed -i -- 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agentd.conf
echo "HostMetadata=$metadatastring" >> /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent
systemctl enable zabbix-agent
systemctl status zabbix-agent
#reboot #optional line
