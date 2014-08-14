include:
  - ntp.installed
  
ntp:
  require:
    - sls: ntp.installed
