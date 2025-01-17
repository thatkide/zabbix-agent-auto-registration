#Note - This script takes serverip & metadatastring as input at runtime sh script.sh serverip free(env)-string  pskid-string pskval-string
#!/bin/bash
serverip=$1
metadatastring=$2
tlspskid=$3
tlspskval=$4
sed -i -- 's/[epel]/a excludepkgs=zabbix*' /etc/yum.repos.d/epel.repo
rpm -Uvh https://repo.zabbix.com/zabbix/7.2/release/rocky/9/noarch/zabbix-release-latest-7.2.el9.noarch.rpm
dnf clean all
dnf install zabbix-agent2 zabbix-agent2-plugin-* -y
sed -i -- 's/Server=127.0.0.1/Server='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/ServerActive=127.0.0.1/ServerActive='$serverip'/g' /etc/zabbix/zabbix_agent2.conf
sed -i -- 's/Hostname=Zabbix server/#Hostname=Zabbix server/g' /etc/zabbix/zabbix_agent2.conf
sed -i '/# HostnameItem=system.hostname/a HostnameItem=system.hostname' /etc/zabbix/zabbix_agent2.conf
sed -i '/# HostMetadata=/a HostMetadata='$metadatastring /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSAccept=unencrypted/a TLSAccept=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSConnect=unencrypted/a TLSConnect=psk'  /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKIdentity=/a TLSPSKIdentity='$tlspskid /etc/zabbix/zabbix_agent2.conf
sed -i '/# TLSPSKFile=/a TLSPSKFile=/etc/zabbix/zabbix_agent.psk' /etc/zabbix/zabbix_agent2.conf
echo $tlspskval >> /etc/zabbix/zabbix_agent.psk
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
systemctl status zabbix-agent2