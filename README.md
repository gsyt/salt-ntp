salt-ntp
========

Salt formula to set up and configure [ntp](http://www.ntp.org/)

Parameters
------------
Please refer to example.pillar for a list of available pillar configuration options

Usage
-----
- Apply state 'ntp.client' to install ntpd in client mode in target minions
- Apply state 'ntp.server' to install ntpd in server mode in target minions
- Apply state 'ntp.purged' to remove ntpd from target minions
State 'ntp' is provided as an alias for 'ntp.client'

Compatibility
-------------
Ubuntu 13.10, 14.04 and CentOS 6.x
