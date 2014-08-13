##########
# KOHA INSTALL STATE
##########

/etc/koha/koha-sites.conf:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-sites.conf
    - template: jinja
    - context:
      ServerName: {{ pillar['koha']['instance'] }}

/etc/koha/passwd:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/passwd
    - mode: 0600
    - template: jinja
    - context:
      ServerName: {{ pillar['koha']['instance'] }}

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
