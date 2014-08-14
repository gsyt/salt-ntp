include:
  - ntp.client
  
ntp:
  require:
    - sls: ntp.client
