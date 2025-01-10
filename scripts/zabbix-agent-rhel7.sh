#Note - This script takes serverip & metadatastring as input at runtime sh script.sh serverip free(env)-string
#!/bin/bash
serverip=$1
metadatastring=$2
tlspskid=$3
tslpskval=$4
rpm -Uvh rpm -Uvh https://repo.zabbix.com/zabbix/7.2/release/alma/9/noarch/zabbix-release-latest-7.2.el9.noarch.rpm
dnf clean all
dnf install zabbix-agent2 zabbix-agent2-plugin-* -y
sed -i -- 's/Server=127.0.0.1/Server='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/ServerActive=127.0.0.1/ServerActive='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agent2.conf
sed -i '/# HostnameItem=system.hostname/a HostnameItem=system.hostname' /etc/zabbix/zabbix_agent2.conf
sed -i '/# HostMetadata=/a HostMetadata=$metadatastring' /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSAccept=unencrypted/a TLSAccept=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSConnect=unencrypted/a TLSConnect=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKIdentity=/a TLSPSKIdentity=$pskidentity' /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKFile=/a TLSPSKFile=/etc/zabbix/zabbix_agent.psk' /etc/zabbix/zabbix_agent2.conf
echo "$tlspskval" >> /etc/zabbix/zabbix_agent2.conf
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
systemctl status zabbix-agent2


