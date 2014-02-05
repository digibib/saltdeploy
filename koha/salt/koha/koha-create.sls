##########
# KOHA CREATE STATE
# ONLY FOR NEW BASE!
##########
include:
  - koha.koha-defaults

createkohadb:
  cmd.run:
    - name: koha-create --create-db {{ pillar['kohaname'] }}
    - unless: test $(id -u {{ pillar['kohaname'] }}-koha)

# increase memory limits on zebra index
/etc/koha/sites/{{ pillar['kohaname'] }}/zebra-biblios.cfg:
  file.replace:
    - name: /etc/koha/sites/{{ pillar['kohaname'] }}/zebra-biblios.cfg
    - pattern: biblios\/(register|shadow):.+$
    - repl: biblios/\1:100G
    - require:
      - cmd: createkohadb

# koha config from template
/etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml:
  file.managed:
    - source: {{ pillar['saltfiles'] }}/koha-tmpl/koha-conf.xml.tmpl
    - template: jinja
    - require:
      - cmd: createkohadb

# make sure instance config has right permissions
/etc/koha/sites/{{ pillar['kohaname'] }}:
  file.directory:
    - group: {{ pillar['kohaname'] }}-koha
    - user: {{ pillar['kohaname'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml

# make sure instance index has right permissions
/var/lib/koha/{{ pillar['kohaname'] }}:
  file.directory:
    - group: {{ pillar['kohaname'] }}-koha
    - user: {{ pillar['kohaname'] }}-koha
    - recurse: 
      - group
      - user
    - watch:
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/zebra-biblios.cfg
      - file: /etc/koha/sites/{{ pillar['kohaname'] }}/koha-conf.xml