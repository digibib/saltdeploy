##########
# KOHA CREATE STATE
# ONLY FOR NEW BASE!
##########
include:
  - koha.koha-defaults

createkohadb:
  cmd.run:
    - name: koha-create --create-db {{ pillar['koha']['instance'] }}
    - unless: test $(id -u {{ pillar['koha']['instance'] }}-koha)

# increase memory limits on zebra index
/etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg:
  file.replace:
    - name: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
    - pattern: biblios\/(register|shadow):.+$
    - repl: biblios/\1:100G
    - require:
      - cmd: createkohadb

# koha config from template
/etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/koha-conf.xml.tmpl
    - template: jinja
    - require:
      - cmd: createkohadb

# zebra internal password
/etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra.passwd:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/zebra.passwd.tmpl
    - template: jinja
    - require:
      - cmd: createkohadb

# make sure instance config has right permissions
/etc/koha/sites/{{ pillar['koha']['instance'] }}:
  file.directory:
    - group: {{ pillar['koha']['instance'] }}-koha
    - user: {{ pillar['koha']['instance'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml

# make sure instance index has right permissions
/var/lib/koha/{{ pillar['koha']['instance'] }}:
  file.directory:
    - group: {{ pillar['koha']['instance'] }}-koha
    - user: {{ pillar['koha']['instance'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ pillar['koha']['instance'] }}/koha-conf.xml