# Zabbix Agent Auto Registration Document

This document defines Zabbix Agent Auto Registration.

## Steps -

### 1. Zabbix Agent Auto Regsitration

* [Follow this Link and below steps](https://www.zabbix.com/documentation/current/manual/discovery/auto_registration)
* On Zabbix Server UI Go To **Configuration** --> **Actions** --> **Autoregistration actions** --> **Create Action**
* Name of the action
* Conditions,we are doing registration on the besis of **Host Metadata** --> **Contains** --> Any String(same String you have to pass in agent.conf file)
* Operations --> **Add host** --> **Add to host groups: Linux servers** --> **Link to templates: Docker, Linux by Zabbix agent**
* Update

![Agent Auto Registrations](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/blob/main/agent-auto-reg.png)

### 2. Zabbix Agent Installation

* Take [Script](https://github.platforms.engineering/cognitive-systems/mlops/tree/dev/shell_scripts) as per server type
* Go to serve and execute this script. Script takes two parameters as input.
  * Internal Load Balanacer End Point
  * String as per environment type (This string will be used for tagging ex - hostname-string)
* After successful execution of the script you should see agent under Hosts option and Availability as Green.

### 3. Zabbix + Microsoft Teams Alert

* [Follow this Link and below steps](https://www.zabbix.com/integrations/msteams)
* **Administration** --> **General** --> **Macros** --> Add variable --> **macro [{$ZABBIX.URL}] and value [Zabbix UI Url]** --> Update
![Macros](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/blob/main/custom-macros.png)
* **Configuration** --> **Actions** --> **Trigger actions** --> Enable --> **Report problems to Zabbix administrators**
![Enable Admin Alerting](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/blob/main/enable-admin-alerting.png)
* **Administration** --> **Media Type** --> **MS Teams** --> Add Hook --> teams_endpoint[PLACE WEBHOOK URL HERE] --> Update
* **Administration** --> **Users** --> **Admin** --> Media --> Add Media --> Type [MS Teams] --> Send To [your team channel Url] --> **Add and Update**
![Add Media](https://github.com/Shubhamjain6197/zabbix-agent-auto-registration/blob/main/custom-add-media.png)

## Important Links

* [Zabbix Manual](https://www.zabbix.com/documentation/current/manual)
