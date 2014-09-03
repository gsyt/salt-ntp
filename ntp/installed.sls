{% from "ntp/map.jinja" import ntp with context %}

{% set package = {
  'upgrade': salt['pillar.get']('ntp:package:upgrade', False),
} %}

{% set service = {
  'manage': salt['pillar.get']('ntp:service:manage', False),
  'running': salt['pillar.get']('ntp:service:running', True),
  'enable': salt['pillar.get']('ntp:service:enable', True),
} %}

{% set config = {
  'manage': salt['pillar.get']('ntp:config:manage', False),
  'source': salt['pillar.get']('ntp:config:source', 'salt://ntp/conf/ntp.conf'),
} %}

ntp.installed:
  pkg.{{ 'latest' if package.upgrade else 'installed' }}:
    - name: {{ ntp.package }}
  {% if service.manage -%}
  service.{{ 'running' if service.enable else 'dead' }}:
    - name: {{ ntp.service }}
    - require:
      - pkg: ntp.installed
      - file: ntp.installed
    - watch:
      - pkg: ntp.installed
      - file: ntp.installed
  {% endif -%}
  {% if config.manage %}
  file.managed:
    - name: {{ ntp.config }}
    - source: {{ config.source }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: ntp.installed
  {% endif %}
