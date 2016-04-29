{% from "unitrends/map.jinja" import config with context %}
#add xinetd check or install
package-install-xinetd:
  pkg.installed:
    - pkgs:
      - xinetd

service-xinetd:
  service.running:
    - name: xinetd
    - enable: True
    - require:
      - pkg: package-install-xinetd

package-install-unitrends-linux-agent:
  pkg.installed:
    - sources:
      - unitrends-linux-agent: salt://unitrends/files/{{ config.package }}
    - skip_verify: true

/usr/bp/bpinit/master.ini:
  file.managed:
    - source: salt://unitrends/files/master.ini
    - template: jinja
    - mode: '0644'
    - user: root
    - group: root
