{%- set os = salt['grains.get']('os') -%}
{%- set pkgnamedefault = { 
  'Ubuntu': 'ntp', 
  'CentOS': 'ntp' } -%}
{%- set pkgname = salt['pillar.get']('ntp:pkg:' ~ os, pkgnamedefault[os]) -%}
{%- set svcnamedefault = {
  'Ubuntu': 'ntp',
  'CentOS': 'ntpd' } -%}
{%- set svcname = salt['pillar.get']('ntp:svc:' ~ os, svcnamedefault[os]) -%}
{%- set svcmanage = salt['pillar.get']('ntp:svc:manage') -%}
{%- set svcenable = salt['pillar.get']('ntp:enable', True) -%}
{%- set confsrc = salt['pillar.get']('ntp:conf:source', 'salt://ntp/conf/client.conf') -%}
{%- set defaultconfname = {
  'Ubuntu': '/etc/ntp.conf',
  'CentOS': '/etc/ntp.conf' } -%}
{%- set confname = salt['pillar.get']('ntp:conf:path', defaultconfname[os]) -%}

ntp.client:
  pkg.latest:
    - name: {{ pkgname }}
{% if svcmanage %}
  service.{{ 'running' if svcenable else 'dead' }}:
    - name: {{ svcname }}
    - enable: {{ svcenable }}
    - require:
      - pkg: ntp.client
      - file: ntp.client
    - watch:
      - pkg: ntp.client
      - file: ntp.client
{% endif %}
  file.managed:
    - name: {{ confname }}
    - source: {{ confsrc }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: ntp.client
