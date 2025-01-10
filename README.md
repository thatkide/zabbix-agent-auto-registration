# Zabbix Agent Auto Registration Document

This document defines Zabbix Agent Auto Registration.

## Steps -

### 1. Zabbix Agent Auto Regsitration

* [Follow this Link and below steps](https://www.zabbix.com/documentation/current/manual/discovery/auto_registration)
* On Zabbix Server UI Go To **Alerts** --> **Actions** --> **Autoregistration actions** --> **Create Action**
* Name of the action
* Conditions,we are doing registration on the besis of **Host Metadata** --> **Contains** --> Any String(same String you have to pass in agent.conf file)
* Operations --> **Add host** --> **Add to host groups: Linux servers** --> **Link to templates: Docker, Linux by Zabbix agent**
* Update

![Agent Auto Registrations](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/blob/main/img/agent-auto-registrations.png)

### 2. Zabbix Agent Installation

* Take [Script](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/tree/main/scripts) as per server type
* Go to server and execute this script. Script takes four parameters as input.
  * Server Ip
  * String as per environment type (This string will be used for tagging ex - ostype:linux-string)
  * String PSKID (ID used for PSK encryption)
  * String PSKVal (value of PSK)
* After successful execution of the script you should see agent under Hosts option and Availability as Green.

## Important Links

* [Zabbix Manual](https://www.zabbix.com/documentation/current/manual)

#### Supported Version 5.0
