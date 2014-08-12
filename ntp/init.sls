ntp:
  pkg.latest:
    - name: ntp
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp
      - file: ntp
    - watch:
      - pkg: ntp
      - file: ntp
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://ntp/conf/ntp.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: ntp
