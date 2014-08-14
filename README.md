salt-ntp
========

Salt formula to set up and configure [ntp](http://www.ntp.org/)

Requirements
------------
The following pillars are available for configuration:
  * ntp:pkg:salt['pillar.get']('os')
  * ntp:svc:salt['pillar.get']('os')
  * ntp:svc:manage
  * ntp:enabled
  * ntp:conf:path
  * ntp:conf:source
  * ntp:conf:servers
  * ntp:conf:allow

Usage
-----
Apply state 'ntp.client' to install ntpd in client mode in target minions
Apply state 'ntp.server' to install ntpd in server mode in target minions
Apply state 'ntp.purged' to remove ntpd from target minions
State 'ntp' is provided as an alias for 'ntp.client'

Compatibility
-------------
Ubuntu 13.10, 14.04 and CentOS 6.x
