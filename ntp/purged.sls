{% from "ntp/map.jinja" import ntp with context %}

ntp.installed:
  pkg.purged:
    - name: {{ ntp.package }}
