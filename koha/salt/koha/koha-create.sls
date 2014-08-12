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

##########
# KOHA DEFAULT SCHEMA
##########

default_schema:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /usr/share/koha/intranet/cgi-bin/installer/data/mysql/kohastructure.sql
    - require:
      - cmd: createkohadb

default_sysprefs:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /usr/share/koha/intranet/cgi-bin/installer/data/mysql/sysprefs.sql
    - require:
      - cmd: createkohadb

# need to loop this dir /usr/share/koha/intranet/cgi-bin/installer/data/mysql/nb-NO/1-Obligatorisk/
default_sysprefs1:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /usr/share/koha/intranet/cgi-bin/installer/data/mysql/nb-NO/1-Obligatorisk/system_preferences.sql
    - require:
      - cmd: createkohadb

##########
# KOHA CUSTOM SQL
##########

custom_sql:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /tmp/custom.sql
    - require:
      - cmd: createkohadb

custom_sysprefs:
  cmd.run:
    - name: koha-mysql {{ pillar['koha']['instance'] }} < /tmp/sysprefs.sql
    - require:
      - cmd: createkohadb

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

